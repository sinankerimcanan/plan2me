import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/utils/clock.dart';

part 'backup_service.g.dart';

class BackupFormatException implements Exception {
  BackupFormatException(this.message);
  final String message;
  @override
  String toString() => message;
}

typedef BackupSummary = ({int projects, int cards, int persons});

/// Tüm veritabanını (silinmiş kayıtlar dahil) JSON'a döker ve geri yükler.
/// Backend senkronu gelene kadar veri kaybına karşı güvence.
class BackupService {
  BackupService(this._db, {this._clock = systemClock});

  static const format = 'plan2me-backup';

  /// Tarihler ISO-8601 metin olarak yazılır. drift'in varsayılanı (epoch ms)
  /// geri okurken yerel saate çevirir ve UTC gece yarısı saklanan son tarihler
  /// eksi saat dilimlerinde önceki güne kayar.
  static const _serializer = ValueSerializer.defaults(
    serializeDateTimeValuesAsString: true,
  );

  final AppDatabase _db;
  final Clock _clock;

  Future<String> exportJson() async {
    final tables = <String, List<Map<String, dynamic>>>{};
    for (final table in _db.tablesInDependencyOrder) {
      final rows = await _db.select(table).get();
      tables[table.actualTableName] = [
        for (final r in rows) (r as DataClass).toJson(serializer: _serializer),
      ];
    }
    return const JsonEncoder.withIndent('  ').convert({
      'format': format,
      'schemaVersion': _db.schemaVersion,
      'exportedAt': _clock().toIso8601String(),
      'tables': tables,
    });
  }

  /// Yedeği okur ve özetini döner; veritabanına dokunmaz.
  BackupSummary inspect(String json) {
    final tables = _parse(json);
    int count(String t) =>
        (tables[t] ?? const []).where((r) => r['deletedAt'] == null).length;
    return (
      projects: count('projects'),
      cards: count('cards'),
      persons: count('persons'),
    );
  }

  /// Mevcut tüm verinin yerine yedeği yükler (tek transaction; hata olursa hiçbir şey değişmez).
  Future<BackupSummary> importJson(String json) async {
    final tables = _parse(json);
    List<Map<String, dynamic>> rows(
      String name, [
      Map<String, dynamic> defaults = const {},
    ]) => [
      for (final r in tables[name] ?? const <Map<String, dynamic>>[])
        {...defaults, ...r},
    ];
    try {
      await _db.transaction(() async {
        for (final table in _db.tablesInDependencyOrder.reversed) {
          await _db.delete(table).go();
        }
        await _db.batch((b) {
          b.insertAll(
            _db.persons,
            rows('persons', {
              'isMe': false,
            }).map((j) => PersonRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.projects,
            rows('projects', {
              'isInbox': false,
            }).map((j) => ProjectRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.projectRequesters,
            rows('project_requesters').map(
              (j) => ProjectRequesterRow.fromJson(j, serializer: _serializer),
            ),
          );
          b.insertAll(
            _db.boardColumns,
            rows(
              'board_columns',
            ).map((j) => BoardColumnRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.cards,
            rows('cards')
                .map((j) => CardRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.checklistItems,
            rows(
              'checklist_items',
            ).map((j) => ChecklistItemRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.labels,
            rows('labels')
                .map((j) => LabelRow.fromJson(j, serializer: _serializer)),
          );
          b.insertAll(
            _db.cardLabels,
            rows('card_labels')
                .map((j) => CardLabelRow.fromJson(j, serializer: _serializer)),
          );
        });
      });
    } on BackupFormatException {
      rethrow;
    } catch (e) {
      throw BackupFormatException('Yedek okunamadı: $e');
    }
    return inspect(json);
  }

  Map<String, List<Map<String, dynamic>>> _parse(String json) {
    final Object? data;
    try {
      data = jsonDecode(json);
    } on FormatException {
      throw BackupFormatException('Dosya geçerli bir JSON değil.');
    }
    if (data is! Map<String, dynamic> || data['format'] != format) {
      throw BackupFormatException('Bu bir plan2me yedeği değil.');
    }
    final version = data['schemaVersion'];
    if (version is! int || version > _db.schemaVersion) {
      throw BackupFormatException(
        'Yedek, uygulamanın daha yeni bir sürümüyle alınmış.',
      );
    }
    final tables = data['tables'];
    if (tables is! Map<String, dynamic>) {
      throw BackupFormatException('Yedekte tablo verisi yok.');
    }
    return {
      for (final e in tables.entries)
        e.key: [
          for (final r in e.value as List) Map<String, dynamic>.from(r as Map),
        ],
    };
  }
}

@Riverpod(keepAlive: true)
BackupService backupService(Ref ref) => BackupService(
  ref.watch(appDatabaseProvider),
  clock: ref.watch(clockProvider),
);
