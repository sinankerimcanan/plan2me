import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/toast.dart';

import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../backup/presentation/backup_actions.dart';
import '../../reminders/data/reminders_providers.dart';
import '../../trash/data/trash_providers.dart';
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
            SectionHeader(
              l.remindersTitle,
              icon: Icons.notifications_active_rounded,
            ),
            const _RemindersCard(),
            SectionHeader(l.settingsData, icon: Icons.storage_rounded),
            const _DataCard(),
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

class _RemindersCard extends ConsumerWidget {
  const _RemindersCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final s = ref.watch(reminderSettingsControllerProvider);
    final ctrl = ref.read(reminderSettingsControllerProvider.notifier);
    final time = TimeOfDay(hour: s.hour, minute: s.minute);

    return GlassSurface(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          SwitchListTile(
            title: Text(l.remindersEnable),
            subtitle: Text(l.remindersEnableHelp),
            value: s.enabled,
            onChanged: (v) async {
              final ok = await ctrl.setEnabled(v);
              if (!ok) showToast(l.remindersDenied);
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            child: !s.enabled
                ? const SizedBox(width: double.infinity)
                : Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.schedule_rounded),
                        title: Text(l.remindersTime),
                        trailing: Text(
                          time.format(context),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );
                          if (picked != null) {
                            await ctrl.setTime(picked.hour, picked.minute);
                          }
                        },
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.wb_twilight_rounded),
                        title: Text(l.remindersDayBefore),
                        value: s.dayBefore,
                        onChanged: ctrl.setDayBefore,
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.summarize_rounded),
                        title: Text(l.remindersDigest),
                        subtitle: Text(l.remindersDigestHelp),
                        value: s.dailyDigest,
                        onChanged: ctrl.setDailyDigest,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _DataCard extends ConsumerWidget {
  const _DataCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final trashCount = ref.watch(trashItemsProvider).value?.length ?? 0;
    return GlassSurface(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.phone_iphone_rounded),
            title: Text(
              l.settingsDataLocal,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.ios_share_rounded),
            title: Text(l.backupExport),
            subtitle: Text(l.backupExportHelp),
            onTap: () => exportBackup(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.settings_backup_restore_rounded),
            title: Text(l.backupImport),
            subtitle: Text(l.backupImportHelp),
            onTap: () => importBackup(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline_rounded),
            title: Text(l.trashTitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trashCount > 0) Badge(label: Text('$trashCount')),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
            onTap: () => context.push(Routes.trash),
          ),
        ],
      ),
    );
  }
}
