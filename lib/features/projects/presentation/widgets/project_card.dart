import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/glass.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/widgets/chips.dart';
import '../../../../core/widgets/person_avatar.dart';
import '../../domain/project.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard(this.overview, {super.key, this.dragHandle});

  final ProjectOverview overview;

  /// Manuel sıralamada gösterilen tutamaç.
  final Widget? dragHandle;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final p = overview.project;
    final accent = context.semantic.priority(p.priority);
    final people = [
      ?overview.responsible,
      ...overview.requesters.where((r) => r.id != overview.responsible?.id),
    ];

    return Hero(
      tag: 'project-${p.id}',
      // Hero uçuşunda metin stilleri bozulmasın.
      child: Material(
        type: MaterialType.transparency,
        child: GlassSurface(
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => context.push(Routes.project(p.id)),
            child: Stack(
              children: [
                // Sol kenarda öncelik rengi şeridi.
                Positioned(
                  left: 0,
                  top: 18,
                  bottom: 18,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StatusPill(p.status, dense: true),
                          const SizedBox(width: 6),
                          PriorityPill(p.priority, dense: true),
                          const Spacer(),
                          ?dragHandle,
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          decoration: p.status.isClosed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (p.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          p.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          if (p.dueDate != null)
                            DueDateBadge(
                              p.dueDate!,
                              closed: p.status.isClosed,
                              dense: true,
                            ),
                          const Spacer(),
                          AvatarStack(people, size: 26),
                        ],
                      ),
                      if (overview.totalCards > 0) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: overview.progress),
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutCubic,
                                builder: (_, v, _) => LinearProgressIndicator(
                                  value: v,
                                  minHeight: 6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l.cardsProgress(
                                overview.doneCards,
                                overview.totalCards,
                              ),
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
