// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_form_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Yeni/düzenle proje formu. [projectId] null ise yeni proje.

@ProviderFor(ProjectFormViewModel)
final projectFormViewModelProvider = ProjectFormViewModelFamily._();

/// Yeni/düzenle proje formu. [projectId] null ise yeni proje.
final class ProjectFormViewModelProvider
    extends $AsyncNotifierProvider<ProjectFormViewModel, ProjectDraft> {
  /// Yeni/düzenle proje formu. [projectId] null ise yeni proje.
  ProjectFormViewModelProvider._({
    required ProjectFormViewModelFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'projectFormViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectFormViewModelHash();

  @override
  String toString() {
    return r'projectFormViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProjectFormViewModel create() => ProjectFormViewModel();

  @override
  bool operator ==(Object other) {
    return other is ProjectFormViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectFormViewModelHash() =>
    r'29cb94f55db411f37dc662302f02ccdc678c6f9f';

/// Yeni/düzenle proje formu. [projectId] null ise yeni proje.

final class ProjectFormViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ProjectFormViewModel,
          AsyncValue<ProjectDraft>,
          ProjectDraft,
          FutureOr<ProjectDraft>,
          String?
        > {
  ProjectFormViewModelFamily._()
    : super(
        retry: null,
        name: r'projectFormViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Yeni/düzenle proje formu. [projectId] null ise yeni proje.

  ProjectFormViewModelProvider call(String? projectId) =>
      ProjectFormViewModelProvider._(argument: projectId, from: this);

  @override
  String toString() => r'projectFormViewModelProvider';
}

/// Yeni/düzenle proje formu. [projectId] null ise yeni proje.

abstract class _$ProjectFormViewModel extends $AsyncNotifier<ProjectDraft> {
  late final _$args = ref.$arg as String?;
  String? get projectId => _$args;

  FutureOr<ProjectDraft> build(String? projectId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProjectDraft>, ProjectDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectDraft>, ProjectDraft>,
              AsyncValue<ProjectDraft>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
