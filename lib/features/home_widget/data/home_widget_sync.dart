import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../board/data/board_providers.dart';
import '../../projects/data/projects_providers.dart';
import 'widget_snapshot_builder.dart';

part 'home_widget_sync.g.dart';

/// Widget'a veri yayınlayan platform köprüsü (testlerde sahtesi verilir).
abstract interface class WidgetBridge {
  Future<void> publish(String snapshotJson);
}

/// iOS WidgetKit köprüsü. App Group ve kind, Xcode tarafıyla aynı olmalı.
class HomeWidgetBridge implements WidgetBridge {
  static const appGroupId = 'group.krx.plan2me.app';
  static const iOSWidgetKind = 'Plan2meWidget';
  static const snapshotKey = 'snapshot';

  static Future<void> initialize() => HomeWidget.setAppGroupId(appGroupId);

  @override
  Future<void> publish(String snapshotJson) async {
    await HomeWidget.saveWidgetData<String>(snapshotKey, snapshotJson);
    await HomeWidget.updateWidget(iOSName: iOSWidgetKind);
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
