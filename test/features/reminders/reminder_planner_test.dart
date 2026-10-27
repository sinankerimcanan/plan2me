import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/reminders/domain/reminder_planner.dart';
import 'package:plan2me/features/reminders/domain/reminder_settings.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';
import 'package:plan2me/l10n/app_localizations.dart';

TaskItem task(String id, DateTime? due, {bool done = false}) => TaskItem(
  card: KanbanCard(
    id: id,
    projectId: 'p',
    columnId: 'c',
    title: 'Görev $id',
    position: 1,
    dueDate: due,
    completedAt: done ? DateTime.utc(2026) : null,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
  projectTitle: 'Site',
  columnName: 'A',
);

ProjectOverview project(
  String id,
  DateTime? due, {
  ProjectStatus status = ProjectStatus.inProgress,
}) => ProjectOverview(
  project: Project(
    id: id,
    title: 'Proje $id',
    dueDate: due,
    status: status,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
);

void main() {
  final l10n = lookupAppLocalizations(const Locale('tr'));
  final now = DateTime(2026, 10, 27, 8, 0); // sabah 08:00, bildirim saati 09:00
  const on = ReminderSettings(enabled: true, dailyDigest: false);

  test('kapalıyken hiçbir şey planlanmaz', () {
    expect(
      planReminders(
        tasks: [task('1', DateTime.utc(2026, 10, 28))],
        projects: const [],
        settings: const ReminderSettings(),
        now: now,
        l10n: l10n,
      ),
      isEmpty,
    );
  });

  test('görev için son gün ve bir gün önce, seçilen saatte; geçmiş/tamamlanan atlanır', () {
    final r = planReminders(
      tasks: [
        task('1', DateTime.utc(2026, 10, 29)),
        task(
          '2',
          DateTime.utc(2026, 10, 20),
        ), // gecikmiş: geçmiş saatler planlanmaz
        task('3', DateTime.utc(2026, 10, 29), done: true),
        task('4', null),
      ],
      projects: const [],
      settings: on,
      now: now,
      l10n: l10n,
    );
    expect(r.map((e) => (e.when, e.title)), [
      (DateTime(2026, 10, 28, 9), 'Yarın: Görev 1'),
      (DateTime(2026, 10, 29, 9), 'Bugün: Görev 1'),
    ]);
    expect(r.first.route, '/cards/1');
    expect(r.first.body, 'Site');
  });

  test('bugünkü saat geçtiyse bugünün hatırlatması kurulmaz', () {
    final r = planReminders(
      tasks: [task('1', DateTime.utc(2026, 10, 27))],
      projects: const [],
      settings: on,
      now: DateTime(2026, 10, 27, 10),
      l10n: l10n,
    );
    expect(r, isEmpty);
  });

  test('proje teslimleri; kapalı projeler hariç', () {
    final r = planReminders(
      tasks: const [],
      projects: [
        project('a', DateTime.utc(2026, 10, 28)),
        project('b', DateTime.utc(2026, 10, 28), status: ProjectStatus.done),
      ],
      settings: on.copyWith(dayBefore: false),
      now: now,
      l10n: l10n,
    );
    expect(r.single.title, 'Proje teslimi bugün: Proje a');
    expect(r.single.route, '/projects/a');
  });

  test(
    'günlük özet: o günün görevleri + bugün için gecikmişler tek bildirimde',
    () {
      final r = planReminders(
        tasks: [
          task('g', DateTime.utc(2026, 10, 25)),
          for (var i = 0; i < 4; i++) task('t$i', DateTime.utc(2026, 10, 27)),
          task('y', DateTime.utc(2026, 10, 30)),
        ],
        projects: const [],
        settings: const ReminderSettings(enabled: true, dayBefore: false),
        now: now,
        l10n: l10n,
      );
      expect(r.map((e) => e.title), [
        'Bugün 5 görevin var',
        'Bugün 1 görevin var',
      ]);
      expect(r.first.when, DateTime(2026, 10, 27, 9));
      expect(r.first.body, contains('ve 2 görev daha'));
      expect(r.first.route, '/tasks');
    },
  );

  test('en fazla 60 bildirim, en yakınlar önce', () {
    final r = planReminders(
      tasks: [
        for (var i = 1; i <= 80; i++)
          task('$i', DateTime.utc(2026, 11, 1).add(Duration(days: i))),
      ],
      projects: const [],
      settings: on,
      now: now,
      l10n: l10n,
    );
    expect(r, hasLength(kMaxScheduledReminders));
    expect(r.first.when.isBefore(r.last.when), isTrue);
  });
}
