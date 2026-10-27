import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/glass.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/person_avatar.dart';
import '../../domain/task_item.dart';

/// Görev satırı: yuvarlak onay kutusu, başlık ve bağlam bilgileri.
/// Görevler ve takvim ekranları ortak kullanır.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
    this.showDue = true,
  });

  final TaskItem task;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final bool showDue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = context.semantic;
    final card = task.card;
    final done = task.isCompleted;
    final muted = theme.colorScheme.onSurfaceVariant;

    return GlassSurface(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 8, 14, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CheckCircle(
                done: done,
                color: s.priority(card.priority),
                onTap: () {
                  HapticFeedback.lightImpact();
                  onToggle();
                },
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: done ? TextDecoration.lineThrough : null,
                          color: done ? muted : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Pill(
                            dense: true,
                            icon: task.isInbox
                                ? Icons.inbox_rounded
                                : Icons.folder_rounded,
                            label: task.isInbox
                                ? context.l10n.inboxTitle
                                : task.projectTitle,
                            color: muted,
                          ),
                          if (showDue && card.dueDate != null)
                            DueDateBadge(
                              card.dueDate!,
                              closed: done,
                              dense: true,
                            ),
                          if (card.location != null)
                            Tooltip(
                              message: card.location!.name,
                              child: Icon(
                                Icons.place_rounded,
                                size: 16,
                                color: muted,
                              ),
                            ),
                          if (card.recurrence != null)
                            Tooltip(
                              message: card.recurrence.label(context.l10n),
                              child: Icon(
                                Icons.repeat_rounded,
                                size: 16,
                                color: muted,
                              ),
                            ),
                          if (task.checklistTotal > 0)
                            Pill(
                              dense: true,
                              icon: Icons.checklist_rounded,
                              label:
                                  '${task.checklistDone}/${task.checklistTotal}',
                              color: task.checklistDone == task.checklistTotal
                                  ? s.success
                                  : muted,
                            ),
                          for (final label in task.labels.take(2))
                            LabelPill(
                              name: label.name,
                              colorHex: label.colorHex,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (task.assignee != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: PersonAvatar(task.assignee!, size: 26),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({
    required this.done,
    required this.color,
    required this.onTap,
  });

  final bool done;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final success = context.semantic.success;
    return Semantics(
      checked: done,
      button: true,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? success : Colors.transparent,
              border: Border.all(color: done ? success : color, width: 2.2),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
              child: done
                  ? const Icon(
                      Icons.check_rounded,
                      key: ValueKey('on'),
                      size: 17,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink(key: ValueKey('off')),
            ),
          ),
        ),
      ),
    );
  }
}
