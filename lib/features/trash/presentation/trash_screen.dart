import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/toast.dart';
import '../data/trash_providers.dart';
import '../domain/trash_item.dart';

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final items = ref.watch(trashItemsProvider);
    final repo = ref.read(trashRepositoryProvider);

    return LiquidScaffold(
      title: Text(l.trashTitle),
      actions: [
        if (items.value?.isNotEmpty ?? false)
          TextButton(
            onPressed: () async {
              if (await confirmDelete(context, l.trashEmptyConfirm)) {
                await repo.emptyTrash();
              }
            },
            child: Text(l.trashEmptyAll),
          ),
        const SizedBox(width: 4),
      ],
      body: AsyncView(
        value: items,
        data: (list) => list.isEmpty
            ? EmptyState(
                icon: Icons.delete_outline_rounded,
                title: l.trashEmptyTitle,
                body: l.trashHelp,
              )
            : ListView.separated(
                padding: liquidBodyPadding(context, bottom: 32),
                itemCount: list.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                      child: Text(
                        l.trashHelp,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return _TrashTile(list[i - 1]);
                },
              ),
      ),
    );
  }
}

class _TrashTile extends ConsumerWidget {
  const _TrashTile(this.item);

  final TrashItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final repo = ref.read(trashRepositoryProvider);
    final (icon, kind) = switch (item.kind) {
      TrashKind.project => (Icons.folder_rounded, l.trashKindProject),
      TrashKind.card => (Icons.task_alt_rounded, l.trashKindCard),
      TrashKind.person => (Icons.person_rounded, l.trashKindPerson),
    };
    return GlassSurface(
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        leading: Icon(icon),
        title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          [
            kind,
            ?item.subtitle,
            l.trashDeletedOn(context.formatTimestamp(item.deletedAt)),
          ].join(' · '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: l.trashRestore,
              icon: const Icon(Icons.restore_rounded),
              onPressed: () async {
                await repo.restore(item);
                showToast(l.trashRestored);
              },
            ),
            IconButton(
              tooltip: l.trashPurge,
              icon: const Icon(Icons.delete_forever_rounded),
              onPressed: () async {
                if (await confirmDelete(
                  context,
                  l.trashPurgeConfirm(item.title),
                )) {
                  await repo.purge(item);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
