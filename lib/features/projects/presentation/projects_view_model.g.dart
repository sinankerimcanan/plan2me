// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Liste filtre durumu (ekran açık kaldıkça korunur).

@ProviderFor(ProjectFiltersController)
final projectFiltersControllerProvider = ProjectFiltersControllerProvider._();

/// Liste filtre durumu (ekran açık kaldıkça korunur).
final class ProjectFiltersControllerProvider
    extends $NotifierProvider<ProjectFiltersController, ProjectFilters> {
  /// Liste filtre durumu (ekran açık kaldıkça korunur).
  ProjectFiltersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectFiltersControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectFiltersControllerHash();

  @$internal
  @override
  ProjectFiltersController create() => ProjectFiltersController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectFilters value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectFilters>(value),
    );
  }
}

String _$projectFiltersControllerHash() =>
    r'e9daae02278adff0f98e3ef80dea12b2c1974fd5';

/// Liste filtre durumu (ekran açık kaldıkça korunur).

abstract class _$ProjectFiltersController extends $Notifier<ProjectFilters> {
  ProjectFilters build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProjectFilters, ProjectFilters>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProjectFilters, ProjectFilters>,
              ProjectFilters,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Projeler listesi ViewModel'i. Durum: filtrelenmiş/sıralanmış liste.

@ProviderFor(ProjectsViewModel)
final projectsViewModelProvider = ProjectsViewModelProvider._();

/// Projeler listesi ViewModel'i. Durum: filtrelenmiş/sıralanmış liste.
final class ProjectsViewModelProvider
    extends
        $NotifierProvider<
          ProjectsViewModel,
          AsyncValue<List<ProjectOverview>>
        > {
  /// Projeler listesi ViewModel'i. Durum: filtrelenmiş/sıralanmış liste.
  ProjectsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsViewModelHash();

  @$internal
  @override
  ProjectsViewModel create() => ProjectsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<ProjectOverview>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<ProjectOverview>>>(
        value,
      ),
    );
  }
}

String _$projectsViewModelHash() => r'5d54e34394397c68a1105cf4e44459f400761a60';

/// Projeler listesi ViewModel'i. Durum: filtrelenmiş/sıralanmış liste.

abstract class _$ProjectsViewModel
    extends $Notifier<AsyncValue<List<ProjectOverview>>> {
  AsyncValue<List<ProjectOverview>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ProjectOverview>>,
              AsyncValue<List<ProjectOverview>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ProjectOverview>>,
                AsyncValue<List<ProjectOverview>>
              >,
              AsyncValue<List<ProjectOverview>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
