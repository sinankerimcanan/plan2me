import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/core/domain/place.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/calendar_sync/domain/calendar_sync_plan.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';
import 'package:plan2me/l10n/app_localizations.dart';

TaskItem task(
  String id,
  DateTime? due, {
  bool done = false,
  bool inbox = false,
  Place? place,
  String? desc,
}) => TaskItem(
  card: KanbanCard(
    id: id,
    projectId: 'p',
    columnId: 'c',
    title: 'Görev $id',
    description: desc,
    position: 1,
    dueDate: due,
    location: place,
    completedAt: done ? DateTime.utc(2026) : null,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
  projectTitle: 'Site',
  isInbox: inbox,
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
  final d = DateTime.utc(2026, 11, 3);

  test(
    'yalnızca tarihli açık görevler ve açık proje teslimleri etkinlik olur',
    () {
      final specs = plannedCalendarEvents(
        l10n: l10n,
        tasks: [
          task(
            '1',
            d,
            place: const Place(name: 'Ofis'),
            desc: 'Notlar',
          ),
          task('2', d, inbox: true),
          task('3', d, done: true),
          task('4', null),
        ],
        projects: [
          project('a', d),
          project('b', d, status: ProjectStatus.cancelled),
          project('c', null),
        ],
      );
      expect(specs.map((s) => s.key), ['card:1', 'card:2', 'project:a']);
      final first = specs.first;
      expect(first.location, 'Ofis');
      expect(first.description, 'Notlar\n\nSite · plan2me');
      expect(first.url, 'plan2me://app/cards/1');
      expect(specs[1].description, 'Gelen kutusu · plan2me');
      expect(specs[2].title, 'Proje teslimi: Proje a');
    },
  );

  test('fark: yeni olan yazılır, değişen yenilenir, kalkan silinir, aynısı dokunulmaz', () {
    final same = CalendarEventSpec(
      key: 'card:same',
      title: 'A',
      date: d,
      url: 'u',
    );
    final changed = CalendarEventSpec(
      key: 'card:changed',
      title: 'Yeni başlık',
      date: d,
      url: 'u',
    );
    final fresh = CalendarEventSpec(
      key: 'card:new',
      title: 'C',
      date: d,
      url: 'u',
    );
    final diff = diffCalendar(
      [same, changed, fresh],
      {
        'card:same': (eventId: 'e1', signature: same.signature),
        'card:changed': (eventId: 'e2', signature: 'eski'),
        'card:gone': (eventId: 'e3', signature: 'x'),
      },
    );
    expect(diff.create.map((s) => s.key), ['card:new']);
    expect(diff.replace.single.$2, 'e2');
    expect(diff.remove, {'card:gone': 'e3'});
    expect(
      diffCalendar(
        [same],
        {'card:same': (eventId: 'e1', signature: same.signature)},
      ).isEmpty,
      isTrue,
    );
  });

  test('tarih değişince imza değişir', () {
    final a = CalendarEventSpec(key: 'k', title: 'T', date: d, url: 'u');
    expect(
      a.signature,
      isNot(a.copyWith(date: d.add(const Duration(days: 1))).signature),
    );
  });
}
