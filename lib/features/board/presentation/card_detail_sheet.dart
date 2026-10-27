import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/services/device_calendar.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../core/widgets/person_avatar.dart';
import '../../../core/widgets/toast.dart';
import '../../people/data/people_providers.dart';
import '../../calendar_sync/data/calendar_sync_providers.dart';
import '../../location/presentation/location_picker_sheet.dart';
import '../../location/presentation/location_tile.dart';
import '../../trash/data/trash_providers.dart';
import '../domain/board_models.dart';
import 'card_detail_view_model.dart';
import 'label_manager_sheet.dart';

/// Kart detayı; go_router üzerinden alt sayfa (bottom sheet) rotası olarak açılır.
class CardDetailSheet extends ConsumerWidget {
  const CardDetailSheet({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(cardDetailViewModelProvider(cardId));
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.88,
      minChildSize: 0.4,
      maxChildSize: 0.96,
      builder: (context, scroll) => GlassSurface(
        blur: true,
        sigma: 24,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.82 : 0.75,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: AsyncView(
          value: detail,
          data: (d) {
            if (d == null) {
              // Kart silindiyse sayfayı kapat.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) Navigator.of(context).maybePop();
              });
              return const SizedBox.shrink();
            }
            return _Content(detail: d, scroll: scroll);
          },
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.detail, required this.scroll});

  final CardDetail detail;
  final ScrollController scroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final card = detail.card;
    final vm = ref.read(cardDetailViewModelProvider(card.id).notifier);
    final insets = MediaQuery.viewInsetsOf(context).bottom;

    return ListView(
      controller: scroll,
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        24 + insets + MediaQuery.paddingOf(context).bottom,
      ),
      children: [
        const SheetHandle(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              tooltip: card.isCompleted ? l.taskReopen : l.taskComplete,
              iconSize: 30,
              color: card.isCompleted
                  ? context.semantic.success
                  : theme.colorScheme.onSurfaceVariant,
              icon: Icon(
                card.isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
              ),
              onPressed: () async {
                final r = await vm.toggleComplete();
                showToast(
                  r.completed ? l.taskCompletedToast : l.taskReopenedToast,
                  undoLabel: l.undo,
                  onUndo: r.undo,
                );
              },
            ),
            Expanded(
              child: CommitTextField(
                value: card.title,
                onCommit: vm.setTitle,
                maxLines: null,
                textInputAction: TextInputAction.done,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: false,
                  isDense: true,
                ),
              ),
            ),
            IconButton(
              tooltip: l.commonDelete,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () async {
                if (await confirmDelete(context, l.cardDeleteBody)) {
                  final trash = ref.read(trashRepositoryProvider);
                  await vm.delete();
                  if (context.mounted) Navigator.of(context).maybePop();
                  showToast(
                    l.taskDeletedToast,
                    undoLabel: l.undo,
                    onUndo: () => trash.restoreCard(card.id),
                  );
                }
              },
            ),
          ],
        ),
        if (card.completedAt != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: context.semantic.success,
                ),
                const SizedBox(width: 6),
                Text(
                  l.cardCompletedOn(context.formatTimestamp(card.completedAt!)),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: context.semantic.success,
                  ),
                ),
              ],
            ),
          ),
        SectionHeader(l.cardColumn, icon: Icons.view_column_rounded),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final c in detail.columns)
              ChoiceChip(
                showCheckmark: false,
                avatar: c.isDoneColumn
                    ? const Icon(Icons.verified_rounded, size: 16)
                    : null,
                label: Text(c.name),
                selected: c.id == card.columnId,
                onSelected: (_) => vm.moveToColumn(c.id),
              ),
          ],
        ),
        SectionHeader(l.priority, icon: Icons.flag_rounded),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in Priority.values)
              ChoiceChip(
                showCheckmark: false,
                avatar: Icon(
                  p.icon,
                  size: 18,
                  color: context.semantic.priority(p),
                ),
                label: Text(p.label(l)),
                selected: card.priority == p,
                onSelected: (_) => vm.setPriority(p),
              ),
          ],
        ),
        SectionHeader(l.fieldDueDate, icon: Icons.event_rounded),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month_rounded),
                label: Text(
                  card.dueDate == null
                      ? l.pickDate
                      : '${context.formatDate(card.dueDate!)} · ${context.relativeDue(card.dueDate!)}',
                ),
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: card.dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) await vm.setDueDate(d);
                },
              ),
            ),
            if (card.dueDate != null) ...[
              if (!ref.watch(calendarSyncSettingsControllerProvider).enabled)
                IconButton(
                  tooltip: l.addToDeviceCalendar,
                  icon: const Icon(Icons.edit_calendar_rounded),
                  onPressed: () async {
                    final ok = await DeviceCalendar.addAllDayEvent(
                      title: card.title,
                      date: card.dueDate!,
                      description: card.description,
                      recurrence: card.recurrence,
                    );
                    if (!ok && context.mounted) {
                      showError(context, l.deviceCalendarFailed);
                    }
                  },
                ),
              IconButton(
                tooltip: l.commonClear,
                icon: const Icon(Icons.close_rounded),
                onPressed: () => vm.setDueDate(null),
              ),
            ],
          ],
        ),
        SectionHeader(l.location, icon: Icons.place_rounded),
        Builder(
          builder: (context) {
            Future<void> pick() async {
              final result = await showLocationPicker(
                context,
                initial: card.location,
              );
              switch (result) {
                case LocationPicked(:final place):
                  await vm.setLocation(place);
                case LocationCleared():
                  await vm.setLocation(null);
                case null:
                  break;
              }
            }

            return card.location == null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: pick,
                      icon: const Icon(Icons.add_location_alt_rounded),
                      label: Text(l.locationAdd),
                    ),
                  )
                : LocationTile(place: card.location!, onEdit: pick);
          },
        ),
        SectionHeader(l.taskAssignee, icon: Icons.person_pin_rounded),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              showCheckmark: false,
              label: Text(l.commonNone),
              selected: card.assigneePersonId == null,
              onSelected: (_) => vm.setAssignee(null),
            ),
            for (final p in ref.watch(allPeopleProvider).value ?? const [])
              ChoiceChip(
                showCheckmark: false,
                avatar: PersonAvatar(p, size: 22),
                label: Text(p.name),
                selected: card.assigneePersonId == p.id,
                onSelected: (_) => vm.setAssignee(p.id),
              ),
          ],
        ),
        SectionHeader(l.recurrence, icon: Icons.repeat_rounded),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in <Recurrence?>[null, ...Recurrence.values])
              ChoiceChip(
                showCheckmark: false,
                label: Text(r.label(l)),
                selected: card.recurrence == r,
                onSelected: (_) => vm.setRecurrence(r),
              ),
          ],
        ),
        SectionHeader(
          l.cardLabels,
          icon: Icons.label_rounded,
          trailing: TextButton(
            onPressed: () => showLabelManager(context, card.projectId),
            child: Text(l.labelsManage),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final label in detail.projectLabels)
              FilterChip(
                showCheckmark: false,
                avatar: CircleAvatar(
                  radius: 7,
                  backgroundColor: colorFromHex(label.colorHex),
                ),
                label: Text(label.name),
                selected: detail.labelIds.contains(label.id),
                selectedColor: colorFromHex(label.colorHex)
                    .withValues(alpha: 0.28),
                onSelected: (v) => vm.toggleLabel(label.id, enabled: v),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 18),
              label: Text(l.labelNew),
              onPressed: () async {
                final input = await showLabelEditor(context);
                if (input != null) {
                  await vm.createAndAttachLabel(
                    card.projectId,
                    input.name,
                    input.colorHex,
                  );
                }
              },
            ),
          ],
        ),
        SectionHeader(l.cardDescription, icon: Icons.notes_rounded),
        CommitTextField(
          value: card.description ?? '',
          onCommit: vm.setDescription,
          minLines: 3,
          maxLines: 12,
          decoration: InputDecoration(hintText: l.cardDescriptionHint),
        ),
        _ChecklistSection(detail: detail),
      ],
    );
  }
}

