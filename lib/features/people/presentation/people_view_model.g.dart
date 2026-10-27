// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kişiler ekranı ViewModel'i: canlı liste + CRUD niyetleri.

@ProviderFor(PeopleViewModel)
final peopleViewModelProvider = PeopleViewModelProvider._();

/// Kişiler ekranı ViewModel'i: canlı liste + CRUD niyetleri.
final class PeopleViewModelProvider
    extends $StreamNotifierProvider<PeopleViewModel, List<PersonOverview>> {
  /// Kişiler ekranı ViewModel'i: canlı liste + CRUD niyetleri.
  PeopleViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'peopleViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$peopleViewModelHash();

  @$internal
  @override
  PeopleViewModel create() => PeopleViewModel();
}

String _$peopleViewModelHash() => r'eb081f2f1a6b288968fb30874352116e6a027465';

/// Kişiler ekranı ViewModel'i: canlı liste + CRUD niyetleri.

abstract class _$PeopleViewModel extends $StreamNotifier<List<PersonOverview>> {
  Stream<List<PersonOverview>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PersonOverview>>, List<PersonOverview>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PersonOverview>>,
                List<PersonOverview>
              >,
              AsyncValue<List<PersonOverview>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
