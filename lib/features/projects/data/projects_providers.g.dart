// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectRepository)
final projectRepositoryProvider = ProjectRepositoryProvider._();

final class ProjectRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectRepository,
          ProjectRepository,
          ProjectRepository
        >
    with $Provider<ProjectRepository> {
  ProjectRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProjectRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectRepository create(Ref ref) {
    return projectRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectRepository>(value),
    );
  }
}

String _$projectRepositoryHash() => r'0b4f5977b37687e5768e27e0cb1995a99418b777';

@ProviderFor(projectOverviews)
final projectOverviewsProvider = ProjectOverviewsProvider._();

final class ProjectOverviewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectOverview>>,
          List<ProjectOverview>,
          Stream<List<ProjectOverview>>
        >
    with
        $FutureModifier<List<ProjectOverview>>,
        $StreamProvider<List<ProjectOverview>> {
  ProjectOverviewsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectOverviewsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectOverviewsHash();

  @$internal
  @override
  $StreamProviderElement<List<ProjectOverview>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ProjectOverview>> create(Ref ref) {
    return projectOverviews(ref);
  }
}

String _$projectOverviewsHash() => r'f42ab21586963ed58dd5ac9b40e78761843a3a6c';

@ProviderFor(projectOverview)
final projectOverviewProvider = ProjectOverviewFamily._();

final class ProjectOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProjectOverview?>,
          ProjectOverview?,
          Stream<ProjectOverview?>
        >
    with $FutureModifier<ProjectOverview?>, $StreamProvider<ProjectOverview?> {
  ProjectOverviewProvider._({
    required ProjectOverviewFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'projectOverviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectOverviewHash();

  @override
  String toString() {
    return r'projectOverviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ProjectOverview?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ProjectOverview?> create(Ref ref) {
    final argument = this.argument as String;
    return projectOverview(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectOverviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectOverviewHash() => r'7265cc91f3185708b51861695f15d72f25f2d036';

final class ProjectOverviewFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ProjectOverview?>, String> {
  ProjectOverviewFamily._()
    : super(
        retry: null,
        name: r'projectOverviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProjectOverviewProvider call(String id) =>
      ProjectOverviewProvider._(argument: id, from: this);

  @override
  String toString() => r'projectOverviewProvider';
}

@ProviderFor(inboxProjectId)
final inboxProjectIdProvider = InboxProjectIdProvider._();

final class InboxProjectIdProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, Stream<String?>>
    with $FutureModifier<String?>, $StreamProvider<String?> {
  InboxProjectIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxProjectIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxProjectIdHash();

  @$internal
  @override
  $StreamProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String?> create(Ref ref) {
    return inboxProjectId(ref);
  }
}

String _$inboxProjectIdHash() => r'088682ffdf2970d1677b70d5f72a4df81e7f7453';
