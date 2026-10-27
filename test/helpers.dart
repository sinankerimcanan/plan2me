import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:plan2me/core/database/app_database.dart';

AppDatabase memoryDb() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase.forTesting(NativeDatabase.memory());
}

/// Her çağrıda 1 saniye ilerleyen sahte saat.
DateTime Function() fakeClock([DateTime? start]) {
  var t = start ?? DateTime.utc(2026, 1, 1, 9);
  return () => t = t.add(const Duration(seconds: 1));
}
