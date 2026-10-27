import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/toast.dart';
import '../../projects/data/projects_providers.dart';
import '../domain/task_item.dart';
import 'quick_add_sheet.dart';
import 'tasks_view_model.dart';
import 'widgets/task_tile.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key, this.openQuickAdd = false});

  /// Ana ekran kısayolundan gelindiyse hızlı ekleme kendiliğinden açılır.
  final bool openQuickAdd;

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openQuickAdd) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showQuickAddSheet(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final filter = ref.watch(taskFilterControllerProvider);
    final ctrl = ref.read(taskFilterControllerProvider.notifier);
    final state = ref.watch(tasksViewModelProvider);
    final inboxId = ref.watch(inboxProjectIdProvider).value;

    return LiquidScaffold(
      title: Text(l.tasksTitle),
      actions: [
        if (inboxId != null)
          IconButton(
            tooltip: l.openInbox,
            icon: const Icon(Icons.inbox_rounded),
            onPressed: () => context.push(Routes.board(inboxId)),
          ),
        IconButton(
          tooltip: l.tasksShowCompleted,
          isSelected: filter.showCompleted,
          icon: const Icon(Icons.task_alt_outlined),
          selectedIcon: const Icon(Icons.task_alt_rounded),
          onPressed: ctrl.toggleCompleted,
        ),
        const SizedBox(width: 4),
      ],
      body: Builder(
        builder: (context) => AsyncView(
          value: state,
          data: (s) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: liquidBodyPadding(context).copyWith(bottom: 4),
                sliver: SliverToBoxAdapter(
                  child: SegmentedButton<TaskScope>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: TaskScope.all,
                        icon: const Icon(Icons.all_inbox_rounded),
                        label: Text('${l.tasksAll} · ${s.openCount}'),
                      ),
                      ButtonSegment(
                        value: TaskScope.mine,
                        icon: const Icon(Icons.person_rounded),
                        label: Text(l.tasksMine),
                      ),
                    ],
                    selected: {filter.scope},
                    onSelectionChanged: (v) => ctrl.setScope(v.first),
                  ),
                ),
              ),
              if (s.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    icon: filter.scope == TaskScope.mine
                        ? Icons.person_search_rounded
                        : Icons.celebration_rounded,
                    title: l.tasksEmptyTitle,
                    body: filter.scope == TaskScope.mine
                        ? (s.meId == null ? l.tasksNoMe : l.tasksMineEmpty)
                        : l.tasksEmptyBody,
                    action: FilledButton.icon(
                      onPressed: () => showQuickAddSheet(context),
                      icon: const Icon(Icons.add_task_rounded),
                      label: Text(l.taskAdd),
                    ),
                  ),
                )
              else
                for (final group in TaskGroup.values)
                  if (s.groups[group]!.isNotEmpty)
                    ..._section(context, group, s.groups[group]!),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _section(
    BuildContext context,
    TaskGroup group,
    List<TaskItem> items,
  ) {
    final theme = Theme.of(context);
    final color = switch (group) {
      TaskGroup.overdue => context.semantic.overdue,
      TaskGroup.today => theme.colorScheme.primary,
      TaskGroup.completed => context.semantic.success,
      _ => theme.colorScheme.onSurfaceVariant,
    };
    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Row(
            children: [
              Icon(taskGroupIcon(group), size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                taskGroupLabel(context.l10n, group),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${items.length}',
                  style: theme.textTheme.labelMedium?.copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, i) =>
              TaskRow(key: ValueKey(items[i].card.id), task: items[i])
                  .animate()
                  .fadeIn(duration: 220.ms, delay: (25 * i).clamp(0, 200).ms)
                  .slideX(begin: 0.03, curve: Curves.easeOutCubic),
        ),
      ),
    ];
  }
}

/// Kaydırma eylemli görev satırı: sağa kaydır = tamamla, sola kaydır = yarına ertele.
class TaskRow extends ConsumerWidget {
  const TaskRow({super.key, required this.task, this.showDue = true});

  final TaskItem task;
  final bool showDue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final vm = ref.read(tasksViewModelProvider.notifier);
    final s = context.semantic;

    Future<void> toggle() async {
      try {
        final result = await vm.toggleComplete(task);
        showToast(
          result.completed ? l.taskCompletedToast : l.taskReopenedToast,
          undoLabel: l.undo,
          onUndo: result.undo,
        );
      } catch (e) {
        if (context.mounted) showError(context, e);
      }
    }

    Widget background(
      Alignment align,
      Color color,
      IconData icon,
      String text,
    ) => Container(
      alignment: align,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return Dismissible(
      key: ValueKey('dismiss-${task.card.id}-${task.isCompleted}'),
      direction: task.isCompleted
          ? DismissDirection.startToEnd
          : DismissDirection.horizontal,
      background: background(
        Alignment.centerLeft,
        s.success,
        task.isCompleted ? Icons.undo_rounded : Icons.check_rounded,
        task.isCompleted ? l.taskReopen : l.taskComplete,
      ),
      secondaryBackground: background(
        Alignment.centerRight,
        s.priorityMedium,
        Icons.snooze_rounded,
        l.taskSnooze,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await toggle();
        } else {
          final undo = await vm.snooze(task);
          showToast(l.taskSnoozedToast, undoLabel: l.undo, onUndo: undo);
        }
        // Liste stream'den güncellenir; Dismissible'ın satırı kendisi kaldırmasına gerek yok.
        return false;
      },
      child: TaskTile(
        task: task,
        showDue: showDue,
        onToggle: toggle,
        onTap: () => context.push(Routes.taskCard(task.card.id)),
      ),
    );
  }
}

String taskGroupLabel(AppLocalizations l, TaskGroup g) => switch (g) {
  TaskGroup.overdue => l.taskGroupOverdue,
  TaskGroup.today => l.taskGroupToday,
  TaskGroup.tomorrow => l.taskGroupTomorrow,
  TaskGroup.thisWeek => l.taskGroupThisWeek,
  TaskGroup.later => l.taskGroupLater,
  TaskGroup.noDate => l.taskGroupNoDate,
  TaskGroup.completed => l.taskGroupCompleted,
};

IconData taskGroupIcon(TaskGroup g) => switch (g) {
  TaskGroup.overdue => Icons.warning_amber_rounded,
  TaskGroup.today => Icons.today_rounded,
  TaskGroup.tomorrow => Icons.wb_twilight_rounded,
  TaskGroup.thisWeek => Icons.date_range_rounded,
  TaskGroup.later => Icons.event_note_rounded,
  TaskGroup.noDate => Icons.all_inclusive_rounded,
  TaskGroup.completed => Icons.task_alt_rounded,
};
