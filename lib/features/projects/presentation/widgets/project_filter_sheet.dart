import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/widgets/glass_sheet.dart';
import '../../../../core/widgets/person_avatar.dart';
import '../../../people/data/people_providers.dart';
import '../projects_view_model.dart';

Future<void> showProjectFilterSheet(BuildContext context) =>
    showGlassSheet<void>(context, builder: (_) => const ProjectFilterSheet());

class ProjectFilterSheet extends ConsumerWidget {
  const ProjectFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final filters = ref.watch(projectFiltersControllerProvider);
    final ctrl = ref.read(projectFiltersControllerProvider.notifier);
    final people = ref.watch(allPeopleProvider).value ?? const [];

    Widget title(String t) => Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        t,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l.projectsFilters,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: ctrl.clear,
              child: Text(l.projectsClearFilters),
            ),
          ],
        ),
        title(l.status),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in ProjectStatus.values)
              FilterChip(
                showCheckmark: false,
                avatar: Icon(
                  s.icon,
                  size: 18,
                  color: context.semantic.status(s, theme.colorScheme),
                ),
                label: Text(s.label(l)),
                selected: filters.statuses.contains(s),
                onSelected: (_) => ctrl.toggleStatus(s),
              ),
          ],
        ),
        title(l.priority),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in Priority.values.reversed)
              FilterChip(
                showCheckmark: false,
                avatar: Icon(
                  p.icon,
                  size: 18,
                  color: context.semantic.priority(p),
                ),
                label: Text(p.label(l)),
                selected: filters.priorities.contains(p),
                onSelected: (_) => ctrl.togglePriority(p),
              ),
          ],
        ),
        if (people.isNotEmpty) ...[
          title(l.fieldResponsible),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in people)
                ChoiceChip(
                  showCheckmark: false,
                  avatar: PersonAvatar(p, size: 22),
                  label: Text(p.name),
                  selected: filters.responsibleId == p.id,
                  onSelected: (sel) => ctrl.setResponsible(sel ? p.id : null),
                ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.projectsShowClosed),
          value: filters.showClosed,
          onChanged: ctrl.setShowClosed,
        ),
      ],
    );
  }
}
