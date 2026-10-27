// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authenticator)
final authenticatorProvider = AuthenticatorProvider._();

final class AuthenticatorProvider
    extends $FunctionalProvider<Authenticator?, Authenticator?, Authenticator?>
    with $Provider<Authenticator?> {
  AuthenticatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticatorHash();

  @$internal
  @override
  $ProviderElement<Authenticator?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Authenticator? create(Ref ref) {
    return authenticator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Authenticator? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Authenticator?>(value),
    );
  }
}

String _$authenticatorHash() => r'834b71f2c38bf6458621a8941105b42785951837';

@ProviderFor(appLockSupported)
final appLockSupportedProvider = AppLockSupportedProvider._();

final class AppLockSupportedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  AppLockSupportedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockSupportedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockSupportedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return appLockSupported(ref);
  }
}

String _$appLockSupportedHash() => r'10efae475bd0d188cc72e8cdd4fe0b2053ab07a6';

/// Uygulama kilidi: açılışta ve uzun süre arka planda kaldıktan sonra kilitlenir.

@ProviderFor(AppLockController)
final appLockControllerProvider = AppLockControllerProvider._();

/// Uygulama kilidi: açılışta ve uzun süre arka planda kaldıktan sonra kilitlenir.
final class AppLockControllerProvider
    extends $NotifierProvider<AppLockController, AppLockState> {
  /// Uygulama kilidi: açılışta ve uzun süre arka planda kaldıktan sonra kilitlenir.
  AppLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockControllerHash();

  @$internal
  @override
  AppLockController create() => AppLockController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLockState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLockState>(value),
    );
  }
}

String _$appLockControllerHash() => r'25abbc19b9f7bbc4fa576f8d3d1411de64227eaa';

/// Uygulama kilidi: açılışta ve uzun süre arka planda kaldıktan sonra kilitlenir.

abstract class _$AppLockController extends $Notifier<AppLockState> {
  AppLockState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLockState, AppLockState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLockState, AppLockState>,
              AppLockState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
