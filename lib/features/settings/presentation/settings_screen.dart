import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import 'theme_mode_controller.dart';

const kAppVersion = '1.0.0';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeControllerProvider);

    return LiquidScaffold(
      title: Text(l.settingsTitle),
      body: Builder(
        builder: (context) => ListView(
          padding: liquidBodyPadding(context, bottom: 96),
          children: [
            SectionHeader(l.settingsTheme, icon: Icons.palette_rounded),
            GlassSurface(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: const Icon(Icons.brightness_auto_rounded),
                      label: Text(l.themeSystem),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: const Icon(Icons.light_mode_rounded),
                      label: Text(l.themeLight),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: const Icon(Icons.dark_mode_rounded),
                      label: Text(l.themeDark),
                    ),
                  ],
                  selected: {mode},
                  onSelectionChanged: (s) => ref
                      .read(themeModeControllerProvider.notifier)
                      .set(s.first),
                ),
              ),
            ),
            SectionHeader(l.settingsData, icon: Icons.storage_rounded),
            GlassSurface(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.phone_iphone_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l.settingsDataLocal)),
                ],
              ),
            ),
            SectionHeader(l.settingsAbout, icon: Icons.info_outline_rounded),
            GlassSurface(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.view_kanban_rounded,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.appTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        l.settingsVersion(kAppVersion),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
