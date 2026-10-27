import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../domain/person.dart';

/// Kişi formunu açar; kaydedilirse girdiyi döner (kalıcılaştırma çağıranın işi).
Future<PersonInput?> showPersonForm(BuildContext context, {Person? initial}) =>
    showGlassSheet<PersonInput>(
      context,
      builder: (_) => PersonFormSheet(initial: initial),
    );

class PersonFormSheet extends StatefulWidget {
  const PersonFormSheet({super.key, this.initial});

  final Person? initial;

  @override
  State<PersonFormSheet> createState() => _PersonFormSheetState();
}

class _PersonFormSheetState extends State<PersonFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _email = TextEditingController(text: widget.initial?.email);
  late final _role = TextEditingController(text: widget.initial?.role);
  late String? _color =
      widget.initial?.colorHex ?? (kPalette.toList()..shuffle()).first;
  late bool _isMe = widget.initial?.isMe ?? false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _role.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      PersonInput(
        name: _name.text,
        email: _email.text,
        role: _role.text,
        colorHex: _color,
        isMe: _isMe,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            widget.initial == null ? l.personNew : l.personEdit,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            autofocus: widget.initial == null,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: l.personName,
              prefixIcon: const Icon(Icons.person_rounded),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l.personNameRequired : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _role,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l.personRole,
              prefixIcon: const Icon(Icons.badge_rounded),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l.personEmail,
              prefixIcon: const Icon(Icons.alternate_email_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Text(l.commonColor, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          ColorPalettePicker(
            selected: _color,
            onChanged: (c) => setState(() => _color = c),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _isMe,
            onChanged: (v) => setState(() => _isMe = v),
            title: Text(l.personIsMe),
            subtitle: Text(l.personIsMeHelp),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check_rounded),
            label: Text(l.commonSave),
          ),
        ],
      ),
    );
  }
}
