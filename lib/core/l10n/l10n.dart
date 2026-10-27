import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../domain/enums.dart';
import '../utils/clock.dart';

export '../../l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// "27 Eki 2026" biçiminde, sadece-tarih alanlar için (UTC gün olarak okunur).
  String formatDate(DateTime d) {
    final locale = Localizations.localeOf(this).toLanguageTag();
    return DateFormat.yMMMd(locale).format(DateTime(d.year, d.month, d.day));
  }

  /// Zaman damgaları (createdAt, completedAt) yerel saate çevrilerek.
  String formatTimestamp(DateTime d) {
    final locale = Localizations.localeOf(this).toLanguageTag();
    return DateFormat.yMMMd(locale).format(d.toLocal());
  }

  /// Son tarih için göreli ifade: "Bugün", "3 gün kaldı", "2 gün gecikti".
  String relativeDue(DateTime due) {
    final days = DateTime.utc(
      due.year,
      due.month,
      due.day,
    ).difference(today()).inDays;
    if (days == 0) return l10n.dueToday;
    if (days == 1) return l10n.dueTomorrow;
    if (days < 0) return l10n.dueOverdue(-days);
    return l10n.dueInDays(days);
  }
}

extension PriorityL10n on Priority {
  String label(AppLocalizations l) => switch (this) {
    Priority.low => l.priorityLow,
    Priority.medium => l.priorityMedium,
    Priority.high => l.priorityHigh,
    Priority.critical => l.priorityCritical,
  };

  IconData get icon => switch (this) {
    Priority.low => Icons.keyboard_double_arrow_down_rounded,
    Priority.medium => Icons.drag_handle_rounded,
    Priority.high => Icons.keyboard_arrow_up_rounded,
    Priority.critical => Icons.keyboard_double_arrow_up_rounded,
  };
}

extension StatusL10n on ProjectStatus {
  String label(AppLocalizations l) => switch (this) {
    ProjectStatus.backlog => l.statusBacklog,
    ProjectStatus.planned => l.statusPlanned,
    ProjectStatus.inProgress => l.statusInProgress,
    ProjectStatus.onHold => l.statusOnHold,
    ProjectStatus.done => l.statusDone,
    ProjectStatus.cancelled => l.statusCancelled,
  };

  IconData get icon => switch (this) {
    ProjectStatus.backlog => Icons.inbox_rounded,
    ProjectStatus.planned => Icons.event_note_rounded,
    ProjectStatus.inProgress => Icons.autorenew_rounded,
    ProjectStatus.onHold => Icons.pause_circle_outline_rounded,
    ProjectStatus.done => Icons.check_circle_rounded,
    ProjectStatus.cancelled => Icons.cancel_outlined,
  };
}

extension RecurrenceL10n on Recurrence? {
  String label(AppLocalizations l) => switch (this) {
    null => l.recurrenceNone,
    Recurrence.daily => l.recurrenceDaily,
    Recurrence.weekly => l.recurrenceWeekly,
    Recurrence.monthly => l.recurrenceMonthly,
    Recurrence.yearly => l.recurrenceYearly,
  };
}
