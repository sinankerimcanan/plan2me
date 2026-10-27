import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/home_widget/data/home_widget_sync.dart';
import 'package:plan2me/features/home_widget/data/widget_snapshot_builder.dart';
import 'package:plan2me/features/home_widget/domain/widget_snapshot.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/l10n/app_localizations.dart';

import '../../helpers.dart';

ProjectOverview _o(
  String id,
  Priority p,
  ProjectStatus s, {
  DateTime? due,
  int done = 0,
  int total = 0,
}) => ProjectOverview(
  project: Project(
    id: id,
    title: id,
    priority: p,
    status: s,
    dueDate: due,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
  doneCards: done,
  totalCards: total,
);

class FakeBridge implements WidgetBridge {
  final published = <String>[];
  @override
  Future<void> publish(String json) async => published.add(json);
}

void main() {
  final l10n = lookupAppLocalizations(const Locale('tr'));
  final today = DateTime.utc(2026, 10, 27);

  test('kapalı projeler dışlanır; gecikmiş ve yüksek öncelik önce gelir', () {
    final s = buildWidgetSnapshot(
      l10n: l10n,
      today: today,
      upcoming: const [],
      overviews: [
        _o(
          'dusuk',
          Priority.low,
          ProjectStatus.planned,
          due: DateTime.utc(2026, 10, 30),
        ),
        _o(
          'kritik',
          Priority.critical,
          ProjectStatus.inProgress,
          done: 1,
          total: 4,
        ),
        _o(
          'gecikmis',
          Priority.low,
          ProjectStatus.planned,
          due: DateTime.utc(2026, 10, 20),
        ),
        _o('bitti', Priority.critical, ProjectStatus.done),
      ],
    );
    expect(s.projects.map((p) => p.id), ['gecikmis', 'kritik', 'dusuk']);
    expect(s.stats.active, 3);
    expect(s.stats.inProgress, 1);
    expect(s.stats.openCards, 3);
    expect(s.activeDueDates, ['2026-10-30', '2026-10-20']);
    expect(s.projects[1].priorityLabel, 'Kritik');
    expect(s.projects[1].statusLabel, 'Devam ediyor');
    expect(s.projects[1].priorityColor, matches(RegExp(r'^#[0-9A-F]{6}$')));
  });

  test('JSON Swift tarafının beklediği anahtarları içerir', () {
    final s = buildWidgetSnapshot(
      l10n: l10n,
      today: today,
      overviews: [
        _o(
          'a',
          Priority.high,
          ProjectStatus.planned,
          due: DateTime.utc(2026, 11, 1),
        ),
      ],
      upcoming: [
        UpcomingCard(
          cardId: 'c',
          projectId: 'a',
          projectTitle: 'A',
          title: 'Kart',
          priority: Priority.high,
          dueDate: DateTime.utc(2026, 10, 28),
        ),
      ],
    );
    final json = jsonDecode(jsonEncode(s.toJson())) as Map<String, dynamic>;
    expect(
      json.keys,
      containsAll([
        'v',
        'generatedAt',
        'stats',
        'activeDueDates',
        'projects',
        'cards',
      ]),
    );
    expect((json['projects'] as List).first, containsPair('due', '2026-11-01'));
    expect((json['cards'] as List).first, containsPair('due', '2026-10-28'));
    expect(WidgetSnapshot.fromJson(json).cards.single.title, 'Kart');
  });

  test('senkron servisi veri değişince widget\'a yayınlar, aynı veride tekrar yazmaz', () async {
    final db = memoryDb();
    final bridge = FakeBridge();
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        widgetBridgeProvider.overrideWithValue(bridge),
      ],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });

    // Riverpod 3: dinleyicisi olmayan provider duraklatılır; listen ile canlı tut.
    container.listen(homeWidgetSyncProvider, (_, _) {});
    await Future<void>.delayed(HomeWidgetSync.debounce * 2);
    expect(bridge.published, hasLength(1));

    final id = await container
        .read(projectRepositoryProvider)
        .create(const ProjectDraft(title: 'Yeni'), defaultColumns: ['A', 'B']);
    await Future<void>.delayed(HomeWidgetSync.debounce * 2);
    expect(bridge.published, hasLength(2));
    expect(bridge.published.last, contains('"Yeni"'));

    // Kart eklemek projenin kart sayısını değiştirir → yeni yayın.
    final col =
        (await container.read(boardRepositoryProvider).watchBoard(id).first)
            .lanes
            .first
            .column
            .id;
    await container.read(boardRepositoryProvider).addCard(col, 'k');
    await Future<void>.delayed(HomeWidgetSync.debounce * 2);
    expect(bridge.published, hasLength(3));

    // Aynı veriyle tetiklenirse tekrar yazmaz.
    container.invalidate(projectOverviewsProvider);
    await Future<void>.delayed(HomeWidgetSync.debounce * 2);
    expect(bridge.published, hasLength(3));
  });
}
