import 'package:flutter/foundation.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../l10n/app_localizations.dart';
import '../router/routes.dart';

/// Uygulama simgesine uzun basınca çıkan kısayollar.
abstract final class AppShortcuts {
  static const _quickActions = QuickActions();

  static bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  /// Kısayol tipini uygulama rotasına çevirir.
  static String? routeFor(String type) => switch (type) {
    'new_task' => '${Routes.tasks}?add=1',
    'tasks' => Routes.tasks,
    'calendar' => Routes.calendar,
    'new_project' => Routes.newProject,
    _ => null,
  };

  static Future<void> setup(
    AppLocalizations l, {
    required void Function(String route) onOpen,
  }) async {
    if (!supported) return;
    await _quickActions.initialize((type) {
      final route = routeFor(type);
      if (route != null) onOpen(route);
    });
    await _quickActions.setShortcutItems([
      ShortcutItem(
        type: 'new_task',
        localizedTitle: l.shortcutNewTask,
        icon: 'shortcut_new_task',
      ),
      ShortcutItem(
        type: 'tasks',
        localizedTitle: l.shortcutTasks,
        icon: 'shortcut_tasks',
      ),
      ShortcutItem(
        type: 'calendar',
        localizedTitle: l.shortcutCalendar,
        icon: 'shortcut_calendar',
      ),
      ShortcutItem(
        type: 'new_project',
        localizedTitle: l.shortcutNewProject,
        icon: 'shortcut_new_project',
      ),
    ]);
  }
}
