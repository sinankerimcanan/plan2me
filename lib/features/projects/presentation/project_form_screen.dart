import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/enums.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/widgets/common.dart';
import '../../people/data/people_providers.dart';
import '../../location/presentation/location_picker_sheet.dart';
import '../../location/presentation/location_tile.dart';
import '../../people/presentation/person_form_sheet.dart';
import '../domain/project.dart';
import 'project_form_view_model.dart';
import 'widgets/person_picker.dart';

class ProjectFormScreen extends ConsumerWidget {
  const ProjectFormScreen({super.key, this.projectId});

  final String? projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final provider = projectFormViewModelProvider(projectId);
    final draft = ref.watch(provider);

    Future<void> save() async {
      final vm = ref.read(provider.notifier);
      if (!vm.canSave) {
        showError(context, l.fieldTitleRequired);
        return;
      }
      try {
        final id = await vm.save(
          defaultColumns: [
            l.defaultColumnTodo,
            l.defaultColumnDoing,
            l.defaultColumnDone,
          ],
        );
        if (!context.mounted || id == null) return;
        if (projectId == null) {
          // Yeni proje: formu detay sayfasıyla değiştir.
          context.pushReplacement(Routes.project(id));
        } else {
          context.pop();
        }
      } catch (e) {
        if (context.mounted) showError(context, e);
      }
    }

    return LiquidScaffold(
      title: Text(projectId == null ? l.projectFormNew : l.projectFormEdit),
      actions: [
        TextButton.icon(
          onPressed: save,
          icon: const Icon(Icons.check_rounded),
          label: Text(l.commonSave),
        ),
        const SizedBox(width: 8),
      ],
      body: AsyncView(
        value: draft,
        data: (d) => _Form(projectId: projectId, draft: d, onSave: save),
      ),
    );
  }
}

class _Form extends ConsumerWidget {
  const _Form({
    required this.projectId,
    required this.draft,
    required this.onSave,
  });

  final String? projectId;
  final ProjectDraft draft;
  final VoidCallback onSave;

  Future<DateTime?> _pickDate(
    BuildContext context,
    DateTime? initial, {
    DateTime? first,
  }) => showDatePicker(
    context: context,
    initialDate: initial ?? first ?? DateTime.now(),
    firstDate: first ?? DateTime(2000),
    lastDate: DateTime(2100),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final vm = ref.read(projectFormViewModelProvider(projectId).notifier);
    final people = ref.watch(allPeopleProvider).value ?? const [];

    Widget section(String title, IconData icon, Widget child) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );

    Widget dateField(
      String label,
      DateTime? value,
      ValueChanged<DateTime?> onChanged, {
      DateTime? first,
    }) => Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () async {
          final d = await _pickDate(context, value, first: first);
          if (d != null) onChanged(d);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.event_rounded),
            suffixIcon: value == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    onPressed: () => onChanged(null),
                  ),
          ),
          child: Text(value == null ? l.pickDate : context.formatDate(value)),
        ),
      ),
    );

    return ListView(
      padding: liquidBodyPadding(context, bottom: 32),
      children: [
        section(
          l.fieldTitle,
          Icons.title_rounded,
          Column(
            children: [
              TextFormField(
                initialValue: draft.title,
                autofocus: projectId == null,
                textCapitalization: TextCapitalization.sentences,
                onChanged: vm.setTitle,
                style: theme.textTheme.titleMedium,
                decoration: InputDecoration(hintText: l.fieldTitle),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: draft.description,
                onChanged: vm.setDescription,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 2,
                decoration: InputDecoration(hintText: l.fieldDescription),
              ),
            ],
          ),
        ),
        section(
          l.priority,
          Icons.flag_rounded,
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
                  selected: draft.priority == p,
                  onSelected: (_) => vm.setPriority(p),
                ),
            ],
          ),
        ),
        section(
          l.status,
          Icons.timeline_rounded,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in ProjectStatus.values)
                ChoiceChip(
                  showCheckmark: false,
                  avatar: Icon(
                    s.icon,
                    size: 18,
                    color: context.semantic.status(s, theme.colorScheme),
                  ),
                  label: Text(s.label(l)),
                  selected: draft.status == s,
                  onSelected: (_) => vm.setStatus(s),
                ),
            ],
          ),
        ),
        section(
          l.fieldDates,
          Icons.date_range_rounded,
          Row(
            children: [
              dateField(l.fieldStartDate, draft.startDate, vm.setStartDate),
              const SizedBox(width: 10),
              dateField(
                l.fieldDueDate,
                draft.dueDate,
                vm.setDueDate,
                first: draft.startDate,
              ),
            ],
          ),
        ),
        section(
          l.fieldResponsible,
          Icons.person_pin_rounded,
          ResponsiblePicker(
            people: people,
            selectedId: draft.responsiblePersonId,
            onChanged: vm.setResponsible,
          ),
        ),
        section(
          l.fieldRequesters,
          Icons.campaign_rounded,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (people.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(l.noPeopleYet, style: theme.textTheme.bodySmall),
                ),
              RequestersPicker(
                people: people,
                selectedIds: draft.requesterIds,
                onToggle: vm.toggleRequester,
                onAddNew: () async {
                  final input = await showPersonForm(context);
                  if (input != null) await vm.createRequester(input);
                },
              ),
            ],
          ),
        ),
        section(
          l.location,
          Icons.place_rounded,
          Builder(
            builder: (context) {
              Future<void> pick() async {
                final result = await showLocationPicker(
                  context,
                  initial: draft.location,
                );
                switch (result) {
                  case LocationPicked(:final place):
                    vm.setLocation(place);
                  case LocationCleared():
                    vm.setLocation(null);
                  case null:
                    break;
                }
              }

              return draft.location == null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: pick,
                        icon: const Icon(Icons.add_location_alt_rounded),
                        label: Text(l.locationAdd),
                      ),
                    )
                  : LocationTile(place: draft.location!, onEdit: pick);
            },
          ),
        ),
        section(
          l.fieldDetails,
          Icons.notes_rounded,
          TextFormField(
            initialValue: draft.details,
            onChanged: vm.setDetails,
            minLines: 4,
            maxLines: 12,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: l.fieldDetailsHint),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.check_rounded),
          label: Text(l.commonSave),
        ),
      ],
    );
  }
}
