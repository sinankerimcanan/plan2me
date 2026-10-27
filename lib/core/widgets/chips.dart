import 'package:flutter/material.dart';

import '../domain/enums.dart';
import '../l10n/l10n.dart';
import '../theme/color_schemes.dart';
import '../theme/semantic_colors.dart';

/// Küçük renkli hap (pill) etiket.
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.filled = false,
    this.dense = false,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final bool filled;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme.labelMedium!;
    final fg = filled ? onColor(color) : color;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 10,
        vertical: dense ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: filled ? color : color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: filled ? 0 : 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: dense ? 13 : 15, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: text.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: dense ? 11 : null,
            ),
          ),
        ],
      ),
    );
  }
}

class PriorityPill extends StatelessWidget {
  const PriorityPill(this.priority, {super.key, this.dense = false});

  final Priority priority;
  final bool dense;

  @override
  Widget build(BuildContext context) => Pill(
    label: priority.label(context.l10n),
    icon: priority.icon,
    color: context.semantic.priority(priority),
    dense: dense,
  );
}

class StatusPill extends StatelessWidget {
  const StatusPill(this.status, {super.key, this.dense = false});

  final ProjectStatus status;
  final bool dense;

  @override
  Widget build(BuildContext context) => Pill(
    label: status.label(context.l10n),
    icon: status.icon,
    color: context.semantic.status(status, Theme.of(context).colorScheme),
    dense: dense,
  );
}

/// Son tarih rozeti: gecikmişse kırmızı, yaklaşıyorsa sarı.
class DueDateBadge extends StatelessWidget {
  const DueDateBadge(
    this.due, {
    super.key,
    this.closed = false,
    this.dense = false,
  });

  final DateTime due;
  final bool closed;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final s = context.semantic;
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final days = DateTime.utc(
      due.year,
      due.month,
      due.day,
    ).difference(DateTime.utc(now.year, now.month, now.day)).inDays;
    final color = closed
        ? scheme.onSurfaceVariant
        : days < 0
        ? s.overdue
        : days <= 2
        ? s.priorityMedium
        : scheme.onSurfaceVariant;
    return Pill(
      label: closed ? context.formatDate(due) : context.relativeDue(due),
      icon: days < 0 && !closed
          ? Icons.warning_amber_rounded
          : Icons.event_rounded,
      color: color,
      dense: dense,
    );
  }
}

/// Proje etiketi (renkli).
class LabelPill extends StatelessWidget {
  const LabelPill({
    super.key,
    required this.name,
    required this.colorHex,
    this.dense = true,
  });

  final String name;
  final String colorHex;
  final bool dense;

  @override
  Widget build(BuildContext context) => Pill(
    label: name,
    color: colorFromHex(colorHex),
    filled: true,
    dense: dense,
  );
}
