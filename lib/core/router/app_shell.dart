import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/l10n.dart';
import '../theme/glass.dart';

/// Alt menülü kabuk: yüzen cam navigasyon çubuğu.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: shell,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: GlassSurface(
          blur: true,
          sigma: 20,
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: (i) =>
                shell.goBranch(i, initialLocation: i == shell.currentIndex),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard_rounded),
                label: l.navProjects,
              ),
              NavigationDestination(
                icon: const Icon(Icons.groups_outlined),
                selectedIcon: const Icon(Icons.groups_rounded),
                label: l.navPeople,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings_rounded),
                label: l.navSettings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Alt menülü sayfalarda FAB'ı yüzen navigasyon çubuğunun üstüne taşır.
class ShellFab extends StatelessWidget {
  const ShellFab({super.key, required this.child});

  final Widget child;

  static const navClearance = 80.0;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: navClearance),
    child: child,
  );
}
