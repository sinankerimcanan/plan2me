import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/place.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../data/location_service.dart';

/// Konum seçimi sonucu: yeni konum ya da "kaldır".
sealed class LocationPick {
  const LocationPick();
}

class LocationPicked extends LocationPick {
  const LocationPicked(this.place);
  final Place place;
}

class LocationCleared extends LocationPick {
  const LocationCleared();
}

Future<LocationPick?> showLocationPicker(
  BuildContext context, {
  Place? initial,
}) => showGlassSheet<LocationPick>(
  context,
  builder: (_) => LocationPickerSheet(initial: initial),
);

class LocationPickerSheet extends ConsumerStatefulWidget {
  const LocationPickerSheet({super.key, this.initial});

  final Place? initial;

  @override
  ConsumerState<LocationPickerSheet> createState() =>
      _LocationPickerSheetState();
}

class _LocationPickerSheetState extends ConsumerState<LocationPickerSheet> {
  late final _query = TextEditingController(text: widget.initial?.name);
  List<Place>? _results;
  bool _busy = false;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  String _failureText(AppLocalizations l, LocationFailure f) => switch (f) {
    LocationFailure.serviceDisabled => l.locationServiceDisabled,
    LocationFailure.denied => l.locationDenied,
    LocationFailure.deniedForever => l.locationDeniedForever,
    LocationFailure.unavailable => l.locationFailed,
  };

  Future<void> _search() async {
    final q = _query.text.trim();
    if (q.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    final results = await ref.read(locationServiceProvider).search(q);
    if (mounted) {
      setState(() {
        _busy = false;
        _results = results;
      });
    }
  }

  Future<void> _useCurrent() async {
    final l = context.l10n;
    setState(() => _busy = true);
    try {
      final place = await ref.read(locationServiceProvider).currentPlace();
      if (mounted) Navigator.pop(context, LocationPicked(place));
    } on LocationException catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showError(context, _failureText(l, e.reason));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final typed = _query.text.trim();
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          widget.initial == null ? l.locationAdd : l.locationEdit,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _query,
          autofocus: widget.initial == null,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l.locationSearchHint,
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: IconButton(
              icon: const Icon(Icons.arrow_forward_rounded),
              tooltip: l.locationSearch,
              onPressed: _search,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: Icon(
            Icons.my_location_rounded,
            color: theme.colorScheme.primary,
          ),
          title: Text(l.locationUseCurrent),
          onTap: _busy ? null : _useCurrent,
        ),
        if (_busy)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (!_busy && _results != null) ...[
          const Divider(),
          if (_results!.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                l.locationNoResults,
                style: theme.textTheme.bodySmall,
              ),
            ),
          for (final place in _results!)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              leading: const Icon(Icons.place_rounded),
              title: Text(place.name),
              subtitle: place.hasCoordinates
                  ? Text(formatCoordinates(place.latitude!, place.longitude!))
                  : null,
              onTap: () => Navigator.pop(context, LocationPicked(place)),
            ),
        ],
        if (!_busy &&
            typed.isNotEmpty &&
            (_results?.every((p) => p.name != typed) ?? true))
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            leading: const Icon(Icons.edit_location_alt_rounded),
            title: Text(l.locationUseAsTyped(typed)),
            onTap: () =>
                Navigator.pop(context, LocationPicked(Place(name: typed))),
          ),
        if (widget.initial != null)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            leading: Icon(
              Icons.location_off_rounded,
              color: theme.colorScheme.error,
            ),
            title: Text(
              l.locationRemove,
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () => Navigator.pop(context, const LocationCleared()),
          ),
      ],
    );
  }
}
