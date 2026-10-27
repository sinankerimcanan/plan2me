// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Seçili gün, odaklı ay ve görünüm (ay / 2 hafta / hafta).

@ProviderFor(CalendarController)
final calendarControllerProvider = CalendarControllerProvider._();

/// Seçili gün, odaklı ay ve görünüm (ay / 2 hafta / hafta).
final class CalendarControllerProvider
    extends $NotifierProvider<CalendarController, CalendarUiState> {
  /// Seçili gün, odaklı ay ve görünüm (ay / 2 hafta / hafta).
  CalendarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarControllerHash();

  @$internal
  @override
  CalendarController create() => CalendarController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarUiState>(value),
    );
  }
}

String _$calendarControllerHash() =>
    r'015b33612b360cc40ae8c3cecb5e7b67f33a848f';

/// Seçili gün, odaklı ay ve görünüm (ay / 2 hafta / hafta).

abstract class _$CalendarController extends $Notifier<CalendarUiState> {
  CalendarUiState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CalendarUiState, CalendarUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarUiState, CalendarUiState>,
              CalendarUiState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Takvim ViewModel'i: tarihe göre gruplanmış ajanda.

@ProviderFor(CalendarViewModel)
final calendarViewModelProvider = CalendarViewModelProvider._();

/// Takvim ViewModel'i: tarihe göre gruplanmış ajanda.
final class CalendarViewModelProvider
    extends
        $NotifierProvider<
          CalendarViewModel,
          AsyncValue<Map<DateTime, DayAgenda>>
        > {
  /// Takvim ViewModel'i: tarihe göre gruplanmış ajanda.
  CalendarViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarViewModelHash();

  @$internal
  @override
  CalendarViewModel create() => CalendarViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Map<DateTime, DayAgenda>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<Map<DateTime, DayAgenda>>>(value),
    );
  }
}

String _$calendarViewModelHash() => r'ff48e91166862d11a681e5129a74f1003f95c1bd';

/// Takvim ViewModel'i: tarihe göre gruplanmış ajanda.

abstract class _$CalendarViewModel
    extends $Notifier<AsyncValue<Map<DateTime, DayAgenda>>> {
  AsyncValue<Map<DateTime, DayAgenda>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<DateTime, DayAgenda>>,
              AsyncValue<Map<DateTime, DayAgenda>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<DateTime, DayAgenda>>,
                AsyncValue<Map<DateTime, DayAgenda>>
              >,
              AsyncValue<Map<DateTime, DayAgenda>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
