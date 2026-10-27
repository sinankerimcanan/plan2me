import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../calendar_sync/data/calendar_sync_providers.dart';
import '../../calendar_sync/data/device_calendar_gateway.dart';
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

    /// Telefon takvimindeki (plan2me dışı) etkinlikler.
    @Default(<DeviceEvent>[]) List<DeviceEvent> deviceEvents,
  }) = _DayAgenda;

  bool get isEmpty =>
      tasks.isEmpty && projects.isEmpty && this.deviceEvents.isEmpty;
  int get count => tasks.length + projects.length + this.deviceEvents.length;
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
    // Telefon etkinlikleri yüklenirken takvimi bekletme; gelince eklenir.
    final focused = ref.watch(calendarControllerProvider).focusedDay;
    final device =
        ref
            .watch(deviceEventsProvider(DateTime(focused.year, focused.month)))
            .value ??
        const [];
    final deviceMap = <DateTime, List<DeviceEvent>>{};
    for (final e in device) {
      for (final day in eventDays(e)) {
        (deviceMap[day] ??= []).add(e);
      }
    }
    for (final list in deviceMap.values) {
      list.sort(
        (a, b) => a.allDay == b.allDay
            ? a.start.compareTo(b.start)
            : (a.allDay ? -1 : 1),
      );
    }

    return AsyncData({
      for (final day in {
        ...taskMap.keys,
        ...projectMap.keys,
        ...deviceMap.keys,
      })
        day: DayAgenda(
          tasks: taskMap[day] ?? const [],
          projects: projectMap[day] ?? const [],
          deviceEvents: deviceMap[day] ?? const [],
        ),
    });
  }
}

/// Etkinliğin kapladığı günler (tüm gün etkinliklerinde bitiş hariçtir).
Iterable<DateTime> eventDays(DeviceEvent e) sync* {
  final start = DateTime(e.start.year, e.start.month, e.start.day);
  var end = DateTime(e.end.year, e.end.month, e.end.day);
  if (e.allDay ||
      (e.end.hour == 0 && e.end.minute == 0 && end.isAfter(start))) {
    end = end.subtract(const Duration(days: 1));
  }
  for (
    var d = start;
    !d.isAfter(end);
    d = DateTime(d.year, d.month, d.day + 1)
  ) {
    yield calendarDay(d);
  }
}
