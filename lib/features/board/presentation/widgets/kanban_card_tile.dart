import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/color_schemes.dart';
import '../../../../core/theme/glass.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/person_avatar.dart';
import '../../domain/board_models.dart';

/// Board üzerindeki kart görünümü (sahte cam: blur yok, kaydırmada ucuz).
class KanbanCardTile extends StatelessWidget {
  const KanbanCardTile({
    super.key,
    required this.item,
    this.onTap,
    this.elevated = false,
  });

  final BoardCard item;
  final VoidCallback? onTap;

  /// Sürüklenirken daha belirgin gölge.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final card = item.card;
    final s = context.semantic;
    final done = card.isCompleted;

    return GlassSurface(
      borderRadius: BorderRadius.circular(18),
      opacity: elevated ? 0.92 : null,
      shadow: elevated,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.labels.isNotEmpty) ...[
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (final label in item.labels)
                      Container(
                        height: 6,
                        width: 34,
                        decoration: BoxDecoration(
                          color: colorFromHex(label.colorHex),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (done) ...[
                    Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: s.success,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      card.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: done ? TextDecoration.lineThrough : null,
                        color: done ? theme.colorScheme.onSurfaceVariant : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    card.priority.icon,
                    size: 18,
                    color: s.priority(card.priority),
                  ),
                  if (card.dueDate != null)
                    DueDateBadge(card.dueDate!, closed: done, dense: true),
                  if (item.checklistTotal > 0)
                    Pill(
                      dense: true,
                      icon: Icons.checklist_rounded,
                      label: '${item.checklistDone}/${item.checklistTotal}',
                      color: item.checklistDone == item.checklistTotal
                          ? s.success
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  if (card.location != null)
                    Icon(
                      Icons.place_rounded,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  if (card.recurrence != null)
                    Icon(
                      Icons.repeat_rounded,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  if (card.description != null)
                    Icon(
                      Icons.notes_rounded,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  if (item.assignee != null)
                    PersonAvatar(item.assignee!, size: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
