import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/presentation/theme_mode_controller.dart';

part 'app_lock_controller.freezed.dart';
part 'app_lock_controller.g.dart';

/// Cihaz kimlik doğrulaması (Face ID / Touch ID / şifre); testlerde sahtesi verilir.
abstract interface class Authenticator {
  Future<bool> isSupported();
  Future<bool> authenticate(String reason);
}

class LocalAuthenticator implements Authenticator {
  final _auth = LocalAuthentication();

  @override
  Future<bool> isSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    try {
      // Biyometrik yoksa cihaz şifresine düşer; arka plana atılırsa geri gelince tekrar dener.
      return await _auth.authenticate(
        localizedReason: reason,
        persistAcrossBackgrounding: true,
      );
    } catch (e) {
      debugPrint('Kimlik doğrulama hatası: $e');
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
Authenticator? authenticator(Ref ref) =>
    (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android))
    ? LocalAuthenticator()
    : null;

@Riverpod(keepAlive: true)
Future<bool> appLockSupported(Ref ref) async =>
    await ref.watch(authenticatorProvider)?.isSupported() ?? false;

@freezed
abstract class AppLockState with _$AppLockState {
  const factory AppLockState({
    @Default(false) bool enabled,
    @Default(false) bool locked,
  }) = _AppLockState;
}

/// Uygulama kilidi: açılışta ve uzun süre arka planda kaldıktan sonra kilitlenir.
@Riverpod(keepAlive: true)
class AppLockController extends _$AppLockController {
  static const _key = 'app_lock_enabled';
  static const relockAfter = Duration(seconds: 30);

  DateTime? _backgroundedAt;
  bool _authenticating = false;

  @override
  AppLockState build() {
    final enabled = ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;
    return AppLockState(enabled: enabled, locked: enabled);
  }

  /// Açmak için önce kimlik doğrulaması istenir. Başarısızsa false döner.
  Future<bool> setEnabled(bool enabled, {required String reason}) async {
    if (enabled) {
      final auth = ref.read(authenticatorProvider);
      if (auth == null ||
          !await auth.isSupported() ||
          !await auth.authenticate(reason)) {
        return false;
      }
    }
    await ref.read(sharedPreferencesProvider).setBool(_key, enabled);
    state = AppLockState(enabled: enabled);
    return true;
  }

  Future<void> unlock({required String reason}) async {
    if (!state.locked || _authenticating) return;
    final auth = ref.read(authenticatorProvider);
    if (auth == null) {
      state = state.copyWith(locked: false);
      return;
    }
    _authenticating = true;
    try {
      if (await auth.authenticate(reason)) {
        state = state.copyWith(locked: false);
      }
    } finally {
      _authenticating = false;
    }
  }

  void onBackgrounded(DateTime at) => _backgroundedAt = at;

  void onForegrounded(DateTime at) {
    final since = _backgroundedAt;
    _backgroundedAt = null;
    if (state.enabled && since != null && at.difference(since) >= relockAfter) {
      state = state.copyWith(locked: true);
    }
  }
}
