import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/clock.dart';
import '../../board/domain/board_models.dart';
import '../../people/domain/person.dart';

part 'task_item.freezed.dart';

/// Projeler arası görev görünümü: bir kart + bağlamı.
@freezed
abstract class TaskItem with _$TaskItem {
  const TaskItem._();

  const factory TaskItem({
    required KanbanCard card,
    required String projectTitle,
    @Default(false) bool isInbox,
    required String columnName,
    Person? assignee,
    @Default(<Label>[]) List<Label> labels,
    @Default(0) int checklistTotal,
    @Default(0) int checklistDone,
  }) = _TaskItem;

  bool get isCompleted => card.isCompleted;

  /// Bugüne göre kalan gün (negatif = gecikmiş); tarihsizse null.
  int? daysUntilDue([DateTime? reference]) {
    final due = card.dueDate;
    if (due == null) return null;
    final t = reference ?? today();
    return DateTime.utc(due.year, due.month, due.day).difference(t).inDays;
  }
}

enum TaskGroup { overdue, today, tomorrow, thisWeek, later, noDate, completed }

extension TaskGrouping on TaskItem {
  TaskGroup group([DateTime? reference]) {
    if (isCompleted) return TaskGroup.completed;
    final d = daysUntilDue(reference);
    if (d == null) return TaskGroup.noDate;
    if (d < 0) return TaskGroup.overdue;
    if (d == 0) return TaskGroup.today;
    if (d == 1) return TaskGroup.tomorrow;
    if (d <= 7) return TaskGroup.thisWeek;
    return TaskGroup.later;
  }
}

/// Hızlı görev ekleme girdisi. [projectId] null ise "Gelen kutusu"na eklenir.
@freezed
abstract class QuickTaskInput with _$QuickTaskInput {
  const factory QuickTaskInput({
    required String title,
    String? projectId,
    DateTime? dueDate,
    @Default(CardPatch()) CardPatch extra,
  }) = _QuickTaskInput;
}
