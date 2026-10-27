import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../data/projects_providers.dart';
import '../domain/project.dart';

part 'project_detail_view_model.g.dart';

@riverpod
class ProjectDetailViewModel extends _$ProjectDetailViewModel {
  @override
  Stream<ProjectOverview?> build(String projectId) =>
      ref.watch(projectRepositoryProvider).watchOverview(projectId);

  Future<void> changeStatus(ProjectStatus status) =>
      ref.read(projectRepositoryProvider).updateStatus(projectId, status);

  Future<void> delete() =>
      ref.read(projectRepositoryProvider).delete(projectId);
}
