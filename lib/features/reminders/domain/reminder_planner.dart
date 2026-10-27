import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../projects/domain/project.dart';
import '../../tasks/domain/task_item.dart';
import 'reminder_settings.dart';

part 'reminder_planner.freezed.dart';

/// iOS aynı anda en fazla 64 bekleyen yerel bildirime izin verir; pay bırakılır.
const kMaxScheduledReminders = 60;

@freezed
abstract class PlannedReminder with _$PlannedReminder {
  const factory PlannedReminder({
    required DateTime when,
    required String title,
    String? body,

    /// Bildirime dokununca açılacak uygulama rotası.
    required String route,
  }) = _PlannedReminder;
}

/// Görev ve proje tarihlerinden kurulacak bildirimleri hesaplar (yan etkisiz).
/// [now] yerel saattir; tarihler sadece-gün (UTC gece yarısı) saklanır.
List<PlannedReminder> planReminders({
  required List<TaskItem> tasks,
  required List<ProjectOverview> projects,
  required ReminderSettings settings,
  required DateTime now,
  required AppLocalizations l10n,
}) {
  if (!settings.enabled) return const [];
  final out = <PlannedReminder>[];

  DateTime at(DateTime dateOnly, {int dayOffset = 0}) => DateTime(
    dateOnly.year,
    dateOnly.month,
    dateOnly.day + dayOffset,
    settings.hour,
    settings.minute,
  );
  void add(DateTime when, String title, String? body, String route) {
    if (when.isAfter(now)) {
      out.add(
        PlannedReminder(when: when, title: title, body: body, route: route),
      );
    }
  }

  final open = tasks
      .where((t) => !t.isCompleted && t.card.dueDate != null)
      .toList();
  String context(TaskItem t) => t.isInbox ? l10n.inboxTitle : t.projectTitle;

  for (final t in open) {
    final due = t.card.dueDate!;
    final route = '/cards/${t.card.id}';
    if (!settings.dailyDigest) {
      add(at(due), l10n.reminderTaskToday(t.card.title), context(t), route);
    }
    if (settings.dayBefore) {
      add(
        at(due, dayOffset: -1),
        l10n.reminderTaskTomorrow(t.card.title),
        context(t),
        route,
      );
    }
  }

  for (final o in projects) {
    final due = o.project.dueDate;
    if (due == null || o.project.status.isClosed || o.project.isInbox) continue;
    final route = '/projects/${o.project.id}';
    add(
      at(due),
      l10n.reminderProjectToday(o.project.title),
      o.project.description,
      route,
    );
    if (settings.dayBefore) {
      add(
        at(due, dayOffset: -1),
        l10n.reminderProjectTomorrow(o.project.title),
        o.project.description,
        route,
      );
    }
  }

  if (settings.dailyDigest) {
    // Önümüzdeki günler için sabah özeti: o gün son tarihi olan görevler.
    final byDay = <DateTime, List<TaskItem>>{};
    for (final t in open) {
      final d = t.card.dueDate!;
      (byDay[DateTime(d.year, d.month, d.day)] ??= []).add(t);
    }
    // Bugün için gecikmişler de özete girer.
    final today = DateTime(now.year, now.month, now.day);
    final overdue = byDay.entries
        .where((e) => e.key.isBefore(today))
        .expand((e) => e.value)
        .toList();
    if (overdue.isNotEmpty) (byDay[today] ??= []).insertAll(0, overdue);

    for (final entry in byDay.entries) {
      if (entry.key.isBefore(today)) continue;
      final items = entry.value;
      final names = items.take(3).map((t) => '• ${t.card.title}').join('\n');
      final rest = items.length > 3
          ? '\n${l10n.reminderDigestMore(items.length - 3)}'
          : '';
      add(
        at(entry.key),
        l10n.reminderDigestTitle(items.length),
        '$names$rest',
        '/tasks',
      );
    }
  }

  out.sort((a, b) => a.when.compareTo(b.when));
  return out.take(kMaxScheduledReminders).toList();
}
