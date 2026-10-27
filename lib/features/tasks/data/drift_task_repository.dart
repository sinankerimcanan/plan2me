import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/enums.dart';
import '../../../core/utils/clock.dart';
import '../../board/data/drift_board_repository.dart';
import '../../board/domain/board_models.dart';
import '../../board/domain/board_repository.dart';
import '../../people/data/drift_person_repository.dart';
import '../../projects/domain/project_repository.dart';
import '../domain/task_item.dart';
import '../domain/task_repository.dart';

class DriftTaskRepository implements TaskRepository {
  DriftTaskRepository(
    this._db, {
    required this._board,
    required this._projects,
    this._clock = systemClock,
  });

  final AppDatabase _db;
  final BoardRepository _board;
  final ProjectRepository _projects;
  final Clock _clock;

  @override
  Stream<List<TaskItem>> watchTasks({int completedDays = 7}) =>
      _db.watchTables([
        _db.cards,
        _db.projects,
        _db.boardColumns,
        _db.persons,
        _db.labels,
        _db.cardLabels,
        _db.checklistItems,
      ], () => _load(completedDays));

  Future<List<TaskItem>> _load(int completedDays) async {
    final c = _db.cards, p = _db.projects, col = _db.boardColumns;
    final since = _clock().subtract(Duration(days: completedDays));
    final rows =
        await (_db.select(c).join([
              innerJoin(p, p.id.equalsExp(c.projectId)),
              innerJoin(col, col.id.equalsExp(c.columnId)),
            ])..where(
              c.deletedAt.isNull() &
                  p.deletedAt.isNull() &
                  col.deletedAt.isNull() &
                  p.status.isNotInValues(const [
                    ProjectStatus.done,
                    ProjectStatus.cancelled,
                  ]) &
                  (c.completedAt.isNull() |
                      c.completedAt.isBiggerOrEqualValue(since)),
            ))
            .get();
    if (rows.isEmpty) return const [];

    final cardIds = [for (final r in rows) r.readTable(c).id];
    final people = {
      for (final r in await (_db.select(
        _db.persons,
      )..where((t) => t.deletedAt.isNull())).get())
        r.id: personFromRow(r),
    };
    final labelsById = {
      for (final r in await (_db.select(
        _db.labels,
      )..where((t) => t.deletedAt.isNull())).get())
        r.id: labelFromRow(r),
    };
    final cardLabels = <String, List<Label>>{};
    for (final link in await (_db.select(
      _db.cardLabels,
    )..where((t) => t.cardId.isIn(cardIds) & t.deletedAt.isNull())).get()) {
      final l = labelsById[link.labelId];
      if (l != null) (cardLabels[link.cardId] ??= []).add(l);
    }
    final checklist = <String, (int, int)>{};
    for (final r
        in await _db
            .customSelect(
              'SELECT card_id, COUNT(*) AS total, SUM(CASE WHEN is_done THEN 1 ELSE 0 END) AS done '
              'FROM checklist_items WHERE deleted_at IS NULL GROUP BY card_id',
              readsFrom: {_db.checklistItems},
            )
            .get()) {
      checklist[r.read<String>('card_id')] = (
        r.read<int>('total'),
        r.read<int>('done'),
      );
    }

    final items = [
      for (final r in rows)
        () {
          final card = r.readTable(c);
          final project = r.readTable(p);
          return TaskItem(
            card: cardFromRow(card),
            projectTitle: project.title,
            isInbox: project.isInbox,
            columnName: r.readTable(col).name,
            assignee: card.assigneePersonId == null
                ? null
                : people[card.assigneePersonId],
            labels: cardLabels[card.id] ?? const [],
            checklistTotal: checklist[card.id]?.$1 ?? 0,
            checklistDone: checklist[card.id]?.$2 ?? 0,
          );
        }(),
    ];
    // Tarihliler önce (yakın tarih önce), sonra öncelik, sonra başlık.
    items.sort((a, b) {
      final da = a.card.dueDate, db = b.card.dueDate;
      if (da != db) {
        if (da == null) return 1;
        if (db == null) return -1;
        return da.compareTo(db);
      }
      final pr = b.card.priority.weight.compareTo(a.card.priority.weight);
      if (pr != 0) return pr;
      return a.card.title.toLowerCase().compareTo(b.card.title.toLowerCase());
    });
    return items;
  }

  @override
  Future<String> addTask(
    QuickTaskInput input, {
    required String inboxTitle,
    required List<String> defaultColumns,
  }) async {
    final projectId =
        input.projectId ??
        await _projects.ensureInbox(title: inboxTitle, columns: defaultColumns);
    final columns =
        await (_db.select(_db.boardColumns)
              ..where(
                (t) => t.projectId.equals(projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final target =
        columns.where((c) => !c.isDoneColumn).firstOrNull ??
        columns.firstOrNull;
    if (target == null) throw BoardRuleException('Projede sütun yok');
    return _board.addCard(
      target.id,
      input.title,
      initial: input.extra.copyWith(
        dueDate: input.dueDate == null ? null : dateOnly(input.dueDate!),
      ),
    );
  }
}
