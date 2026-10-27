// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Yalnızca mobilde telefon takvimi var.

@ProviderFor(deviceCalendarGateway)
final deviceCalendarGatewayProvider = DeviceCalendarGatewayProvider._();

/// Yalnızca mobilde telefon takvimi var.

final class DeviceCalendarGatewayProvider
    extends
        $FunctionalProvider<
          DeviceCalendarGateway?,
          DeviceCalendarGateway?,
          DeviceCalendarGateway?
        >
    with $Provider<DeviceCalendarGateway?> {
  /// Yalnızca mobilde telefon takvimi var.
  DeviceCalendarGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceCalendarGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceCalendarGatewayHash();

  @$internal
  @override
  $ProviderElement<DeviceCalendarGateway?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceCalendarGateway? create(Ref ref) {
    return deviceCalendarGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceCalendarGateway? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceCalendarGateway?>(value),
    );
  }
}

String _$deviceCalendarGatewayHash() =>
    r'0ce364385a1162f45b60b2297d47560142cafc5b';

@ProviderFor(calendarLinkStore)
final calendarLinkStoreProvider = CalendarLinkStoreProvider._();

final class CalendarLinkStoreProvider
    extends
        $FunctionalProvider<
          CalendarLinkStore,
          CalendarLinkStore,
          CalendarLinkStore
        >
    with $Provider<CalendarLinkStore> {
  CalendarLinkStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarLinkStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarLinkStoreHash();

  @$internal
  @override
  $ProviderElement<CalendarLinkStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarLinkStore create(Ref ref) {
    return calendarLinkStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarLinkStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarLinkStore>(value),
    );
  }
}

String _$calendarLinkStoreHash() => r'46ad9c9d2494231a152da45c4e359767eec9a929';

@ProviderFor(CalendarSyncSettingsController)
final calendarSyncSettingsControllerProvider =
    CalendarSyncSettingsControllerProvider._();

final class CalendarSyncSettingsControllerProvider
    extends
        $NotifierProvider<
          CalendarSyncSettingsController,
          CalendarSyncSettings
        > {
  CalendarSyncSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarSyncSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarSyncSettingsControllerHash();

  @$internal
  @override
  CalendarSyncSettingsController create() => CalendarSyncSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarSyncSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarSyncSettings>(value),
    );
  }
}

String _$calendarSyncSettingsControllerHash() =>
    r'990297cdb5cf7f326c3b30005361c705e9d6bb74';

abstract class _$CalendarSyncSettingsController
    extends $Notifier<CalendarSyncSettings> {
  CalendarSyncSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CalendarSyncSettings, CalendarSyncSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarSyncSettings, CalendarSyncSettings>,
              CalendarSyncSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Görev ve proje değişince telefon takvimini eşitler. `listen` ile canlı tutulmalı
/// (Riverpod 3 dinleyicisiz provider'ı duraklatır).

@ProviderFor(CalendarSync)
final calendarSyncProvider = CalendarSyncProvider._();

/// Görev ve proje değişince telefon takvimini eşitler. `listen` ile canlı tutulmalı
/// (Riverpod 3 dinleyicisiz provider'ı duraklatır).
final class CalendarSyncProvider extends $NotifierProvider<CalendarSync, void> {
  /// Görev ve proje değişince telefon takvimini eşitler. `listen` ile canlı tutulmalı
  /// (Riverpod 3 dinleyicisiz provider'ı duraklatır).
  CalendarSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarSyncHash();

  @$internal
  @override
  CalendarSync create() => CalendarSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$calendarSyncHash() => r'c4c54e03655d556d9239216be4991c51cbfe1e1c';

/// Görev ve proje değişince telefon takvimini eşitler. `listen` ile canlı tutulmalı
/// (Riverpod 3 dinleyicisiz provider'ı duraklatır).

abstract class _$CalendarSync extends $Notifier<void> {
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

/// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
/// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).

@ProviderFor(deviceEvents)
final deviceEventsProvider = DeviceEventsFamily._();

/// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
/// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).

final class DeviceEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeviceEvent>>,
          List<DeviceEvent>,
          FutureOr<List<DeviceEvent>>
        >
    with
        $FutureModifier<List<DeviceEvent>>,
        $FutureProvider<List<DeviceEvent>> {
  /// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
  /// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).
  DeviceEventsProvider._({
    required DeviceEventsFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'deviceEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deviceEventsHash();

  @override
  String toString() {
    return r'deviceEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DeviceEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DeviceEvent>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return deviceEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deviceEventsHash() => r'82f39b3e3e07186521ca75bc5df65b4d57ffcbbc';

/// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
/// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).

final class DeviceEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DeviceEvent>>, DateTime> {
  DeviceEventsFamily._()
    : super(
        retry: null,
        name: r'deviceEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
  /// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).

  DeviceEventsProvider call(DateTime month) =>
      DeviceEventsProvider._(argument: month, from: this);

  @override
  String toString() => r'deviceEventsProvider';
}
