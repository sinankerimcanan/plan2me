// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Arayüz → Drift bağlantısı. Faz 2'de override edilerek uzak repository verilir.

@ProviderFor(personRepository)
final personRepositoryProvider = PersonRepositoryProvider._();

/// Arayüz → Drift bağlantısı. Faz 2'de override edilerek uzak repository verilir.

final class PersonRepositoryProvider
    extends
        $FunctionalProvider<
          PersonRepository,
          PersonRepository,
          PersonRepository
        >
    with $Provider<PersonRepository> {
  /// Arayüz → Drift bağlantısı. Faz 2'de override edilerek uzak repository verilir.
  PersonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personRepositoryHash();

  @$internal
  @override
  $ProviderElement<PersonRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PersonRepository create(Ref ref) {
    return personRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonRepository>(value),
    );
  }
}

String _$personRepositoryHash() => r'fb5ca4f9373f3c0dd9c649a50f456474300f5aa7';

/// Seçiciler (sorumlu / talep eden) için canlı kişi listesi.

@ProviderFor(allPeople)
final allPeopleProvider = AllPeopleProvider._();

/// Seçiciler (sorumlu / talep eden) için canlı kişi listesi.

final class AllPeopleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Person>>,
          List<Person>,
          Stream<List<Person>>
        >
    with $FutureModifier<List<Person>>, $StreamProvider<List<Person>> {
  /// Seçiciler (sorumlu / talep eden) için canlı kişi listesi.
  AllPeopleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPeopleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPeopleHash();

  @$internal
  @override
  $StreamProviderElement<List<Person>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Person>> create(Ref ref) {
    return allPeople(ref);
  }
}

String _$allPeopleHash() => r'dd99df33ecd9d3e0cec3327af37ea9523d2868f3';
