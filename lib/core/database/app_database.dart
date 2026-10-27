import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

import '../domain/enums.dart';
import 'app_database.steps.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Persons,
    Projects,
    ProjectRequesters,
    BoardColumns,
    Cards,
    ChecklistItems,
    Labels,
    CardLabels,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Testler için: `AppDatabase.forTesting(NativeDatabase.memory())`.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    // Şema değişiklikleri: `fvm dart run drift_dev make-migrations` ile adım
    // dosyası üretilir, her yeni sürüm için buraya bir fromXToY eklenir.
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.addColumn(schema.projects, schema.projects.isInbox);
        await m.addColumn(schema.cards, schema.cards.assigneePersonId);
        await m.addColumn(schema.cards, schema.cards.recurrence);
        await m.addColumn(schema.cards, schema.cards.nextCardId);
        await m.createIndex(schema.idxCardsAssignee);
      },
    ),
    beforeOpen: (details) async {
      // SQLite'ta FK kontrolü varsayılan olarak kapalıdır.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(
    name: 'plan2me',
    native: const DriftNativeOptions(),
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
      onResult: (result) {
        if (result.missingFeatures.isNotEmpty) {
          debugPrint(
            'Drift web: ${result.chosenImplementation} kullanılıyor, '
            'eksik özellikler: ${result.missingFeatures}',
          );
        }
      },
    ),
  );

  /// Verilen tablolardan herhangi biri değiştiğinde [load]'u yeniden çalıştıran stream.
  /// Birden çok tabloyu birleştiren görünüm modelleri (board, proje özeti) için.
  /// Değişiklik aboneliği ilk yüklemeden ÖNCE açılır, böylece arada olan yazımlar kaçmaz.
  Stream<T> watchTables<T>(
    Iterable<TableInfo<Table, Object?>> tables,
    Future<T> Function() load,
  ) {
    final updates = tableUpdates(TableUpdateQuery.onAllTables(tables));
    return Stream<void>.multi((controller) {
      final sub = updates.listen(
        (_) => controller.add(null),
        onError: controller.addError,
        onDone: controller.close,
      );
      controller
        ..add(null)
        ..onCancel = sub.cancel;
    }).asyncMap((_) => load());
  }

  /// `version` kolonunu artırır (senkron için değişiklik sayacı).
  Future<void> bumpVersion(
    TableInfo<Table, Object?> table,
    String id,
  ) => customUpdate(
    'UPDATE ${table.actualTableName} SET version = version + 1 WHERE id = ?',
    variables: [Variable<String>(id)],
    updates: {table},
    updateKind: UpdateKind.update,
  );

  /// Geri alma: aynı silme işleminde ([deletedAt] zamanında) silinmiş ve
  /// [whereSql] koşuluna uyan satırları geri getirir.
  Future<int> restoreWhere(
    TableInfo<Table, Object?> table,
    String whereSql,
    List<Variable<Object>> args,
    DateTime deletedAt,
    DateTime now,
  ) => customUpdate(
    'UPDATE ${table.actualTableName} '
    'SET deleted_at = NULL, updated_at = ?, version = version + 1 '
    'WHERE deleted_at = ? AND ($whereSql)',
    variables: [
      Variable<DateTime>(now),
      Variable<DateTime>(deletedAt),
      ...args,
    ],
    updates: {table},
    updateKind: UpdateKind.update,
  );

  /// Bağımlılık sırasına göre tablolar (önce ebeveynler). Yedek ve temizlik için.
  List<TableInfo<Table, Object?>> get tablesInDependencyOrder => [
    persons,
    projects,
    projectRequesters,
    boardColumns,
    cards,
    checklistItems,
    labels,
    cardLabels,
  ];

  /// Soft delete: [whereSql] koşuluna uyan ve henüz silinmemiş satırları işaretler.
  Future<int> softDeleteWhere(
    TableInfo<Table, Object?> table,
    String whereSql,
    List<Variable<Object>> args,
    DateTime now,
  ) => customUpdate(
    'UPDATE ${table.actualTableName} '
    'SET deleted_at = ?, updated_at = ?, version = version + 1 '
    'WHERE deleted_at IS NULL AND ($whereSql)',
    variables: [Variable<DateTime>(now), Variable<DateTime>(now), ...args],
    updates: {table},
    updateKind: UpdateKind.update,
  );
}
