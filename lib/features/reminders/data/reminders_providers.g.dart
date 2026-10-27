// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Yalnızca mobilde bildirim var; web'de null.

@ProviderFor(notificationGateway)
final notificationGatewayProvider = NotificationGatewayProvider._();

/// Yalnızca mobilde bildirim var; web'de null.

final class NotificationGatewayProvider
    extends
        $FunctionalProvider<
          NotificationGateway?,
          NotificationGateway?,
          NotificationGateway?
        >
    with $Provider<NotificationGateway?> {
  /// Yalnızca mobilde bildirim var; web'de null.
  NotificationGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationGatewayHash();

  @$internal
  @override
  $ProviderElement<NotificationGateway?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationGateway? create(Ref ref) {
    return notificationGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationGateway? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationGateway?>(value),
    );
  }
}

String _$notificationGatewayHash() =>
    r'd3858254a7bb030eb1ce6c0e710c39e8b71ea086';

@ProviderFor(ReminderSettingsController)
final reminderSettingsControllerProvider =
    ReminderSettingsControllerProvider._();

final class ReminderSettingsControllerProvider
    extends $NotifierProvider<ReminderSettingsController, ReminderSettings> {
  ReminderSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSettingsControllerHash();

  @$internal
  @override
  ReminderSettingsController create() => ReminderSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderSettings>(value),
    );
  }
}

String _$reminderSettingsControllerHash() =>
    r'f70412183c90ae702527a64d03604a9c1c08041a';

abstract class _$ReminderSettingsController
    extends $Notifier<ReminderSettings> {
  ReminderSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReminderSettings, ReminderSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReminderSettings, ReminderSettings>,
              ReminderSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Görev, proje veya ayar değişince bildirimleri yeniden kurar.
/// Riverpod 3 dinleyicisiz provider'ı duraklattığı için `listen` ile canlı tutulmalı.

@ProviderFor(ReminderSync)
final reminderSyncProvider = ReminderSyncProvider._();

/// Görev, proje veya ayar değişince bildirimleri yeniden kurar.
/// Riverpod 3 dinleyicisiz provider'ı duraklattığı için `listen` ile canlı tutulmalı.
final class ReminderSyncProvider extends $NotifierProvider<ReminderSync, void> {
  /// Görev, proje veya ayar değişince bildirimleri yeniden kurar.
  /// Riverpod 3 dinleyicisiz provider'ı duraklattığı için `listen` ile canlı tutulmalı.
  ReminderSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSyncHash();

  @$internal
  @override
  ReminderSync create() => ReminderSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$reminderSyncHash() => r'33554423e292cd560697c1f5789fc393a1a22d2e';

/// Görev, proje veya ayar değişince bildirimleri yeniden kurar.
/// Riverpod 3 dinleyicisiz provider'ı duraklattığı için `listen` ile canlı tutulmalı.

abstract class _$ReminderSync extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
