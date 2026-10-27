import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/utils/clock.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../../../core/widgets/person_avatar.dart';
import '../../../core/widgets/toast.dart';
import '../../board/domain/board_models.dart';
import '../../people/data/people_providers.dart';
import '../../projects/data/projects_providers.dart';
import '../domain/task_item.dart';
import 'tasks_view_model.dart';

/// Her yerden açılabilen hızlı görev ekleme. Enter ile ekler ve açık kalır.
Future<void> showQuickAddSheet(
  BuildContext context, {
  String? projectId,
  DateTime? date,
}) => showGlassSheet<void>(
  context,
  builder: (_) => QuickAddSheet(initialProjectId: projectId, initialDate: date),
);

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key, this.initialProjectId, this.initialDate});

  final String? initialProjectId;
  final DateTime? initialDate;

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  final _title = TextEditingController();
  final _focus = FocusNode();
  late String? _projectId = widget.initialProjectId;
  late DateTime? _due = widget.initialDate == null
      ? null
      : dateOnly(widget.initialDate!);
  Priority _priority = Priority.medium;
  String? _assigneeId;
  Recurrence? _recurrence;
  bool _more = false;
  bool _saving = false;
  int _added = 0;

  @override
  void initState() {
    super.initState();
    // Varsayılan sorumlu: "ben".
    ref.read(allPeopleProvider.future).then((people) {
      final me = people.where((p) => p.isMe).firstOrNull;
      if (mounted && _assigneeId == null && me != null) {
        setState(() => _assigneeId = me.id);
      }
    }, onError: (_) {});
  }

  @override
  void dispose() {
    _title.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit({required bool close}) async {
    final title = _title.text.trim();
    if (title.isEmpty || _saving) {
      if (close && title.isEmpty) Navigator.pop(context);
      return;
    }
    final l = context.l10n;
    setState(() => _saving = true);
    try {
      await ref
          .read(tasksViewModelProvider.notifier)
          .addTask(
            QuickTaskInput(
              title: title,
              projectId: _projectId,
              dueDate: _due,
              extra: CardPatch(
                priority: _priority,
                assigneePersonId: _assigneeId,
                recurrence: _recurrence,
              ),
            ),
            inboxTitle: l.inboxTitle,
            defaultColumns: [
              l.defaultColumnTodo,
              l.defaultColumnDoing,
              l.defaultColumnDone,
            ],
          );
      if (!mounted) return;
      _title.clear();
      setState(() => _added++);
      if (close) {
        Navigator.pop(context);
        showToast(l.taskAdded);
      } else {
        _focus.requestFocus();
      }
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  DateTime _nextWeekday(int weekday) {
    final t = today();
    var d = t.add(const Duration(days: 1));
    while (d.weekday != weekday) {
      d = d.add(const Duration(days: 1));
    }
    return d;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final projects = ref.watch(projectOverviewsProvider).value ?? const [];
    final people = ref.watch(allPeopleProvider).value ?? const [];
    final t = today();
    final dateOptions = <(String, DateTime?)>[
      (l.dateToday, t),
      (l.dateTomorrow, t.add(const Duration(days: 1))),
      (l.dateWeekend, _nextWeekday(DateTime.saturday)),
      (l.dateNextWeek, _nextWeekday(DateTime.monday)),
      (l.dateNone, null),
    ];
    final customDate = _due != null && !dateOptions.any((o) => o.$2 == _due);

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8),
      child: Text(
        text,
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
                l.taskAdd,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (_added > 0)
              Text(
                '+$_added',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: context.semantic.success,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _title,
          focusNode: _focus,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.send,
          onSubmitted: (_) => _submit(close: false),
          decoration: InputDecoration(
            hintText: l.taskTitleHint,
            prefixIcon: const Icon(Icons.add_task_rounded),
          ),
        ),
        label(l.fieldDueDate),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (text, date) in dateOptions)
              ChoiceChip(
                showCheckmark: false,
                label: Text(text),
                selected: _due == date,
                onSelected: (_) => setState(() => _due = date),
              ),
            ActionChip(
              avatar: const Icon(Icons.calendar_month_rounded, size: 18),
              label: Text(customDate ? context.formatDate(_due!) : l.pickDate),
              backgroundColor: customDate
                  ? theme.colorScheme.primaryContainer
                  : null,
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _due ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _due = dateOnly(d));
              },
            ),
          ],
        ),
        label(l.taskProject),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ChoiceChip(
                showCheckmark: false,
                avatar: const Icon(Icons.inbox_rounded, size: 18),
                label: Text(l.inboxTitle),
                selected: _projectId == null,
                onSelected: (_) => setState(() => _projectId = null),
              ),
              for (final o in projects.where(
                (o) => !o.project.status.isClosed,
              )) ...[
                const SizedBox(width: 8),
                ChoiceChip(
                  showCheckmark: false,
                  label: Text(o.project.title),
                  selected: _projectId == o.project.id,
                  onSelected: (_) => setState(() => _projectId = o.project.id),
                ),
              ],
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _more = !_more),
            icon: Icon(_more ? Icons.expand_less_rounded : Icons.tune_rounded),
            label: Text(l.taskMore),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: !_more
              ? const SizedBox(width: double.infinity)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label(l.priority),
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
                            selected: _priority == p,
                            onSelected: (_) => setState(() => _priority = p),
                          ),
                      ],
                    ),
                    if (people.isNotEmpty) ...[
                      label(l.taskAssignee),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            showCheckmark: false,
                            label: Text(l.commonNone),
                            selected: _assigneeId == null,
                            onSelected: (_) =>
                                setState(() => _assigneeId = null),
                          ),
                          for (final p in people)
                            ChoiceChip(
                              showCheckmark: false,
                              avatar: PersonAvatar(p, size: 22),
                              label: Text(p.name),
                              selected: _assigneeId == p.id,
                              onSelected: (_) =>
                                  setState(() => _assigneeId = p.id),
                            ),
                        ],
                      ),
                    ],
                    label(l.recurrence),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final r in <Recurrence?>[
                          null,
                          ...Recurrence.values,
                        ])
                          ChoiceChip(
                            showCheckmark: false,
                            avatar: r == null
                                ? null
                                : const Icon(Icons.repeat_rounded, size: 16),
                            label: Text(r.label(l)),
                            selected: _recurrence == r,
                            onSelected: (_) => setState(() => _recurrence = r),
                          ),
                      ],
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _saving ? null : () => _submit(close: true),
          icon: const Icon(Icons.check_rounded),
          label: Text(l.commonAdd),
        ),
      ],
    );
  }
}
