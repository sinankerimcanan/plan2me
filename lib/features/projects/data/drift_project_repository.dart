import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/enums.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/ids.dart';
import '../../../core/utils/positioning.dart';
import '../../people/data/drift_person_repository.dart';
import '../../people/domain/person.dart';
import '../domain/project.dart';
import '../domain/project_repository.dart';

Project projectFromRow(ProjectRow r) => Project(
  id: r.id,
  title: r.title,
  description: r.description,
  priority: r.priority,
  status: r.status,
  startDate: r.startDate,
  dueDate: r.dueDate,
  responsiblePersonId: r.responsiblePersonId,
  details: r.details,
  position: r.position,
  isInbox: r.isInbox,
  createdAt: r.createdAt,
  updatedAt: r.updatedAt,
);

class DriftProjectRepository implements ProjectRepository {
  DriftProjectRepository(this._db, {this._clock = systemClock});

  final AppDatabase _db;
  final Clock _clock;

  List<TableInfo<Table, Object?>> get _watched => [
    _db.projects,
    _db.persons,
    _db.projectRequesters,
    _db.cards,
  ];

  @override
  Stream<List<ProjectOverview>> watchOverviews() =>
      _db.watchTables(_watched, () => _loadOverviews());

  @override
  Stream<ProjectOverview?> watchOverview(String id) => _db.watchTables(
    _watched,
    () async => (await _loadOverviews(onlyId: id)).firstOrNull,
  );

  @override
  Future<ProjectOverview?> getOverview(String id) async =>
      (await _loadOverviews(onlyId: id)).firstOrNull;

  Future<List<ProjectOverview>> _loadOverviews({String? onlyId}) async {
    final projectQuery = _db.select(_db.projects)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);
    if (onlyId != null) {
      projectQuery.where((t) => t.id.equals(onlyId));
    } else {
      projectQuery.where((t) => t.isInbox.equals(false));
    }
    final projects = await projectQuery.get();
    if (projects.isEmpty) return const [];

    final ids = [for (final p in projects) p.id];
    final people = {
      for (final r in await (_db.select(
        _db.persons,
      )..where((t) => t.deletedAt.isNull())).get())
        r.id: personFromRow(r),
    };
    final requesterRows = await (_db.select(
      _db.projectRequesters,
    )..where((t) => t.deletedAt.isNull() & t.projectId.isIn(ids))).get();
    final requesters = <String, List<Person>>{};
    for (final r in requesterRows) {
      final person = people[r.personId];
      if (person != null) {
        (requesters[r.projectId] ??= []).add(person);
      }
    }

    final counts = <String, (int, int)>{};
    final countRows = await _db
        .customSelect(
          'SELECT project_id, COUNT(*) AS total, '
          'SUM(CASE WHEN completed_at IS NOT NULL THEN 1 ELSE 0 END) AS done '
          'FROM cards WHERE deleted_at IS NULL GROUP BY project_id',
          readsFrom: {_db.cards},
        )
        .get();
    for (final row in countRows) {
      counts[row.read<String>('project_id')] = (
        row.read<int>('total'),
        row.read<int>('done'),
      );
    }

