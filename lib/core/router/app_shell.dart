import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/calendar_view_model.dart';
import '../../features/people/presentation/people_screen.dart';
import '../../features/tasks/presentation/quick_add_sheet.dart';
import '../l10n/l10n.dart';
import '../widgets/liquid_nav_bar.dart';
import 'routes.dart';

/// Alt menülü kabuk: sıvı cam menü ve sekmeye göre değişen "+" düğmesi.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  LiquidNavAction? _actionFor(int index, BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return switch (index) {
      0 => LiquidNavAction(
        icon: Icons.add_rounded,
        tooltip: l.projectsNew,
        onPressed: () => context.push(Routes.newProject),
      ),
      1 => LiquidNavAction(
        icon: Icons.add_task_rounded,
        tooltip: l.taskAdd,
        onPressed: () => showQuickAddSheet(context),
      ),
      2 => LiquidNavAction(
        icon: Icons.add_task_rounded,
        tooltip: l.taskAdd,
        onPressed: () => showQuickAddSheet(
          context,
          date: ref.read(calendarControllerProvider).selectedDay,
        ),
      ),
      3 => LiquidNavAction(
        icon: Icons.person_add_alt_1_rounded,
        tooltip: l.personNew,
        onPressed: () => createPerson(context, ref),
      ),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: shell,
      bottomNavigationBar: LiquidNavBar(
        selectedIndex: shell.currentIndex,
        onSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        action: _actionFor(shell.currentIndex, context, ref),
        items: [
          LiquidNavItem(
            icon: Icons.dashboard_outlined,
            selectedIcon: Icons.dashboard_rounded,
            label: l.navProjects,
          ),
          LiquidNavItem(
            icon: Icons.task_alt_outlined,
            selectedIcon: Icons.task_alt_rounded,
            label: l.navTasks,
          ),
          LiquidNavItem(
            icon: Icons.calendar_month_outlined,
            selectedIcon: Icons.calendar_month_rounded,
            label: l.navCalendar,
          ),
          LiquidNavItem(
            icon: Icons.groups_outlined,
            selectedIcon: Icons.groups_rounded,
            label: l.navPeople,
          ),
          LiquidNavItem(
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings_rounded,
            label: l.navSettings,
          ),
        ],
      ),
    );
  }
}
