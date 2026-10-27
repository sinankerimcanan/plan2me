import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/clock.dart';
import '../../board/data/board_providers.dart';
import '../../board/domain/board_models.dart';
import '../../people/data/people_providers.dart';
import '../data/tasks_providers.dart';
import '../domain/task_item.dart';

part 'tasks_view_model.freezed.dart';
part 'tasks_view_model.g.dart';

enum TaskScope { all, mine }

@freezed
abstract class TaskFilter with _$TaskFilter {
  const factory TaskFilter({
    @Default(TaskScope.all) TaskScope scope,
    @Default(false) bool showCompleted,
  }) = _TaskFilter;
}

@Riverpod(keepAlive: true)
class TaskFilterController extends _$TaskFilterController {
  @override
  TaskFilter build() => const TaskFilter();

  void setScope(TaskScope s) => state = state.copyWith(scope: s);
  void toggleCompleted() =>
      state = state.copyWith(showCompleted: !state.showCompleted);
}

@freezed
abstract class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    @Default(<TaskGroup, List<TaskItem>>{})
    Map<TaskGroup, List<TaskItem>> groups,
    @Default(0) int openCount,
    @Default(0) int overdueCount,
    String? meId,
  }) = _TasksState;

  bool get isEmpty => groups.values.every((l) => l.isEmpty);
}

/// "Görevlerim" ViewModel'i: tüm projelerdeki görevleri gruplar, niyetleri yönetir.
@riverpod
class TasksViewModel extends _$TasksViewModel {
  @override
  AsyncValue<TasksState> build() {
    final filter = ref.watch(taskFilterControllerProvider);
    final tasks = ref.watch(allTasksProvider);
    final meId = ref
        .watch(allPeopleProvider)
        .value
        ?.where((p) => p.isMe)
        .firstOrNull
        ?.id;
    return tasks.whenData((list) {
      final now = today();
      final visible = list.where((t) {
        if (!filter.showCompleted && t.isCompleted) return false;
        if (filter.scope == TaskScope.mine &&
            (meId == null || t.card.assigneePersonId != meId)) {
          return false;
        }
        return true;
      });
      final groups = <TaskGroup, List<TaskItem>>{
        for (final g in TaskGroup.values) g: [],
      };
      for (final t in visible) {
        groups[t.group(now)]!.add(t);
      }
      final open = list.where((t) => !t.isCompleted);
      return TasksState(
        groups: groups,
        openCount: open.length,
        overdueCount: open
            .where((t) => t.group(now) == TaskGroup.overdue)
            .length,
        meId: meId,
      );
    });
  }

  /// Tamamlanmamışsa tamamlar, tamamlanmışsa yeniden açar.
  /// Dönen fonksiyon işlemi geri alır ("Geri al" düğmesi için).
  Future<({bool completed, Future<void> Function() undo})> toggleComplete(
    TaskItem task,
  ) async {
    final board = ref.read(boardRepositoryProvider);
    final id = task.card.id;
    final fromColumn = task.card.columnId;
    if (task.isCompleted) {
      await board.reopenCard(id);
      return (completed: false, undo: () => board.completeCard(id));
    }
    await board.completeCard(id);
    return (
      completed: true,
      undo: () => board.undoComplete(id, toColumnId: fromColumn),
    );
  }

  /// Son tarihi [days] gün sonrasına erteler; geri alma fonksiyonu döner.
  Future<Future<void> Function()> snooze(TaskItem task, {int days = 1}) async {
    final board = ref.read(boardRepositoryProvider);
    final id = task.card.id;
    final before = task.card.dueDate;
    await board.updateCard(
      id,
      CardPatch(dueDate: today().add(Duration(days: days))),
    );
    return () => board.updateCard(
      id,
      before == null
          ? const CardPatch(clearDueDate: true)
          : CardPatch(dueDate: before),
    );
  }

  Future<void> delete(TaskItem task) =>
      ref.read(boardRepositoryProvider).deleteCard(task.card.id);

  Future<String> addTask(
    QuickTaskInput input, {
    required String inboxTitle,
    required List<String> defaultColumns,
  }) => ref
      .read(taskRepositoryProvider)
      .addTask(input, inboxTitle: inboxTitle, defaultColumns: defaultColumns);
}