    return [
      for (final p in projects)
        ProjectOverview(
          project: projectFromRow(p),
          responsible: p.responsiblePersonId == null
              ? null
              : people[p.responsiblePersonId],
          requesters: (requesters[p.id] ?? [])..sort(comparePeople),
          totalCards: counts[p.id]?.$1 ?? 0,
          doneCards: counts[p.id]?.$2 ?? 0,
        ),
    ];
  }

  @override
  Future<String> create(
    ProjectDraft draft, {
    required List<String> defaultColumns,
  }) => _db.transaction(() async {
    final now = _clock();
    final id = newId();
    final positions = await _alivePositions();
    await _db
        .into(_db.projects)
        .insert(
          ProjectsCompanion.insert(
            id: id,
            createdAt: now,
            updatedAt: now,
            title: draft.title.trim(),
            description: Value(_blankToNull(draft.description)),
            priority: draft.priority,
            status: draft.status,
            startDate: Value(draft.startDate),
            dueDate: Value(draft.dueDate),
            responsiblePersonId: Value(draft.responsiblePersonId),
            details: Value(_blankToNull(draft.details)),
            // Yeni projeler listenin başına.
            position: positionAtStart(positions),
          ),
        );
    await _syncRequesters(id, draft.requesterIds, now);
    for (var i = 0; i < defaultColumns.length; i++) {
      await _db
          .into(_db.boardColumns)
          .insert(
            BoardColumnsCompanion.insert(
              id: newId(),
              createdAt: now,
              updatedAt: now,
              projectId: id,
              name: defaultColumns[i],
              position: (i + 1) * kPositionStep,
              isDoneColumn: Value(i == defaultColumns.length - 1),
            ),
          );
    }
    return id;
  });

  @override
  Stream<String?> watchInboxId() =>
      (_db.select(_db.projects)
            ..where((t) => t.isInbox.equals(true) & t.deletedAt.isNull())
            ..limit(1))
          .watchSingleOrNull()
          .map((r) => r?.id);

  @override
  Future<String> ensureInbox({
    required String title,
    required List<String> columns,
  }) => _db.transaction(() async {
    final existing =
        await (_db.select(_db.projects)
              ..where((t) => t.isInbox.equals(true) & t.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (existing != null) return existing.id;
    final id = await create(
      ProjectDraft(title: title, status: ProjectStatus.inProgress),
      defaultColumns: columns,
    );
    await (_db.update(_db.projects)..where((t) => t.id.equals(id))).write(
      const ProjectsCompanion(isInbox: Value(true)),
    );
    return id;
  });

  @override
  Future<void> update(String id, ProjectDraft draft) =>
      _db.transaction(() async {
        final now = _clock();
        await (_db.update(_db.projects)..where((t) => t.id.equals(id))).write(
          ProjectsCompanion(
            title: Value(draft.title.trim()),
            description: Value(_blankToNull(draft.description)),
            priority: Value(draft.priority),
            status: Value(draft.status),
            startDate: Value(draft.startDate),
            dueDate: Value(draft.dueDate),
            responsiblePersonId: Value(draft.responsiblePersonId),
            details: Value(_blankToNull(draft.details)),
            updatedAt: Value(now),
          ),
        );
        await _db.bumpVersion(_db.projects, id);
        await _syncRequesters(id, draft.requesterIds, now);
      });

  @override
  Future<void> updateStatus(String id, ProjectStatus status) =>
      _db.transaction(() async {
        await (_db.update(_db.projects)..where((t) => t.id.equals(id))).write(
          ProjectsCompanion(status: Value(status), updatedAt: Value(_clock())),
        );
        await _db.bumpVersion(_db.projects, id);
      });

  @override
  Future<void> move(String id, {String? beforeId}) => _db.transaction(() async {
    final rows =
        await (_db.select(_db.projects)
              ..where((t) => t.deletedAt.isNull() & t.id.equals(id).not())
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final siblings = [for (final r in rows) (id: r.id, position: r.position)];
    final now = _clock();
    await _setPosition(id, positionBefore(siblings, beforeId), now);

    final all =
        await (_db.select(_db.projects)
              ..where((t) => t.deletedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    if (needsRenormalize([for (final r in all) r.position])) {
      final fresh = renormalized(all.length);
      for (var i = 0; i < all.length; i++) {
        await _setPosition(all[i].id, fresh[i], now);
      }
    }
  });

  @override
  Future<void> delete(String id) => _db.transaction(() async {
    final now = _clock();
    final pid = [Variable<String>(id)];
    const cardsOfProject =
        'card_id IN (SELECT id FROM cards WHERE project_id = ?)';
    await _db.softDeleteWhere(_db.checklistItems, cardsOfProject, pid, now);
    await _db.softDeleteWhere(_db.cardLabels, cardsOfProject, pid, now);
    await _db.softDeleteWhere(_db.cards, 'project_id = ?', pid, now);
    await _db.softDeleteWhere(_db.boardColumns, 'project_id = ?', pid, now);
    await _db.softDeleteWhere(_db.labels, 'project_id = ?', pid, now);
    await _db.softDeleteWhere(
      _db.projectRequesters,
      'project_id = ?',
      pid,
      now,
    );
    await _db.softDeleteWhere(_db.projects, 'id = ?', pid, now);
  });

  Future<List<double>> _alivePositions() async => [
    for (final r in await (_db.select(
      _db.projects,
    )..where((t) => t.deletedAt.isNull())).get())
      r.position,
  ];

  Future<void> _setPosition(String id, double position, DateTime now) async {
    await (_db.update(_db.projects)..where((t) => t.id.equals(id))).write(
      ProjectsCompanion(position: Value(position), updatedAt: Value(now)),
    );
    await _db.bumpVersion(_db.projects, id);
  }

  /// Talep edenleri hedef kümeye eşitler. Silinmiş (tombstone) kayıt varsa
  /// UNIQUE çakışması yerine o kayıt diriltilir.
  Future<void> _syncRequesters(
    String projectId,
    List<String> personIds,
    DateTime now,
  ) async {
    final wanted = personIds.toSet();
    final existing = await (_db.select(
      _db.projectRequesters,
    )..where((t) => t.projectId.equals(projectId))).get();
    final byPerson = {for (final r in existing) r.personId: r};

    for (final pid in wanted) {
      final row = byPerson[pid];
      if (row == null) {
        await _db
            .into(_db.projectRequesters)
            .insert(
              ProjectRequestersCompanion.insert(
                id: newId(),
                createdAt: now,
                updatedAt: now,
                projectId: projectId,
                personId: pid,
              ),
            );
      } else if (row.deletedAt != null) {
        await (_db.update(
          _db.projectRequesters,
        )..where((t) => t.id.equals(row.id))).write(
          ProjectRequestersCompanion(
            deletedAt: const Value(null),
            updatedAt: Value(now),
          ),
        );
        await _db.bumpVersion(_db.projectRequesters, row.id);
      }
    }
    for (final row in existing) {
      if (row.deletedAt == null && !wanted.contains(row.personId)) {
        await _db.softDeleteWhere(_db.projectRequesters, 'id = ?', [
          Variable<String>(row.id),
        ], now);
      }
    }
  }
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return (t == null || t.isEmpty) ? null : t;
}
