import '../../../core/database/app_database.dart';
import '../domain/calendar_sync_plan.dart';

/// Kayıt ↔ takvim etkinliği eşleşmeleri (cihaza özel tablo).
class CalendarLinkStore {
  CalendarLinkStore(this._db);

  final AppDatabase _db;

  Future<Map<String, LinkedEvent>> readAll() async => {
    for (final r in await _db.select(_db.calendarLinks).get())
      r.entityKey: (eventId: r.eventId, signature: r.signature),
  };

  Future<void> save(String key, String eventId, String signature) => _db
      .into(_db.calendarLinks)
      .insertOnConflictUpdate(
        CalendarLinksCompanion.insert(
          entityKey: key,
          eventId: eventId,
          signature: signature,
          syncedAt: DateTime.now().toUtc(),
        ),
      );

  Future<void> remove(String key) => (_db.delete(
    _db.calendarLinks,
  )..where((t) => t.entityKey.equals(key))).go();

  Future<void> clear() => _db.delete(_db.calendarLinks).go();
}
