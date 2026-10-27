import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart' as ml;

import '../../../core/domain/place.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/glass_sheet.dart';
import '../data/maps_service.dart';

/// Konum satırı: ad/adres, "Haritada aç" ve "Yol tarifi"; dokununca düzenlenir.
class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.place, this.onEdit});

  final Place place;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    return GlassSurface(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onEdit,
            child: Row(
              children: [
                Icon(Icons.place_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    place.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (onEdit != null)
                  Icon(
                    Icons.edit_rounded,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => openPlaceInMaps(context, place),
                icon: const Icon(Icons.map_rounded, size: 18),
                label: Text(l.mapsOpen),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    openPlaceInMaps(context, place, directions: true),
                icon: const Icon(Icons.directions_rounded, size: 18),
                label: Text(l.mapsDirections),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Yüklü harita uygulamalarını listeler; tek seçenek varsa doğrudan açar.
Future<void> openPlaceInMaps(
  BuildContext context,
  Place place, {
  bool directions = false,
}) async {
  final l = context.l10n;
  try {
    final maps = await MapsService.supportedMaps(place, directions: directions);
    if (!context.mounted) return;
    if (maps.isEmpty) {
      showError(context, l.mapsNone);
      return;
    }
    if (maps.length == 1) {
      await maps.single.show();
      return;
    }
    // Yüklü olanlar önce.
    final sorted = [...maps]
      ..sort((a, b) => (b.isInstalled ? 1 : 0) - (a.isInstalled ? 1 : 0));
    final chosen = await showGlassSheet<ml.SupportedMap>(
      context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          Text(
            l.mapsChooseApp,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          for (final m in sorted)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(m.iconBytes, width: 32, height: 32),
              ),
              title: Text(MapsService.displayName(m.map)),
              trailing: m.isInstalled
                  ? null
                  : const Icon(Icons.open_in_browser_rounded, size: 18),
              onTap: () => Navigator.pop(context, m),
            ),
        ],
      ),
    );
    await chosen?.show();
  } on ml.MapLaunchException catch (e) {
    if (context.mounted) showError(context, e);
  }
}
