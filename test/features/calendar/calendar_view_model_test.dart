import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/calendar/presentation/calendar_view_model.dart';
import 'package:plan2me/features/calendar_sync/data/device_calendar_gateway.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/tasks/data/tasks_providers.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';

import '../../helpers.dart';

void main() {
  test('görevler ve açık proje teslimleri günlerine yerleşir', () async {
    final db = memoryDb();
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    final day = DateTime.utc(2026, 11, 10);
    final projects = container.read(projectRepositoryProvider);
    await projects.create(
      ProjectDraft(title: 'Teslim', dueDate: day),
      defaultColumns: ['A', 'B'],
    );
    await projects.create(
      ProjectDraft(title: 'Bitti', dueDate: day, status: ProjectStatus.done),
      defaultColumns: ['A', 'B'],
    );
    await container
        .read(taskRepositoryProvider)
        .addTask(
          QuickTaskInput(title: 'Görev', dueDate: day),
          inboxTitle: 'Gelen kutusu',
          defaultColumns: ['A', 'B'],
        );
    await container
        .read(taskRepositoryProvider)
        .addTask(
          const QuickTaskInput(title: 'Tarihsiz'),
          inboxTitle: 'Gelen kutusu',
          defaultColumns: ['A', 'B'],
        );

    final sub = container.listen(calendarViewModelProvider, (_, _) {});
    addTearDown(sub.close);
    Map<DateTime, DayAgenda>? events;
    for (var i = 0; i < 50 && events == null; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
      events = container.read(calendarViewModelProvider).value;
    }
    expect(events!.keys, [day]);
    final agenda = events[day]!;
    expect(agenda.tasks.single.card.title, 'Görev');
    expect(
      agenda.projects.single.project.title,
      'Teslim',
    ); // kapalı proje dışarıda
  });

  test('controller gün seçimi ve bugüne dönüş', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final ctrl = container.read(calendarControllerProvider.notifier);
    ctrl.select(DateTime(2026, 3, 5, 14), DateTime(2026, 3, 5));
    expect(
      container.read(calendarControllerProvider).selectedDay,
      DateTime.utc(2026, 3, 5),
    );
    ctrl.goToday();
    final now = DateTime.now();
    expect(
      container.read(calendarControllerProvider).selectedDay,
      DateTime.utc(now.year, now.month, now.day),
    );
  });

  group('eventDays', () {
    DeviceEvent ev(DateTime start, DateTime end, {bool allDay = false}) =>
        DeviceEvent(
          instanceId: 'i',
          calendarId: 'c',
          title: 't',
          start: start,
          end: end,
          allDay: allDay,
        );

    test('saatli tek günlük etkinlik kendi gününde', () {
      expect(
        eventDays(ev(DateTime(2026, 11, 3, 9), DateTime(2026, 11, 3, 10))),
        [DateTime.utc(2026, 11, 3)],
      );
    });

    test('tüm gün etkinlikte bitiş günü dahil değil', () {
      expect(
        eventDays(
          ev(DateTime(2026, 11, 3), DateTime(2026, 11, 5), allDay: true),
        ),
        [DateTime.utc(2026, 11, 3), DateTime.utc(2026, 11, 4)],
      );
    });

    test('gece yarısını geçen etkinlik iki güne yayılır, tam gece yarısı biten yayılmaz', () {
      expect(
        eventDays(ev(DateTime(2026, 11, 3, 22), DateTime(2026, 11, 4, 1)))
            .length,
        2,
      );
      expect(eventDays(ev(DateTime(2026, 11, 3, 22), DateTime(2026, 11, 4))), [
        DateTime.utc(2026, 11, 3),
      ]);
    });
  });
}
