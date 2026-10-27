import 'package:flutter/painting.dart';

import '../../../core/domain/enums.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../board/domain/board_models.dart';
import '../../projects/domain/project.dart';
import '../domain/widget_snapshot.dart';

const kWidgetProjectLimit = 6;
const kWidgetCardLimit = 6;

String _date(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

String _hex(Color c) =>
    '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

/// Widget için saf (yan etkisiz) özet üretimi; test edilebilir.
WidgetSnapshot buildWidgetSnapshot({
  required List<ProjectOverview> overviews,
  required List<UpcomingCard> upcoming,
  required AppLocalizations l10n,
  required DateTime today,
  DateTime? now,
}) {
  final colors = AppSemanticColors.light;
  final active = overviews.where((o) => !o.project.status.isClosed).toList();

  // Widget sırası: gecikmiş → öncelik (yüksek önce) → son tarih → manuel sıra.
  final sorted = [...active]
    ..sort((a, b) {
      final pa = a.project, pb = b.project;
      final oa = pa.dueDate != null && pa.dueDate!.isBefore(today);
      final ob = pb.dueDate != null && pb.dueDate!.isBefore(today);
      if (oa != ob) return oa ? -1 : 1;
      final pr = pb.priority.weight.compareTo(pa.priority.weight);
      if (pr != 0) return pr;
      final da = pa.dueDate, db = pb.dueDate;
      if (da != db) {
        if (da == null) return 1;
        if (db == null) return -1;
        return da.compareTo(db);
      }
      return pa.position.compareTo(pb.position);
    });

  return WidgetSnapshot(
    generatedAt: (now ?? DateTime.now()).toUtc().toIso8601String(),
    stats: WidgetStats(
      active: active.length,
      inProgress: active
          .where((o) => o.project.status == ProjectStatus.inProgress)
          .length,
      openCards: active.fold(0, (s, o) => s + o.totalCards - o.doneCards),
      doneCards: active.fold(0, (s, o) => s + o.doneCards),
    ),
    activeDueDates: [
      for (final o in active)
        if (o.project.dueDate != null) _date(o.project.dueDate!),
    ],
    projects: [
      for (final o in sorted.take(kWidgetProjectLimit))
        WidgetProject(
          id: o.project.id,
          title: o.project.title,
          status: o.project.status.name,
          statusLabel: o.project.status.label(l10n),
          priority: o.project.priority.name,
          priorityLabel: o.project.priority.label(l10n),
          priorityColor: _hex(colors.priority(o.project.priority)),
          due: o.project.dueDate == null ? null : _date(o.project.dueDate!),
          done: o.doneCards,
          total: o.totalCards,
        ),
    ],
    cards: [
      for (final c in upcoming.take(kWidgetCardLimit))
        WidgetCard(
          id: c.cardId,
          projectId: c.projectId,
          projectTitle: c.projectTitle,
          title: c.title,
          priority: c.priority.name,
          priorityColor: _hex(colors.priority(c.priority)),
          due: _date(c.dueDate),
        ),
    ],
  );
}
