import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/utils/positioning.dart';
import '../data/projects_providers.dart';
import '../domain/project.dart';
import '../domain/project_filters.dart';

part 'projects_view_model.g.dart';

/// Liste filtre durumu (ekran açık kaldıkça korunur).
@Riverpod(keepAlive: true)
class ProjectFiltersController extends _$ProjectFiltersController {
  @override
  ProjectFilters build() => const ProjectFilters();

  void setQuery(String q) => state = state.copyWith(query: q);
  void setSort(ProjectSort s) => state = state.copyWith(sort: s);
  void setResponsible(String? id) => state = state.copyWith(responsibleId: id);
  void setShowClosed(bool v) => state = state.copyWith(showClosed: v);

  void toggleStatus(ProjectStatus s) => state = state.copyWith(
    statuses: state.statuses.contains(s)
        ? ({...state.statuses}..remove(s))
        : {...state.statuses, s},
  );

  void togglePriority(Priority p) => state = state.copyWith(
    priorities: state.priorities.contains(p)
        ? ({...state.priorities}..remove(p))
        : {...state.priorities, p},
  );

  void clear() => state = ProjectFilters(sort: state.sort);
}

/// Projeler listesi ViewModel'i. Durum: filtrelenmiş/sıralanmış liste.
@riverpod
class ProjectsViewModel extends _$ProjectsViewModel {
  @override
  AsyncValue<List<ProjectOverview>> build() {
    final filters = ref.watch(projectFiltersControllerProvider);
    final all = ref.watch(projectOverviewsProvider);
    return all.whenData(filters.apply);
  }

  /// Sadece filtresiz manuel sıralamada çağrılır. [newIndex] onReorderItem semantiğinde.
  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = state.value;
    if (current == null) return;
    final ids = [for (final o in current) o.project.id];
    final beforeId = beforeIdForReorder(ids, oldIndex, newIndex);

    final list = [...current];
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    // İyimser güncelleme: stream yeni sırayı getirene kadar yerel sıra gösterilir.
    state = AsyncData(list);

    await ref
        .read(projectRepositoryProvider)
        .move(item.project.id, beforeId: beforeId);
  }

  Future<void> changeStatus(String id, ProjectStatus status) =>
      ref.read(projectRepositoryProvider).updateStatus(id, status);

  Future<void> delete(String id) =>
      ref.read(projectRepositoryProvider).delete(id);
}
