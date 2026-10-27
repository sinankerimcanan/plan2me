import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/calendar_sync/data/calendar_sync_providers.dart';
import 'package:plan2me/features/calendar_sync/data/device_calendar_gateway.dart';
import 'package:plan2me/features/calendar_sync/domain/calendar_sync_plan.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/settings/presentation/theme_mode_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

/// Bellekte telefon takvimi.
class FakeCalendar implements DeviceCalendarGateway {
  bool access = true;
  final calendars = <String>{};
  final events = <String, (String? calendarId, CalendarEventSpec spec)>{};
  var _seq = 0;

  List<CalendarEventSpec> inCalendar(String? id) => [
    for (final e in events.values)
      if (e.$1 == id) e.$2,
  ];

  @override
  Future<bool> hasFullAccess() async => access;
  @override
  Future<bool> requestFullAccess() async => access;
  @override
  Future<String?> ensureCalendar({
    String? knownId,
    required String name,
    required String colorHex,
  }) async {
    if (knownId != null && calendars.contains(knownId)) return knownId;
    final id = 'cal${++_seq}';
    calendars.add(id);
    return id;
  }

  @override
  Future<void> deleteCalendar(String id) async {
    calendars.remove(id);
    events.removeWhere((_, e) => e.$1 == id);
  }

  @override
  Future<String> createAllDayEvent(
    CalendarEventSpec spec, {
    String? calendarId,
  }) async {
    final id = 'ev${++_seq}';
    events[id] = (calendarId, spec);
    return id;
  }

  @override
  Future<void> deleteEvent(String eventId) async => events.remove(eventId);
  @override
  Future<List<DeviceEvent>> listEvents(
    DateTime start,
    DateTime end, {
    String? excludeCalendarId,
  }) async => const [];
  @override
  Future<void> openEvent(String instanceId) async {}
}

void main() {
  late FakeCalendar cal;
  late ProviderContainer c;
  late String pid;
  late String col;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = memoryDb();
    cal = FakeCalendar();
    c = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
        deviceCalendarGatewayProvider.overrideWithValue(cal),
      ],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      c.dispose();
      await db.close();
    });
    c.listen(calendarSyncProvider, (_, _) {});
    pid = await c
        .read(projectRepositoryProvider)
        .create(
          ProjectDraft(title: 'Site', dueDate: DateTime.utc(2026, 12, 1)),
          defaultColumns: ['A', 'Bitti'],
        );
    col = (await c.read(boardRepositoryProvider).watchBoard(pid).first)
        .lanes
        .first
        .column
        .id;
  });

  Future<void> settle() => Future<void>.delayed(CalendarSync.debounce * 2);

  test(
    'açınca plan2me takvimi oluşur, görev ve proje teslimi yazılır',
    () async {
      final board = c.read(boardRepositoryProvider);
      await board.addCard(
        col,
        'Tarihli',
        initial: CardPatch(dueDate: DateTime.utc(2026, 11, 3)),
      );
      await board.addCard(col, 'Tarihsiz');
      expect(
        await c
            .read(calendarSyncSettingsControllerProvider.notifier)
            .setEnabled(true),
        isTrue,
      );
      await settle();

      final calId = c.read(calendarSyncSettingsControllerProvider).calendarId!;
      expect(cal.inCalendar(calId).map((s) => s.title).toSet(), {
        'Tarihli',
        'Proje teslimi: Site',
      });
    },
  );

  test('başlık/tarih değişince yenilenir, tamamlanınca kaldırılır', () async {
    final board = c.read(boardRepositoryProvider);
    final k = await board.addCard(
      col,
      'Görev',
      initial: CardPatch(dueDate: DateTime.utc(2026, 11, 3)),
    );
    await c
        .read(calendarSyncSettingsControllerProvider.notifier)
        .setEnabled(true);
    await settle();
    final calId = c.read(calendarSyncSettingsControllerProvider).calendarId!;

    await board.updateCard(
      k,
      CardPatch(title: 'Yeni ad', dueDate: DateTime.utc(2026, 11, 5)),
    );
    await settle();
    final task = cal.inCalendar(calId).firstWhere((s) => s.key == 'card:$k');
    expect((task.title, task.date), ('Yeni ad', DateTime.utc(2026, 11, 5)));
    expect(cal.events, hasLength(2));

    await board.completeCard(k);
    await settle();
    expect(cal.inCalendar(calId).map((s) => s.key), ['project:$pid']);
  });

  test(
    'kullanıcı plan2me takvimini silerse yeniden oluşturulup baştan yazılır',
    () async {
      await c
          .read(calendarSyncSettingsControllerProvider.notifier)
          .setEnabled(true);
      await settle();
      final first = c.read(calendarSyncSettingsControllerProvider).calendarId!;
      await cal.deleteCalendar(first);

      await c.read(calendarSyncProvider.notifier).syncNow();
      final second = c.read(calendarSyncSettingsControllerProvider).calendarId!;
      expect(second, isNot(first));
      expect(cal.inCalendar(second).single.key, 'project:$pid');
    },
  );

  test('kapatınca takvim ve eşleşmeler silinir; izin yoksa açılmaz', () async {
    await c
        .read(calendarSyncSettingsControllerProvider.notifier)
        .setEnabled(true);
    await settle();
    await c
        .read(calendarSyncSettingsControllerProvider.notifier)
        .setEnabled(false);
    await c.read(calendarSyncProvider.notifier).waitForTeardown();
    expect(cal.calendars, isEmpty);
    expect(cal.events, isEmpty);
    expect(await c.read(calendarLinkStoreProvider).readAll(), isEmpty);
    expect(c.read(calendarSyncSettingsControllerProvider).calendarId, isNull);

    cal.access = false;
    expect(
      await c
          .read(calendarSyncSettingsControllerProvider.notifier)
          .setEnabled(true),
      isFalse,
    );
    expect(c.read(calendarSyncSettingsControllerProvider).enabled, isFalse);
  });
}
