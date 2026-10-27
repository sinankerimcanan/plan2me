import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../projects/data/projects_providers.dart';
import '../../projects/domain/project.dart';
import '../../tasks/data/tasks_providers.dart';
import '../../tasks/domain/task_item.dart';

part 'calendar_view_model.freezed.dart';
part 'calendar_view_model.g.dart';

enum CalendarSpan { month, twoWeeks, week }

DateTime calendarDay(DateTime d) => DateTime.utc(d.year, d.month, d.day);

@freezed
abstract class CalendarUiState with _$CalendarUiState {
  const factory CalendarUiState({
    required DateTime focusedDay,
    required DateTime selectedDay,
    @Default(CalendarSpan.month) CalendarSpan span,
  }) = _CalendarUiState;
}

/// Seçili gün, odaklı ay ve görünüm (ay / 2 hafta / hafta).
@Riverpod(keepAlive: true)
class CalendarController extends _$CalendarController {
  @override
  CalendarUiState build() {
    final now = calendarDay(DateTime.now());
    return CalendarUiState(focusedDay: now, selectedDay: now);
  }

  void select(DateTime day, DateTime focused) => state = state.copyWith(
    selectedDay: calendarDay(day),
    focusedDay: calendarDay(focused),
  );
  void focus(DateTime focused) =>
      state = state.copyWith(focusedDay: calendarDay(focused));
  void setSpan(CalendarSpan s) => state = state.copyWith(span: s);
  void goToday() {
    final now = calendarDay(DateTime.now());
    state = state.copyWith(selectedDay: now, focusedDay: now);
  }
}

/// Bir güne düşen kayıtlar: görev son tarihleri ve proje teslimleri.
@freezed
abstract class DayAgenda with _$DayAgenda {
  const DayAgenda._();

  const factory DayAgenda({
    @Default(<TaskItem>[]) List<TaskItem> tasks,
    @Default(<ProjectOverview>[]) List<ProjectOverview> projects,
  }) = _DayAgenda;

  bool get isEmpty => tasks.isEmpty && projects.isEmpty;
  int get count => tasks.length + projects.length;
}

/// Takvim ViewModel'i: tarihe göre gruplanmış ajanda.
@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  @override
  AsyncValue<Map<DateTime, DayAgenda>> build() {
    final tasks = ref.watch(allTasksProvider);
    final projects = ref.watch(projectOverviewsProvider);
    if (tasks is AsyncError) return AsyncError(tasks.error!, tasks.stackTrace!);
    if (projects is AsyncError) {
      return AsyncError(projects.error!, projects.stackTrace!);
    }
    final t = tasks.value, p = projects.value;
    if (t == null || p == null) return const AsyncLoading();

    final taskMap = <DateTime, List<TaskItem>>{};
    for (final task in t) {
      final due = task.card.dueDate;
      if (due != null) (taskMap[calendarDay(due)] ??= []).add(task);
    }
    final projectMap = <DateTime, List<ProjectOverview>>{};
    for (final o in p) {
      final due = o.project.dueDate;
      if (due != null && !o.project.status.isClosed) {
        (projectMap[calendarDay(due)] ??= []).add(o);
      }
    }
    return AsyncData({
      for (final day in {...taskMap.keys, ...projectMap.keys})
        day: DayAgenda(
          tasks: taskMap[day] ?? const [],
          projects: projectMap[day] ?? const [],
        ),
    });
  }
}
