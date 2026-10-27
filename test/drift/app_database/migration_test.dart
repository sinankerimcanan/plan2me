// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift_dev/api/migrations_native.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test(
    'v1 → v2: mevcut proje ve kartlar korunur, yeni alanlar varsayılan alır',
    () async {
      final schema = await verifier.schemaAt(1);
      final old = v1.DatabaseAtV1(schema.newConnection());
      const ts = '2026-10-27T10:00:00.000Z';
      await old.customStatement(
        'INSERT INTO projects (id, created_at, updated_at, title, priority, status, position) '
        "VALUES ('p1', '$ts', '$ts', 'Eski proje', 'high', 'inProgress', 1024)",
      );
      await old.customStatement(
        'INSERT INTO board_columns (id, created_at, updated_at, project_id, name, position) '
        "VALUES ('c1', '$ts', '$ts', 'p1', 'Yapılacak', 1024)",
      );
      await old.customStatement(
        'INSERT INTO cards (id, created_at, updated_at, column_id, project_id, title, priority, position) '
        "VALUES ('k1', '$ts', '$ts', 'c1', 'p1', 'Eski kart', 'medium', 1024)",
      );
      await old.close();

      final db = AppDatabase(schema.newConnection());
      await verifier.migrateAndValidate(db, 2);
      final project = await db.select(db.projects).getSingle();
      final card = await db.select(db.cards).getSingle();
      expect(project.title, 'Eski proje');
      expect(project.isInbox, isFalse);
      expect(card.title, 'Eski kart');
      expect(card.assigneePersonId, isNull);
      expect(card.recurrence, isNull);
      await db.close();
    },
  );

  test('v2 → v3: konum alanları boş gelir, mevcut kart korunur', () async {
    final schema = await verifier.schemaAt(2);
    final old = v2.DatabaseAtV2(schema.newConnection());
    const ts = '2026-10-27T10:00:00.000Z';
    await old.customStatement(
      'INSERT INTO projects (id, created_at, updated_at, title, priority, status, position) '
      "VALUES ('p1', '$ts', '$ts', 'Proje', 'high', 'inProgress', 1024)",
    );
    await old.customStatement(
      'INSERT INTO board_columns (id, created_at, updated_at, project_id, name, position) '
      "VALUES ('c1', '$ts', '$ts', 'p1', 'A', 1024)",
    );
    await old.customStatement(
      'INSERT INTO cards (id, created_at, updated_at, column_id, project_id, title, priority, position, recurrence) '
      "VALUES ('k1', '$ts', '$ts', 'c1', 'p1', 'Kart', 'medium', 1024, 'weekly')",
    );
    await old.close();

    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 3);
    final card = await db.select(db.cards).getSingle();
    expect(card.title, 'Kart');
    expect(card.recurrence?.name, 'weekly');
    expect(
      (card.locationName, card.latitude, card.longitude),
      (null, null, null),
    );
    expect((await db.select(db.projects).getSingle()).locationName, isNull);
    await db.close();
  });

  test('v3 → v4: takvim eşleşme tablosu oluşur, veri korunur', () async {
    final schema = await verifier.schemaAt(3);
    final old = v3.DatabaseAtV3(schema.newConnection());
    const ts = '2026-10-27T10:00:00.000Z';
    await old.customStatement(
      'INSERT INTO persons (id, created_at, updated_at, name) '
      "VALUES ('u1', '$ts', '$ts', 'Ali')",
    );
    await old.close();

    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 4);
    expect((await db.select(db.persons).getSingle()).name, 'Ali');
    expect(await db.select(db.calendarLinks).get(), isEmpty);
    await db.close();
  });
}
