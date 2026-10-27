import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/person.dart';
import '../domain/person_repository.dart';
import 'drift_person_repository.dart';

part 'people_providers.g.dart';

/// Arayüz → Drift bağlantısı. Faz 2'de override edilerek uzak repository verilir.
@Riverpod(keepAlive: true)
PersonRepository personRepository(Ref ref) => DriftPersonRepository(
  ref.watch(appDatabaseProvider),
  clock: ref.watch(clockProvider),
);

/// Seçiciler (sorumlu / talep eden) için canlı kişi listesi.
@riverpod
Stream<List<Person>> allPeople(Ref ref) =>
    ref.watch(personRepositoryProvider).watchAll();
