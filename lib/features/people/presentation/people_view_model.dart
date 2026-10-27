import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/people_providers.dart';
import '../domain/person.dart';

part 'people_view_model.g.dart';

/// Kişiler ekranı ViewModel'i: canlı liste + CRUD niyetleri.
@riverpod
class PeopleViewModel extends _$PeopleViewModel {
  @override
  Stream<List<PersonOverview>> build() =>
      ref.watch(personRepositoryProvider).watchOverviews();

  Future<Person> create(PersonInput input) =>
      ref.read(personRepositoryProvider).create(input);

  Future<void> save(String id, PersonInput input) =>
      ref.read(personRepositoryProvider).update(id, input);

  Future<void> delete(String id) =>
      ref.read(personRepositoryProvider).delete(id);
}
