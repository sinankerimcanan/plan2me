import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/ids.dart';
import '../domain/person.dart';
import '../domain/person_repository.dart';

Person personFromRow(PersonRow r) => Person(
  id: r.id,
  name: r.name,
  email: r.email,
  role: r.role,
  colorHex: r.colorHex,
  isMe: r.isMe,
  createdAt: r.createdAt,
  updatedAt: r.updatedAt,
);

int comparePeople(Person a, Person b) {
  if (a.isMe != b.isMe) return a.isMe ? -1 : 1;
  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
}

class DriftPersonRepository implements PersonRepository {
  DriftPersonRepository(this._db, {this._clock = systemClock});

  final AppDatabase _db;
  final Clock _clock;

  SimpleSelectStatement<$PersonsTable, PersonRow> _alive() =>
      _db.select(_db.persons)..where((t) => t.deletedAt.isNull());

  @override
  Stream<List<Person>> watchAll() => _alive().watch().map(
    (rows) => rows.map(personFromRow).toList()..sort(comparePeople),
  );

  @override
  Stream<List<PersonOverview>> watchOverviews() => _db.watchTables(
    [_db.persons, _db.projects, _db.projectRequesters],
    () async {
      final people = (await _alive().get()).map(personFromRow).toList()
        ..sort(comparePeople);
      final projects = await (_db.select(
        _db.projects,
      )..where((t) => t.deletedAt.isNull())).get();
      final aliveProjectIds = {for (final p in projects) p.id};
      final requesters = await (_db.select(
        _db.projectRequesters,
      )..where((t) => t.deletedAt.isNull())).get();

      final responsible = <String, int>{};
      for (final p in projects) {
        final rid = p.responsiblePersonId;
        if (rid != null) responsible[rid] = (responsible[rid] ?? 0) + 1;
      }
      final requested = <String, int>{};
      for (final r in requesters) {
        if (!aliveProjectIds.contains(r.projectId)) continue;
        requested[r.personId] = (requested[r.personId] ?? 0) + 1;
      }
      return [
        for (final p in people)
          PersonOverview(
            person: p,
            responsibleCount: responsible[p.id] ?? 0,
            requestedCount: requested[p.id] ?? 0,
          ),
      ];
    },
  );

  @override
  Future<Person> create(PersonInput input) => _db.transaction(() async {
    final now = _clock();
    final id = newId();
    if (input.isMe) await _clearMe(now);
    await _db
        .into(_db.persons)
        .insert(
          PersonsCompanion.insert(
            id: id,
            createdAt: now,
            updatedAt: now,
            name: input.name.trim(),
            email: Value(_blankToNull(input.email)),
            role: Value(_blankToNull(input.role)),
            colorHex: Value(input.colorHex),
            isMe: Value(input.isMe),
          ),
        );
    final row = await (_db.select(
      _db.persons,
    )..where((t) => t.id.equals(id))).getSingle();
    return personFromRow(row);
  });

  @override
  Future<void> update(String id, PersonInput input) =>
      _db.transaction(() async {
        final now = _clock();
        if (input.isMe) await _clearMe(now, exceptId: id);
        await (_db.update(_db.persons)..where((t) => t.id.equals(id))).write(
          PersonsCompanion(
            name: Value(input.name.trim()),
            email: Value(_blankToNull(input.email)),
            role: Value(_blankToNull(input.role)),
            colorHex: Value(input.colorHex),
            isMe: Value(input.isMe),
            updatedAt: Value(now),
          ),
        );
        await _db.bumpVersion(_db.persons, id);
      });

  @override
  Future<void> delete(String id) => _db.transaction(() async {
    final now = _clock();
    final affected = await (_db.select(
      _db.projects,
    )..where((t) => t.responsiblePersonId.equals(id))).get();
    for (final p in affected) {
      await (_db.update(_db.projects)..where((t) => t.id.equals(p.id))).write(
        ProjectsCompanion(
          responsiblePersonId: const Value(null),
          updatedAt: Value(now),
        ),
      );
      await _db.bumpVersion(_db.projects, p.id);
    }
    await _db.softDeleteWhere(_db.projectRequesters, 'person_id = ?', [
      Variable<String>(id),
    ], now);
    await _db.softDeleteWhere(_db.persons, 'id = ?', [
      Variable<String>(id),
    ], now);
  });

  /// "Ben" işareti tek kişide olabilir.
  Future<void> _clearMe(DateTime now, {String? exceptId}) async {
    final current =
        await (_db.select(_db.persons)..where(
              (t) =>
                  t.isMe.equals(true) &
                  (exceptId == null
                      ? const Constant(true)
                      : t.id.equals(exceptId).not()),
            ))
            .get();
    for (final p in current) {
      await (_db.update(_db.persons)..where((t) => t.id.equals(p.id))).write(
        PersonsCompanion(isMe: const Value(false), updatedAt: Value(now)),
      );
      await _db.bumpVersion(_db.persons, p.id);
    }
  }
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return (t == null || t.isEmpty) ? null : t;
}
