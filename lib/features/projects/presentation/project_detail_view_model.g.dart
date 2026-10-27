// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectDetailViewModel)
final projectDetailViewModelProvider = ProjectDetailViewModelFamily._();

final class ProjectDetailViewModelProvider
    extends $StreamNotifierProvider<ProjectDetailViewModel, ProjectOverview?> {
  ProjectDetailViewModelProvider._({
    required ProjectDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'projectDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectDetailViewModelHash();

  @override
  String toString() {
    return r'projectDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProjectDetailViewModel create() => ProjectDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is ProjectDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectDetailViewModelHash() =>
    r'3c599c9ac6cc36ed78a834a69fa5e0a31a78ee53';

final class ProjectDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ProjectDetailViewModel,
          AsyncValue<ProjectOverview?>,
          ProjectOverview?,
          Stream<ProjectOverview?>,
          String
        > {
  ProjectDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'projectDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProjectDetailViewModelProvider call(String projectId) =>
      ProjectDetailViewModelProvider._(argument: projectId, from: this);

  @override
  String toString() => r'projectDetailViewModelProvider';
}

abstract class _$ProjectDetailViewModel
    extends $StreamNotifier<ProjectOverview?> {
  late final _$args = ref.$arg as String;
  String get projectId => _$args;

  Stream<ProjectOverview?> build(String projectId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProjectOverview?>, ProjectOverview?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectOverview?>, ProjectOverview?>,
              AsyncValue<ProjectOverview?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
