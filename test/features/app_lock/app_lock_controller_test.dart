import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/features/app_lock/data/app_lock_controller.dart';
import 'package:plan2me/features/settings/presentation/theme_mode_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuth implements Authenticator {
  bool supported = true;
  bool succeed = true;
  int calls = 0;

  @override
  Future<bool> isSupported() async => supported;
  @override
  Future<bool> authenticate(String reason) async {
    calls++;
    return succeed;
  }
}

void main() {
  late FakeAuth auth;

  Future<ProviderContainer> make({Map<String, Object> prefs = const {}}) async {
    SharedPreferences.setMockInitialValues(prefs);
    final p = await SharedPreferences.getInstance();
    auth = FakeAuth();
    final c = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(p),
        authenticatorProvider.overrideWithValue(auth),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  test('açmak için doğrulama gerekir; başarısızsa kapalı kalır', () async {
    final c = await make();
    final ctrl = c.read(appLockControllerProvider.notifier);
    auth.succeed = false;
    expect(await ctrl.setEnabled(true, reason: 'x'), isFalse);
    expect(c.read(appLockControllerProvider).enabled, isFalse);
    auth.succeed = true;
    expect(await ctrl.setEnabled(true, reason: 'x'), isTrue);
    expect(
      c.read(appLockControllerProvider),
      const AppLockState(enabled: true),
    );
  });

  test('açıkken uygulama kilitli başlar ve doğrulamayla açılır', () async {
    final c = await make(prefs: {'app_lock_enabled': true});
    expect(c.read(appLockControllerProvider).locked, isTrue);
    auth.succeed = false;
    await c.read(appLockControllerProvider.notifier).unlock(reason: 'x');
    expect(c.read(appLockControllerProvider).locked, isTrue);
    auth.succeed = true;
    await c.read(appLockControllerProvider.notifier).unlock(reason: 'x');
    expect(c.read(appLockControllerProvider).locked, isFalse);
  });

  test('30 saniyeden uzun arka planda kalınca yeniden kilitlenir, kısa sürede kilitlenmez', () async {
    final c = await make(prefs: {'app_lock_enabled': true});
    final ctrl = c.read(appLockControllerProvider.notifier);
    await ctrl.unlock(reason: 'x');
    final t = DateTime(2026, 10, 27, 12);
    ctrl
      ..onBackgrounded(t)
      ..onForegrounded(t.add(const Duration(seconds: 10)));
    expect(c.read(appLockControllerProvider).locked, isFalse);
    ctrl
      ..onBackgrounded(t)
      ..onForegrounded(t.add(AppLockController.relockAfter));
    expect(c.read(appLockControllerProvider).locked, isTrue);
  });

  test('kapalıyken hiç kilitlenmez', () async {
    final c = await make();
    final ctrl = c.read(appLockControllerProvider.notifier);
    final t = DateTime(2026);
    ctrl
      ..onBackgrounded(t)
      ..onForegrounded(t.add(const Duration(hours: 1)));
    expect(c.read(appLockControllerProvider).locked, isFalse);
  });
}