class _ChecklistSection extends ConsumerStatefulWidget {
  const _ChecklistSection({required this.detail});

  final CardDetail detail;

  @override
  ConsumerState<_ChecklistSection> createState() => _ChecklistSectionState();
}

class _ChecklistSectionState extends ConsumerState<_ChecklistSection> {
  final _newItem = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _newItem.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final d = widget.detail;
    final vm = ref.read(cardDetailViewModelProvider(d.card.id).notifier);
    final total = d.checklist.length;
    final done = d.checklistDone;

    Future<void> add() async {
      final text = _newItem.text;
      _newItem.clear();
      await vm.addChecklistItem(text);
      _focus.requestFocus();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          l.cardChecklist,
          icon: Icons.checklist_rounded,
          trailing: total == 0
              ? null
              : Text('$done/$total', style: theme.textTheme.labelLarge),
        ),
        if (total > 0) ...[
          TweenAnimationBuilder<double>(
            tween: Tween(end: done / total),
            duration: const Duration(milliseconds: 350),
            builder: (_, v, _) =>
                LinearProgressIndicator(value: v, minHeight: 6),
          ),
          const SizedBox(height: 8),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: d.checklist.length,
            onReorderItem: vm.reorderChecklist,
            itemBuilder: (context, i) {
              final item = d.checklist[i];
              return Material(
                key: ValueKey(item.id),
                type: MaterialType.transparency,
                child: Row(
                  children: [
                    Checkbox(
                      value: item.isDone,
                      onChanged: (v) =>
                          vm.toggleChecklistItem(item.id, done: v ?? false),
                    ),
                    Expanded(
                      child: CommitTextField(
                        value: item.title,
                        onCommit: (t) => vm.renameChecklistItem(item.id, t),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: item.isDone
                              ? theme.colorScheme.onSurfaceVariant
                              : null,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          filled: false,
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.close_rounded, size: 18),
                      onPressed: () => vm.deleteChecklistItem(item.id),
                    ),
                    ReorderableDragStartListener(
                      index: i,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.drag_indicator_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        const SizedBox(height: 6),
        TextField(
          controller: _newItem,
          focusNode: _focus,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => add(),
          decoration: InputDecoration(
            hintText: l.cardChecklistHint,
            prefixIcon: const Icon(Icons.add_task_rounded),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: add,
            ),
          ),
        ),
      ],
    );
  }
}
