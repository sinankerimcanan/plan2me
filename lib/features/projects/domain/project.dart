import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../people/domain/person.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    required String title,
    String? description,
    @Default(Priority.medium) Priority priority,
    @Default(ProjectStatus.backlog) ProjectStatus status,
    DateTime? startDate,
    DateTime? dueDate,
    String? responsiblePersonId,
    String? details,
    @Default(0) double position,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

/// Liste ve detay ekranlarının kullandığı zenginleştirilmiş proje görünümü.
@freezed
abstract class ProjectOverview with _$ProjectOverview {
  const ProjectOverview._();

  const factory ProjectOverview({
    required Project project,
    Person? responsible,
    @Default(<Person>[]) List<Person> requesters,
    @Default(0) int totalCards,
    @Default(0) int doneCards,
  }) = _ProjectOverview;

  double get progress => totalCards == 0 ? 0 : doneCards / totalCards;
}

/// Proje formunun düzenlediği taslak.
@freezed
abstract class ProjectDraft with _$ProjectDraft {
  const factory ProjectDraft({
    @Default('') String title,
    String? description,
    @Default(Priority.medium) Priority priority,
    @Default(ProjectStatus.backlog) ProjectStatus status,
    DateTime? startDate,
    DateTime? dueDate,
    String? responsiblePersonId,
    @Default(<String>[]) List<String> requesterIds,
    String? details,
  }) = _ProjectDraft;

  factory ProjectDraft.fromOverview(ProjectOverview o) => ProjectDraft(
    title: o.project.title,
    description: o.project.description,
    priority: o.project.priority,
    status: o.project.status,
    startDate: o.project.startDate,
    dueDate: o.project.dueDate,
    responsiblePersonId: o.project.responsiblePersonId,
    requesterIds: [for (final p in o.requesters) p.id],
    details: o.project.details,
  );
}
