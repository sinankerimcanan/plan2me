import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/router/app_shell.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import '../domain/project.dart';
import '../domain/project_filters.dart';
import 'projects_view_model.dart';
import 'widgets/project_card.dart';
import 'widgets/project_filter_sheet.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  late final _search = TextEditingController(
    text: ref.read(projectFiltersControllerProvider).query,
  );

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final filters = ref.watch(projectFiltersControllerProvider);
    final projects = ref.watch(projectsViewModelProvider);
    final ctrl = ref.read(projectFiltersControllerProvider.notifier);

    return LiquidScaffold(
      title: Text(l.projectsTitle),
      actions: [
        PopupMenuButton<ProjectSort>(
          tooltip: l.sort,
          icon: const Icon(Icons.sort_rounded),
          initialValue: filters.sort,
          onSelected: ctrl.setSort,
          itemBuilder: (_) => [
            for (final s in ProjectSort.values)
              CheckedPopupMenuItem(
                value: s,
                checked: filters.sort == s,
                child: Text(_sortLabel(l, s)),
              ),
          ],
        ),
        IconButton(
          tooltip: l.projectsFilters,
          onPressed: () => showProjectFilterSheet(context),
          icon: Badge(
            isLabelVisible: filters.activeCount > 0,
            label: Text('${filters.activeCount}'),
            child: const Icon(Icons.tune_rounded),
          ),
        ),
        const SizedBox(width: 4),
      ],
      floatingActionButton: ShellFab(
        child: FloatingActionButton.extended(
          heroTag: 'fab-projects',
          onPressed: () => context.push(Routes.newProject),
          icon: const Icon(Icons.add_rounded),
          label: Text(l.projectsNew),
        ),
      ),
      body: Builder(
        builder: (context) => AsyncView(
          value: projects,
          data: (list) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: liquidBodyPadding(context).copyWith(bottom: 0),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    controller: _search,
                    onChanged: ctrl.setQuery,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: l.projectsSearchHint,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: filters.query.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _search.clear();
                                ctrl.setQuery('');
                              },
                            ),
                    ),
                  ),
                ),
              ),
              if (list.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: filters.isFiltering || filters.showClosed
                      ? EmptyState(
                          icon: Icons.filter_alt_off_rounded,
                          title: l.projectsNoMatch,
                          action: OutlinedButton(
                            onPressed: ctrl.clear,
                            child: Text(l.projectsClearFilters),
                          ),
                        )
                      : EmptyState(
                          icon: Icons.rocket_launch_rounded,
                          title: l.projectsEmptyTitle,
                          body: l.projectsEmptyBody,
                          action: FilledButton.icon(
                            onPressed: () => context.push(Routes.newProject),
                            icon: const Icon(Icons.add_rounded),
                            label: Text(l.projectsNew),
                          ),
                        ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    14,
                    16,
                    MediaQuery.paddingOf(context).bottom + 96,
                  ),
                  sliver: filters.canReorder
                      ? _reorderable(list)
                      : _plain(list),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plain(List<ProjectOverview> list) => SliverList.separated(
    itemCount: list.length,
    separatorBuilder: (_, _) => const SizedBox(height: 12),
    itemBuilder: (_, i) => _animated(ProjectCard(list[i]), i),
  );

  Widget _reorderable(List<ProjectOverview> list) => SliverReorderableList(
    itemCount: list.length,
    onReorderItem: (o, n) =>
        ref.read(projectsViewModelProvider.notifier).reorder(o, n),
    proxyDecorator: (child, _, animation) => AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Transform.scale(
        scale: 1 + 0.03 * Curves.easeOut.transform(animation.value),
        child: child,
      ),
      child: child,
    ),
    itemBuilder: (_, i) => ReorderableDelayedDragStartListener(
      key: ValueKey(list[i].project.id),
      index: i,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _animated(ProjectCard(list[i]), i),
      ),
    ),
  );

  Widget _animated(Widget child, int i) => child
      .animate()
      .fadeIn(duration: 280.ms, delay: (40 * i).clamp(0, 320).ms)
      .slideY(begin: 0.06, curve: Curves.easeOutCubic);

  String _sortLabel(AppLocalizations l, ProjectSort s) => switch (s) {
    ProjectSort.manual => l.sortManual,
    ProjectSort.priority => l.sortPriority,
    ProjectSort.dueDate => l.sortDueDate,
    ProjectSort.updated => l.sortUpdated,
  };
}
