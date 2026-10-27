// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Şimdilik sadece iOS'ta widget var; diğer platformlarda null.

@ProviderFor(widgetBridge)
final widgetBridgeProvider = WidgetBridgeProvider._();

/// Şimdilik sadece iOS'ta widget var; diğer platformlarda null.

final class WidgetBridgeProvider
    extends $FunctionalProvider<WidgetBridge?, WidgetBridge?, WidgetBridge?>
    with $Provider<WidgetBridge?> {
  /// Şimdilik sadece iOS'ta widget var; diğer platformlarda null.
  WidgetBridgeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetBridgeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetBridgeHash();

  @$internal
  @override
  $ProviderElement<WidgetBridge?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WidgetBridge? create(Ref ref) {
    return widgetBridge(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetBridge? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetBridge?>(value),
    );
  }
}

String _$widgetBridgeHash() => r'9acc14724d253d23fce4ecc84f0598c8672e3de9';

/// Proje ve kart verisini izler; değişince (kısa gecikmeyle) widget'ı günceller.
/// Mutlaka `listen` ile canlı tutulmalı (Riverpod 3 dinleyicisiz provider'ı duraklatır).

@ProviderFor(HomeWidgetSync)
final homeWidgetSyncProvider = HomeWidgetSyncProvider._();

/// Proje ve kart verisini izler; değişince (kısa gecikmeyle) widget'ı günceller.
/// Mutlaka `listen` ile canlı tutulmalı (Riverpod 3 dinleyicisiz provider'ı duraklatır).
final class HomeWidgetSyncProvider
    extends $NotifierProvider<HomeWidgetSync, void> {
  /// Proje ve kart verisini izler; değişince (kısa gecikmeyle) widget'ı günceller.
  /// Mutlaka `listen` ile canlı tutulmalı (Riverpod 3 dinleyicisiz provider'ı duraklatır).
  HomeWidgetSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetSyncHash();

  @$internal
  @override
  HomeWidgetSync create() => HomeWidgetSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeWidgetSyncHash() => r'920e3b8901ca8b9cefe11605c6412cb8d4ca125c';

/// Proje ve kart verisini izler; değişince (kısa gecikmeyle) widget'ı günceller.
/// Mutlaka `listen` ile canlı tutulmalı (Riverpod 3 dinleyicisiz provider'ı duraklatır).

abstract class _$HomeWidgetSync extends $Notifier<void> {
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
