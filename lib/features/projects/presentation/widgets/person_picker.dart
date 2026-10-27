import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/person_avatar.dart';
import '../../../people/domain/person.dart';

/// Tek kişi seçimi (sorumlu). "Yok" seçeneği dahil.
class ResponsiblePicker extends StatelessWidget {
  const ResponsiblePicker({
    super.key,
    required this.people,
    required this.selectedId,
    required this.onChanged,
  });

  final List<Person> people;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          showCheckmark: false,
          label: Text(l.commonNone),
          selected: selectedId == null,
          onSelected: (_) => onChanged(null),
        ),
        for (final p in people)
          ChoiceChip(
            showCheckmark: false,
            avatar: PersonAvatar(p, size: 22),
            label: Text(p.isMe ? '${p.name} (${l.personMe})' : p.name),
            selected: selectedId == p.id,
            onSelected: (_) => onChanged(p.id),
          ),
      ],
    );
  }
}

/// Çoklu kişi seçimi (talep edenler) + yerinde yeni kişi.
class RequestersPicker extends StatelessWidget {
  const RequestersPicker({
    super.key,
    required this.people,
    required this.selectedIds,
    required this.onToggle,
    required this.onAddNew,
  });

  final List<Person> people;
  final List<String> selectedIds;
  final ValueChanged<String> onToggle;
  final VoidCallback onAddNew;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in people)
          FilterChip(
            showCheckmark: false,
            avatar: PersonAvatar(p, size: 22),
            label: Text(p.name),
            selected: selectedIds.contains(p.id),
            onSelected: (_) => onToggle(p.id),
          ),
        ActionChip(
          avatar: const Icon(Icons.person_add_alt_1_rounded, size: 18),
          label: Text(l.addPersonInline),
          onPressed: onAddNew,
        ),
      ],
    );
  }
}
