import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/utils/clock.dart';
import 'project.dart';

part 'project_filters.freezed.dart';

enum ProjectSort { manual, priority, dueDate, updated }

@freezed
abstract class ProjectFilters with _$ProjectFilters {
  const ProjectFilters._();

  const factory ProjectFilters({
    @Default('') String query,
    @Default(<ProjectStatus>{}) Set<ProjectStatus> statuses,
    @Default(<Priority>{}) Set<Priority> priorities,
    String? responsibleId,
    @Default(false) bool showClosed,
    @Default(ProjectSort.manual) ProjectSort sort,
  }) = _ProjectFilters;

  /// Arama/filtre aktif mi? (Manuel sürükle-sırala sadece filtresiz listede açılır.)
  bool get isFiltering =>
      query.trim().isNotEmpty ||
      statuses.isNotEmpty ||
      priorities.isNotEmpty ||
      responsibleId != null;

  int get activeCount =>
      statuses.length +
      priorities.length +
      (responsibleId != null ? 1 : 0) +
      (showClosed ? 1 : 0);

  bool get canReorder => sort == ProjectSort.manual && !isFiltering;

  List<ProjectOverview> apply(List<ProjectOverview> items) {
    final q = query.trim().toLowerCase();
    final filtered = items.where((o) {
      final p = o.project;
      // Aşama filtresi seçiliyse kapalılar da o filtreye göre gösterilir.
      if (statuses.isEmpty && !showClosed && p.status.isClosed) return false;
      if (statuses.isNotEmpty && !statuses.contains(p.status)) return false;
      if (priorities.isNotEmpty && !priorities.contains(p.priority)) {
        return false;
      }
      if (responsibleId != null && p.responsiblePersonId != responsibleId) {
        return false;
      }
      if (q.isNotEmpty) {
        final haystack = [
          p.title,
          p.description ?? '',
          p.details ?? '',
          o.responsible?.name ?? '',
          ...o.requesters.map((r) => r.name),
        ].join(' ').toLowerCase();
        if (!haystack.contains(q)) return false;
      }
      return true;
    }).toList();

    switch (sort) {
      case ProjectSort.manual:
        break; // repository zaten position'a göre sıralı verir
      case ProjectSort.priority:
        filtered.sort((a, b) {
          final c = b.project.priority.weight.compareTo(
            a.project.priority.weight,
          );
          return c != 0 ? c : _compareDue(a, b);
        });
      case ProjectSort.dueDate:
        filtered.sort(_compareDue);
      case ProjectSort.updated:
        filtered.sort(
          (a, b) => b.project.updatedAt.compareTo(a.project.updatedAt),
        );
    }
    return filtered;
  }
}

int _compareDue(ProjectOverview a, ProjectOverview b) {
  final da = a.project.dueDate, db = b.project.dueDate;
  if (da == null && db == null) return 0;
  if (da == null) return 1;
  if (db == null) return -1;
  return da.compareTo(db);
}

/// Son tarihi geçmiş ve kapanmamış mı?
bool isOverdue(DateTime? due, {bool closed = false}) =>
    !closed && due != null && due.isBefore(today());
