import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../domain/board_models.dart';

Future<ColumnPatch?> showColumnSettings(
  BuildContext context,
  BoardColumn column,
) => showGlassSheet<ColumnPatch>(
  context,
  builder: (_) => ColumnSettingsSheet(column: column),
);

class ColumnSettingsSheet extends StatefulWidget {
  const ColumnSettingsSheet({super.key, required this.column});

  final BoardColumn column;

  @override
  State<ColumnSettingsSheet> createState() => _ColumnSettingsSheetState();
}

class _ColumnSettingsSheetState extends State<ColumnSettingsSheet> {
  late final _name = TextEditingController(text: widget.column.name);
  late final _wip = TextEditingController(
    text: widget.column.wipLimit?.toString() ?? '',
  );
  late String? _color = widget.column.colorHex;
  late bool _isDone = widget.column.isDoneColumn;

  @override
  void dispose() {
    _name.dispose();
    _wip.dispose();
    super.dispose();
  }

  void _save() {
    if (_name.text.trim().isEmpty) return;
    final wip = int.tryParse(_wip.text.trim());
    Navigator.pop(
      context,
      ColumnPatch(
        name: _name.text,
        colorHex: _color,
        wipLimit: (wip == null || wip <= 0) ? null : wip,
        isDoneColumn: _isDone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          l.columnSettings,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _name,
          decoration: InputDecoration(labelText: l.boardColumnName),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _wip,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l.columnWipLimit,
            helperText: l.columnWipHint,
          ),
        ),
        const SizedBox(height: 16),
        Text(l.commonColor, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ColorPalettePicker(
          selected: _color,
          allowNone: true,
          onChanged: (c) => setState(() => _color = c),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _isDone,
          onChanged: (v) => setState(() => _isDone = v),
          title: Text(l.columnIsDone),
          subtitle: Text(l.columnIsDoneHelp),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.check_rounded),
          label: Text(l.commonSave),
        ),
      ],
    );
  }
}

/// Basit metin girişi diyaloğu (yeni sütun adı vb.).
Future<String?> promptText(
  BuildContext context, {
  required String title,
  required String label,
}) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: label),
        onSubmitted: (v) => Navigator.pop(context, v),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text(context.l10n.commonAdd),
        ),
      ],
    ),
  ).whenComplete(controller.dispose);
}

/// Silme onayı + sütun içeriği uyarısı.
Future<bool> confirmColumnDelete(BuildContext context, BoardLane lane) =>
    confirmDelete(
      context,
      context.l10n.columnDeleteBody(lane.column.name, lane.cards.length),
    );
