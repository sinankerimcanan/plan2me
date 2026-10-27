import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_shell.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/person_avatar.dart';
import '../domain/person.dart';
import 'people_view_model.dart';
import 'person_form_sheet.dart';

class PeopleScreen extends ConsumerWidget {
  const PeopleScreen({super.key});

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final input = await showPersonForm(context);
    if (input == null) return;
    try {
      await ref.read(peopleViewModelProvider.notifier).create(input);
    } catch (e) {
      if (context.mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final people = ref.watch(peopleViewModelProvider);
    return LiquidScaffold(
      title: Text(l.peopleTitle),
      floatingActionButton: ShellFab(
        child: FloatingActionButton.extended(
          heroTag: 'fab-people',
          onPressed: () => _create(context, ref),
          icon: const Icon(Icons.person_add_alt_1_rounded),
          label: Text(l.personNew),
        ),
      ),
      body: Builder(
        builder: (context) => AsyncView(
          value: people,
          data: (list) {
            if (list.isEmpty) {
              return EmptyState(
                icon: Icons.groups_rounded,
                title: l.peopleEmptyTitle,
                body: l.peopleEmptyBody,
              );
            }
            return ListView.separated(
              padding: liquidBodyPadding(context, bottom: 96),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) => _PersonTile(list[i])
                  .animate()
                  .fadeIn(duration: 260.ms, delay: (30 * i).clamp(0, 300).ms)
                  .slideY(begin: 0.08, curve: Curves.easeOutCubic),
            );
          },
        ),
      ),
    );
  }
}

class _PersonTile extends ConsumerWidget {
  const _PersonTile(this.overview);

  final PersonOverview overview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final p = overview.person;
    final theme = Theme.of(context);
    final vm = ref.read(peopleViewModelProvider.notifier);

    Future<void> edit() async {
      final input = await showPersonForm(context, initial: p);
      if (input != null) await vm.save(p.id, input);
    }

    Future<void> delete() async {
      if (await confirmDelete(context, l.personDeleteBody(p.name))) {
        await vm.delete(p.id);
      }
    }

    return GlassSurface(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: edit,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
          child: Row(
            children: [
              PersonAvatar(p, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            p.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (p.isMe) ...[
                          const SizedBox(width: 8),
                          Pill(
                            label: l.personMe,
                            color: theme.colorScheme.primary,
                            dense: true,
                          ),
                        ],
                      ],
                    ),
                    if (p.role != null || p.email != null)
                      Text(
                        [p.role, p.email].whereType<String>().join(' · '),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      l.personStats(
                        overview.responsibleCount,
                        overview.requestedCount,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (v) => v == 'edit' ? edit() : delete(),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: const Icon(Icons.edit_rounded),
                      title: Text(l.commonEdit),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: const Icon(Icons.delete_outline_rounded),
                      title: Text(l.commonDelete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
