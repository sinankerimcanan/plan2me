// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trash_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trashRepository)
final trashRepositoryProvider = TrashRepositoryProvider._();

final class TrashRepositoryProvider
    extends
        $FunctionalProvider<TrashRepository, TrashRepository, TrashRepository>
    with $Provider<TrashRepository> {
  TrashRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trashRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trashRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrashRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TrashRepository create(Ref ref) {
    return trashRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrashRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrashRepository>(value),
    );
  }
}

String _$trashRepositoryHash() => r'93eedfc5a094bb5359a1524192b5742e9bef7be7';

@ProviderFor(trashItems)
final trashItemsProvider = TrashItemsProvider._();

final class TrashItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TrashItem>>,
          List<TrashItem>,
          Stream<List<TrashItem>>
        >
    with $FutureModifier<List<TrashItem>>, $StreamProvider<List<TrashItem>> {
  TrashItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trashItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trashItemsHash();

  @$internal
  @override
  $StreamProviderElement<List<TrashItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TrashItem>> create(Ref ref) {
    return trashItems(ref);
  }
}

String _$trashItemsHash() => r'14012fb1635577fdda751a177104d7558d4eeb7e';
