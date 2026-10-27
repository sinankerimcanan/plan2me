import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/tasks/data/drift_task_repository.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late DriftBoardRepository board;
  late DriftProjectRepository projects;
  late DriftTaskRepository tasks;
  const cols = ['Yapılacak', 'Devam', 'Bitti'];

  setUp(() {
    db = memoryDb();
    final clock = fakeClock(DateTime.now().toUtc());
    board = DriftBoardRepository(db, clock: clock);
    projects = DriftProjectRepository(db, clock: clock);
    tasks = DriftTaskRepository(
      db,
      board: board,
      projects: projects,
      clock: clock,
    );
  });
  tearDown(() => db.close());

  test('projesiz görev Gelen kutusuna gider; Gelen kutusu proje listesinde görünmez', () async {
    final id = await tasks.addTask(
      QuickTaskInput(title: 'Faturayı öde', dueDate: DateTime(2026, 11, 3)),
      inboxTitle: 'Gelen kutusu',
      defaultColumns: cols,
    );
    final second = await tasks.addTask(
      const QuickTaskInput(title: 'İkinci'),
      inboxTitle: 'Gelen kutusu',
      defaultColumns: cols,
    );
    final list = await tasks.watchTasks().first;
    expect(list.map((t) => t.card.id), containsAll([id, second]));
    expect(list.every((t) => t.isInbox), isTrue);
    expect(list.first.card.dueDate, DateTime.utc(2026, 11, 3));
    expect(await projects.watchOverviews().first, isEmpty);
    // Tek bir gelen kutusu oluşur.
    final inboxes = await (db.select(
      db.projects,
    )..where((t) => t.isInbox.equals(true))).get();
    expect(inboxes, hasLength(1));
  });

  test('tamamla / geri aç tamamlanma sütununu kullanır', () async {
    final pid = await projects.create(
      const ProjectDraft(title: 'P'),
      defaultColumns: cols,
    );
    final id = await tasks.addTask(
      QuickTaskInput(title: 'Görev', projectId: pid),
      inboxTitle: 'x',
      defaultColumns: cols,
    );
    await board.completeCard(id);
    var t = (await tasks.watchTasks().first).single;
    expect(t.isCompleted, isTrue);
    expect(t.columnName, 'Bitti');
    expect(t.group(), TaskGroup.completed);
    await board.reopenCard(id);
    t = (await tasks.watchTasks().first).single;
    expect(t.isCompleted, isFalse);
    expect(t.columnName, 'Yapılacak');
  });

  test('gruplama bugüne göre yapılır', () {
    final ref = DateTime.utc(2026, 10, 27);
    TaskItem t(DateTime? due) => TaskItem(
      card: KanbanCard(
        id: 'x',
        projectId: 'p',
        columnId: 'c',
        title: 't',
        position: 1,
        dueDate: due,
        createdAt: ref,
        updatedAt: ref,
      ),
      projectTitle: 'P',
      columnName: 'A',
    );
    expect(t(DateTime.utc(2026, 10, 26)).group(ref), TaskGroup.overdue);
    expect(t(DateTime.utc(2026, 10, 27)).group(ref), TaskGroup.today);
    expect(t(DateTime.utc(2026, 10, 28)).group(ref), TaskGroup.tomorrow);
    expect(t(DateTime.utc(2026, 11, 3)).group(ref), TaskGroup.thisWeek);
    expect(t(DateTime.utc(2026, 11, 10)).group(ref), TaskGroup.later);
    expect(t(null).group(ref), TaskGroup.noDate);
  });
}
