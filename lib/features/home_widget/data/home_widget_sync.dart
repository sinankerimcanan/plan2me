import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../board/data/board_providers.dart';
import '../../board/domain/board_repository.dart';
import '../../projects/data/projects_providers.dart';
import 'widget_snapshot_builder.dart';

part 'home_widget_sync.g.dart';

/// Widget'a veri yayınlayan platform köprüsü (testlerde sahtesi verilir).
abstract interface class WidgetBridge {
  Future<void> publish(String snapshotJson);

  /// Widget'tan (iOS App Intent) tamamlanan kart id'lerini alır ve listeyi boşaltır.
  Future<List<String>> takePendingCompletions();
}

/// iOS WidgetKit köprüsü. App Group ve kind, Xcode tarafıyla aynı olmalı.
class HomeWidgetBridge implements WidgetBridge {
  static const appGroupId = 'group.krx.plan2me.app';
  static const iOSWidgetKinds = ['Plan2meWidget', 'Plan2meTasksWidget'];
  static const snapshotKey = 'snapshot';
  static const pendingCompletionsKey = 'pendingCompletions';

  static Future<void> initialize() => HomeWidget.setAppGroupId(appGroupId);

  @override
  Future<void> publish(String snapshotJson) async {
    await HomeWidget.saveWidgetData<String>(snapshotKey, snapshotJson);
    for (final kind in iOSWidgetKinds) {
      await HomeWidget.updateWidget(iOSName: kind);
    }
  }

  @override
  Future<List<String>> takePendingCompletions() async {
    final raw = await HomeWidget.getWidgetData<String>(pendingCompletionsKey);
    if (raw == null || raw.isEmpty) return const [];
    await HomeWidget.saveWidgetData<String>(pendingCompletionsKey, null);
    try {
      return [for (final id in jsonDecode(raw) as List) id as String];
    } catch (_) {
      return const [];
    }
  }
}

/// Şimdilik sadece iOS'ta widget var; diğer platformlarda null.
@Riverpod(keepAlive: true)
WidgetBridge? widgetBridge(Ref ref) =>
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
    ? HomeWidgetBridge()
    : null;

/// Proje ve kart verisini izler; değişince (kısa gecikmeyle) widget'ı günceller.
/// Mutlaka `listen` ile canlı tutulmalı (Riverpod 3 dinleyicisiz provider'ı duraklatır).
@Riverpod(keepAlive: true)
class HomeWidgetSync extends _$HomeWidgetSync {
  static const debounce = Duration(milliseconds: 400);

  Timer? _timer;
  String? _lastPublished;

  @override
  void build() {
    final bridge = ref.watch(widgetBridgeProvider);
    if (bridge == null) return;
    ref.listen(
      projectOverviewsProvider,
      (_, _) => _schedule(bridge),
      fireImmediately: true,
    );
    ref.listen(
      upcomingCardsProvider,
      (_, _) => _schedule(bridge),
      fireImmediately: true,
    );
    ref.onDispose(() => _timer?.cancel());
  }

  /// Widget'tan tamamlanan görevleri veritabanına işler (açılışta ve öne gelişte).
  /// Silinmiş ya da zaten tamamlanmış kartlar sessizce atlanır.
  Future<int> processPendingCompletions() async {
    final bridge = ref.read(widgetBridgeProvider);
    if (bridge == null) return 0;
    final ids = await bridge.takePendingCompletions();
    final board = ref.read(boardRepositoryProvider);
    var done = 0;
    for (final id in ids) {
      try {
        await board.completeCard(id);
        done++;
      } on BoardRuleException {
        // kart silinmiş
      }
    }
    return done;
  }

  void _schedule(WidgetBridge bridge) {
    _timer?.cancel();
    _timer = Timer(debounce, () => _publish(bridge));
  }

  Future<void> _publish(WidgetBridge bridge) async {
    final overviews = ref.read(projectOverviewsProvider).value;
    final upcoming = ref.read(upcomingCardsProvider).value;
    if (overviews == null || upcoming == null) return;
    final snapshot = buildWidgetSnapshot(
      overviews: overviews,
      upcoming: upcoming,
      l10n: lookupAppLocalizations(const Locale('tr')),
      today: today(),
    );
    // generatedAt hariç aynıysa tekrar yazma (gereksiz widget yenilemesi olmasın).
    final comparable = jsonEncode(snapshot.copyWith(generatedAt: '').toJson());
    if (comparable == _lastPublished) return;
    _lastPublished = comparable;
    try {
      await bridge.publish(jsonEncode(snapshot.toJson()));
    } catch (e, st) {
      debugPrint('Widget güncellenemedi: $e\n$st');
    }
  }
}
