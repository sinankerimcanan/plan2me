import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/enums.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/services/device_calendar.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/person_avatar.dart';
import '../../../core/widgets/toast.dart';
import '../../trash/data/trash_providers.dart';
import '../../board/presentation/board_view_model.dart';
import '../../calendar_sync/data/calendar_sync_providers.dart';
import '../../location/presentation/location_tile.dart';
import '../../people/domain/person.dart';
import '../domain/project.dart';
import 'project_detail_view_model.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final provider = projectDetailViewModelProvider(projectId);
    final overview = ref.watch(provider);

    return LiquidScaffold(
      actions: [
        if (!ref.watch(calendarSyncSettingsControllerProvider).enabled)
          if (overview.value?.project.dueDate case final due?)
            IconButton(
              tooltip: l.addToDeviceCalendar,
              icon: const Icon(Icons.edit_calendar_rounded),
              onPressed: () async {
                final p = overview.value!.project;
                final ok = await DeviceCalendar.addAllDayEvent(
                  title: l.deviceCalendarProjectDue(p.title),
                  date: due,
                  description: p.description,
                );
                if (!ok && context.mounted) {
                  showError(context, l.deviceCalendarFailed);
                }
              },
            ),
        IconButton(
          tooltip: l.commonEdit,
          icon: const Icon(Icons.edit_rounded),
          onPressed: () => context.push(Routes.editProject(projectId)),
        ),
        IconButton(
          tooltip: l.commonDelete,
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: () async {
            final title = overview.value?.project.title ?? '';
            if (await confirmDelete(context, l.projectDeleteBody(title))) {
              final trash = ref.read(trashRepositoryProvider);
              await ref.read(provider.notifier).delete();
              if (context.mounted) context.pop();
              showToast(
                l.projectDeletedToast,
                undoLabel: l.undo,
                onUndo: () => trash.restoreProject(projectId),
              );
            }
          },
        ),
        const SizedBox(width: 4),
      ],
      body: AsyncView(
        value: overview,
        data: (o) => o == null
            ? EmptyState(
                icon: Icons.search_off_rounded,
                title: l.commonNotFound,
              )
            : _Body(overview: o),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.overview});

  final ProjectOverview overview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final p = overview.project;
    final vm = ref.read(projectDetailViewModelProvider(p.id).notifier);

    final children = <Widget>[
      // Liste kartından Hero ile "akan" başlık kartı.
      Hero(
        tag: 'project-${p.id}',
        child: Material(
          type: MaterialType.transparency,
          child: GlassSurface(
            blur: true,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    PopupMenuButton<ProjectStatus>(
                      tooltip: l.projectChangeStatus,
                      initialValue: p.status,
                      onSelected: vm.changeStatus,
                      itemBuilder: (_) => [
                        for (final s in ProjectStatus.values)
                          PopupMenuItem(
                            value: s,
                            child: Row(
                              children: [
                                Icon(
                                  s.icon,
                                  size: 18,
                                  color: context.semantic.status(
                                    s,
                                    theme.colorScheme,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(s.label(l)),
                              ],
                            ),
                          ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatusPill(p.status),
                          const Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ),
                    PriorityPill(p.priority),
                    if (p.dueDate != null)
                      DueDateBadge(p.dueDate!, closed: p.status.isClosed),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  p.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                if (p.description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    p.description!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Wrap(
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    if (p.startDate != null)
                      _Meta(
                        icon: Icons.play_circle_outline_rounded,
                        text:
                            '${l.fieldStartDate}: ${context.formatDate(p.startDate!)}',
                      ),
                    if (p.dueDate != null)
                      _Meta(
                        icon: Icons.flag_circle_outlined,
                        text:
                            '${l.fieldDueDate}: ${context.formatDate(p.dueDate!)}',
                      ),
                    _Meta(
                      icon: Icons.schedule_rounded,
                      text: l.projectCreated(
                        context.formatTimestamp(p.createdAt),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      SectionHeader(l.projectBoardSummary, icon: Icons.view_kanban_rounded),
      _BoardSummary(projectId: p.id, overview: overview),
      SectionHeader(l.projectPeople, icon: Icons.groups_rounded),
      GlassSurface(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.fieldResponsible, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            overview.responsible == null
                ? Text(l.commonNone, style: theme.textTheme.bodyMedium)
                : _PersonRow(overview.responsible!),
            const Divider(height: 24),
            Text(l.fieldRequesters, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            if (overview.requesters.isEmpty)
              Text(l.commonNone, style: theme.textTheme.bodyMedium)
            else
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [for (final r in overview.requesters) _PersonRow(r)],
              ),
          ],
        ),
      ),
      if (p.location != null) ...[
        SectionHeader(l.location, icon: Icons.place_rounded),
        LocationTile(place: p.location!),
      ],
      SectionHeader(l.projectDetails, icon: Icons.notes_rounded),
      GlassSurface(
        padding: const EdgeInsets.all(16),
        child: SelectableText(
          p.details ?? l.projectNoDetails,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: p.details == null
                ? theme.colorScheme.onSurfaceVariant
                : null,
            height: 1.45,
          ),
        ),
      ),
    ];

    return ListView(
      padding: liquidBodyPadding(context, bottom: 32),
      children: [
        children.first,
        for (var i = 1; i < children.length; i++)
          children[i]
              .animate()
              .fadeIn(duration: 300.ms, delay: (60 * i).ms)
              .slideY(begin: 0.05),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: c),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: c),
        ),
      ],
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow(this.person);

  final Person person;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      PersonAvatar(person, size: 30),
      const SizedBox(width: 8),
      Text(
        person.name,
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    ],
  );
}

/// Sütun bazında kart sayıları + board'a geçiş.
class _BoardSummary extends ConsumerWidget {
  const _BoardSummary({required this.projectId, required this.overview});

  final String projectId;
  final ProjectOverview overview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final board = ref.watch(boardViewModelProvider(projectId)).value;
    return GlassSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (board != null)
            SizedBox(
              height: 74,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: board.lanes.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final lane = board.lanes[i];
                  final color = colorFromHex(
                    lane.column.colorHex,
                    fallback: theme.colorScheme.primary,
                  );
                  return Container(
                    width: 112,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lane.column.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium,
                        ),
                        Text(
                          '${lane.cards.length}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (overview.totalCards > 0) ...[
            const SizedBox(height: 14),
            LinearProgressIndicator(value: overview.progress, minHeight: 8),
            const SizedBox(height: 6),
            Text(
              l.cardsProgress(overview.doneCards, overview.totalCards),
              style: theme.textTheme.labelSmall,
            ),
          ],
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () => context.push(Routes.board(projectId)),
            icon: const Icon(Icons.view_kanban_rounded),
            label: Text(l.projectOpenBoard),
          ),
        ],
      ),
    );
  }
}
