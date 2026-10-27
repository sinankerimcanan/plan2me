import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/project.dart';
import '../domain/project_repository.dart';
import 'drift_project_repository.dart';

part 'projects_providers.g.dart';

@Riverpod(keepAlive: true)
ProjectRepository projectRepository(Ref ref) => DriftProjectRepository(
  ref.watch(appDatabaseProvider),
  clock: ref.watch(clockProvider),
);

@riverpod
Stream<List<ProjectOverview>> projectOverviews(Ref ref) =>
    ref.watch(projectRepositoryProvider).watchOverviews();

@riverpod
Stream<ProjectOverview?> projectOverview(Ref ref, String id) =>
    ref.watch(projectRepositoryProvider).watchOverview(id);
