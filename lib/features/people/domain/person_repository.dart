import 'person.dart';

/// Kişi verisine erişim sözleşmesi. Faz 1'de Drift, Faz 2'de uzak/senkron uygulama.
abstract interface class PersonRepository {
  Stream<List<Person>> watchAll();
  Stream<List<PersonOverview>> watchOverviews();
  Future<Person> create(PersonInput input);
  Future<void> update(String id, PersonInput input);

  /// Kişiyi siler; sorumlu olduğu projelerden kaldırılır, talep eden kayıtları silinir.
  Future<void> delete(String id);
}
