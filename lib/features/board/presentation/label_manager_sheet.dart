import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../domain/board_models.dart';
import 'board_view_model.dart';

typedef LabelInput = ({String name, String colorHex});

Future<void> showLabelManager(BuildContext context, String projectId) =>
    showGlassSheet<void>(
      context,
      builder: (_) => LabelManagerSheet(projectId: projectId),
    );

Future<LabelInput?> showLabelEditor(BuildContext context, {Label? initial}) =>
    showGlassSheet<LabelInput>(
      context,
      builder: (_) => _LabelEditor(initial: initial),
    );

class LabelManagerSheet extends ConsumerWidget {
  const LabelManagerSheet({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final provider = boardViewModelProvider(projectId);
    final labels = ref.watch(provider).value?.labels ?? const [];
    final vm = ref.read(provider.notifier);

    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          l.labelsManage,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (labels.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(l.cardNoLabels),
          ),
        for (final label in labels)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 10,
              backgroundColor: colorFromHex(label.colorHex),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: LabelPill(
                name: label.name,
                colorHex: label.colorHex,
                dense: false,
              ),
            ),
            onTap: () async {
              final input = await showLabelEditor(context, initial: label);
              if (input != null) {
                await vm.updateLabel(label.id, input.name, input.colorHex);
              }
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () async {
                if (await confirmDelete(
                  context,
                  l.labelDeleteBody(label.name),
                )) {
                  await vm.deleteLabel(label.id);
                }
              },
            ),
          ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () async {
            final input = await showLabelEditor(context);
            if (input != null) await vm.createLabel(input.name, input.colorHex);
          },
          icon: const Icon(Icons.new_label_rounded),
          label: Text(l.labelNew),
        ),
      ],
    );
  }
}

class _LabelEditor extends StatefulWidget {
  const _LabelEditor({this.initial});

  final Label? initial;

  @override
  State<_LabelEditor> createState() => _LabelEditorState();
}

class _LabelEditorState extends State<_LabelEditor> {
  late final _name = TextEditingController(text: widget.initial?.name);
  late String _color = widget.initial?.colorHex ?? kPalette.first;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() {
    if (_name.text.trim().isEmpty) return;
    Navigator.pop<LabelInput>(context, (
      name: _name.text.trim(),
      colorHex: _color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          widget.initial == null ? l.labelNew : l.commonEdit,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _name,
          autofocus: true,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _save(),
          decoration: InputDecoration(labelText: l.labelName),
        ),
        const SizedBox(height: 12),
        if (_name.text.trim().isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: LabelPill(
              name: _name.text.trim(),
              colorHex: _color,
              dense: false,
            ),
          ),
        const SizedBox(height: 12),
        ColorPalettePicker(
          selected: _color,
          onChanged: (c) => setState(() => _color = c ?? _color),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.check_rounded),
          label: Text(l.commonSave),
        ),
      ],
    );
  }
}
