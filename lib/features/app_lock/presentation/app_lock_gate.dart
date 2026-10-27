import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/glass.dart';
import '../data/app_lock_controller.dart';

/// Uygulamanın üstüne kilit ekranı koyar ve yaşam döngüsünü izler.
/// MaterialApp.builder içinde kullanılır.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    final ctrl = ref.read(appLockControllerProvider.notifier);
    // Face ID penceresi uygulamayı yalnızca "inactive" yapar; arka plan sayılmaz.
    _lifecycle = AppLifecycleListener(
      onPause: () => ctrl.onBackgrounded(DateTime.now()),
      onResume: () => ctrl.onForegrounded(DateTime.now()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockControllerProvider.select((s) => s.locked));
    return Stack(
      children: [
        // Kilitliyken içerik erişilebilirlik ağacında da gizlenir.
        ExcludeSemantics(excluding: locked, child: widget.child),
        if (locked) const Positioned.fill(child: _LockScreen()),
      ],
    );
  }
}

class _LockScreen extends ConsumerStatefulWidget {
  const _LockScreen();

  @override
  ConsumerState<_LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<_LockScreen> {
  @override
  void initState() {
    super.initState();
    // Kilit ekranı açılınca doğrulamayı kendiliğinden başlat.
    WidgetsBinding.instance.addPostFrameCallback((_) => _unlock());
  }

  Future<void> _unlock() => ref
      .read(appLockControllerProvider.notifier)
      .unlock(reason: context.l10n.appLockReason);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: LiquidBackground(
        child: Center(
          child: GlassSurface(
            blur: true,
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 36,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l.appLockLocked,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _unlock,
                  icon: const Icon(Icons.face_rounded),
                  label: Text(l.appLockUnlock),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
