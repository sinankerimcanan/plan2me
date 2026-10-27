import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/positioning.dart';
import '../domain/trash_item.dart';

class DriftTrashRepository implements TrashRepository {
  DriftTrashRepository(this._db, {this._clock = systemClock});

  final AppDatabase _db;
  final Clock _clock;

  @override
  Stream<List<TrashItem>> watchTrash() =>
      _db.watchTables([_db.projects, _db.cards, _db.persons], () async {
        final items = <TrashItem>[];
        for (final p
            in await (_db.select(_db.projects)..where(
                  (t) => t.deletedAt.isNotNull() & t.isInbox.equals(false),
                ))
                .get()) {
          items.add(
            TrashItem(
              kind: TrashKind.project,
              id: p.id,
              title: p.title,
              deletedAt: p.deletedAt!,
            ),
          );
        }
        final c = _db.cards, p = _db.projects;
        final cardRows = await (_db.select(c).join([
          innerJoin(p, p.id.equalsExp(c.projectId)),
        ])..where(c.deletedAt.isNotNull() & p.deletedAt.isNull())).get();
        for (final r in cardRows) {
          final card = r.readTable(c);
          final project = r.readTable(p);
          items.add(
            TrashItem(
              kind: TrashKind.card,
              id: card.id,
              title: card.title,
              subtitle: project.title,
              deletedAt: card.deletedAt!,
            ),
          );
        }
        for (final person in await (_db.select(
          _db.persons,
        )..where((t) => t.deletedAt.isNotNull())).get()) {
          items.add(
            TrashItem(
              kind: TrashKind.person,
              id: person.id,
              title: person.name,
              subtitle: person.role,
              deletedAt: person.deletedAt!,
            ),
          );
        }
        items.sort((a, b) => b.deletedAt.compareTo(a.deletedAt));
        return items;
      });

  @override
  Future<void> restoreProject(String id) => _db.transaction(() async {
    final row = await (_db.select(
      _db.projects,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    final ts = row?.deletedAt;
    if (ts == null) return;
    final now = _clock();
    final arg = [Variable<String>(id)];
    const cardsOfProject =
        'card_id IN (SELECT id FROM cards WHERE project_id = ?)';
    await _db.restoreWhere(_db.projects, 'id = ?', arg, ts, now);
    await _db.restoreWhere(_db.boardColumns, 'project_id = ?', arg, ts, now);
    await _db.restoreWhere(_db.cards, 'project_id = ?', arg, ts, now);
    await _db.restoreWhere(_db.labels, 'project_id = ?', arg, ts, now);
    await _db.restoreWhere(
      _db.projectRequesters,
      'project_id = ?',
      arg,
      ts,
      now,
    );
    await _db.restoreWhere(_db.checklistItems, cardsOfProject, arg, ts, now);
    await _db.restoreWhere(_db.cardLabels, cardsOfProject, arg, ts, now);
  });

  @override
  Future<void> restoreCard(String id) => _db.transaction(() async {
    final card = await (_db.select(
      _db.cards,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    final ts = card?.deletedAt;
    if (card == null || ts == null) return;
    final now = _clock();
    final arg = [Variable<String>(id)];
    await _db.restoreWhere(_db.cards, 'id = ?', arg, ts, now);
    await _db.restoreWhere(_db.checklistItems, 'card_id = ?', arg, ts, now);
    await _db.restoreWhere(_db.cardLabels, 'card_id = ?', arg, ts, now);

    // Sütunu da silinmişse kartı projenin ilk açık sütununun sonuna al.
    final column =
        await (_db.select(_db.boardColumns)
              ..where((t) => t.id.equals(card.columnId) & t.deletedAt.isNull()))
            .getSingleOrNull();
    if (column == null) {
      final columns =
          await (_db.select(_db.boardColumns)
                ..where(
                  (t) =>
                      t.projectId.equals(card.projectId) & t.deletedAt.isNull(),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.position)]))
              .get();
      final target =
          columns.where((c) => !c.isDoneColumn).firstOrNull ??
          columns.firstOrNull;
      if (target == null) return;
      final positions =
          await (_db.select(_db.cards)..where(
                (t) => t.columnId.equals(target.id) & t.deletedAt.isNull(),
              ))
              .map((r) => r.position)
              .get();
      await (_db.update(_db.cards)..where((t) => t.id.equals(id))).write(
        CardsCompanion(
          columnId: Value(target.id),
          position: Value(positionAtEnd(positions)),
          completedAt: Value(
            target.isDoneColumn ? (card.completedAt ?? now) : null,
          ),
          updatedAt: Value(now),
        ),
      );
    }
  });

  @override
  Future<void> restorePerson(String id) => _db.transaction(() async {
    final person = await (_db.select(
      _db.persons,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    final ts = person?.deletedAt;
    if (ts == null) return;
    final now = _clock();
    final arg = [Variable<String>(id)];
    await _db.restoreWhere(_db.persons, 'id = ?', arg, ts, now);
    await _db.restoreWhere(
      _db.projectRequesters,
      'person_id = ?',
      arg,
      ts,
      now,
    );
  });

  @override
  Future<void> purge(TrashItem item) async {
    // FK'lar ON DELETE CASCADE / SET NULL olduğu için alt kayıtlar da temizlenir.
    final table = switch (item.kind) {
      TrashKind.project => _db.projects.actualTableName,
      TrashKind.card => _db.cards.actualTableName,
      TrashKind.person => _db.persons.actualTableName,
    };
    await _db.customUpdate(
      'DELETE FROM $table WHERE id = ? AND deleted_at IS NOT NULL',
      variables: [Variable<String>(item.id)],
      updates: _db.tablesInDependencyOrder.toSet(),
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Future<void> emptyTrash() => _purgeWhere('deleted_at IS NOT NULL', const []);

  @override
  Future<int> purgeOlderThan(Duration age) async {
    final cutoff = _clock().subtract(age);
    final before = await _countDeletedRoots();
    await _purgeWhere('deleted_at IS NOT NULL AND deleted_at < ?', [
      Variable<DateTime>(cutoff),
    ]);
    return before - await _countDeletedRoots();
  }

  Future<int> _countDeletedRoots() async {
    final row = await _db
        .customSelect(
          'SELECT (SELECT COUNT(*) FROM projects WHERE deleted_at IS NOT NULL) + '
          '(SELECT COUNT(*) FROM cards WHERE deleted_at IS NOT NULL) + '
          '(SELECT COUNT(*) FROM persons WHERE deleted_at IS NOT NULL) AS n',
        )
        .getSingle();
    return row.read<int>('n');
  }

  Future<void> _purgeWhere(String where, List<Variable<Object>> args) =>
      _db.transaction(() async {
        // Önce çocuklar: ebeveyni duran ama kendisi silinmiş satırlar da temizlensin.
        for (final table in _db.tablesInDependencyOrder.reversed) {
          await _db.customUpdate(
            'DELETE FROM ${table.actualTableName} WHERE $where',
            variables: args,
            updates: {table},
            updateKind: UpdateKind.delete,
          );
        }
      });
}
