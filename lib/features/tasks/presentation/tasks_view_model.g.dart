// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskFilterController)
final taskFilterControllerProvider = TaskFilterControllerProvider._();

final class TaskFilterControllerProvider
    extends $NotifierProvider<TaskFilterController, TaskFilter> {
  TaskFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskFilterControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskFilterControllerHash();

  @$internal
  @override
  TaskFilterController create() => TaskFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskFilter>(value),
    );
  }
}

String _$taskFilterControllerHash() =>
    r'4bd4a9ffa55f63e68a7b4b69ed2331f946513dd3';

abstract class _$TaskFilterController extends $Notifier<TaskFilter> {
  TaskFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TaskFilter, TaskFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskFilter, TaskFilter>,
              TaskFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// "Görevlerim" ViewModel'i: tüm projelerdeki görevleri gruplar, niyetleri yönetir.

@ProviderFor(TasksViewModel)
final tasksViewModelProvider = TasksViewModelProvider._();

/// "Görevlerim" ViewModel'i: tüm projelerdeki görevleri gruplar, niyetleri yönetir.
final class TasksViewModelProvider
    extends $NotifierProvider<TasksViewModel, AsyncValue<TasksState>> {
  /// "Görevlerim" ViewModel'i: tüm projelerdeki görevleri gruplar, niyetleri yönetir.
  TasksViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksViewModelHash();

  @$internal
  @override
  TasksViewModel create() => TasksViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<TasksState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<TasksState>>(value),
    );
  }
}

String _$tasksViewModelHash() => r'fbdc393b35943385c7766ed1c3a96dbd0a66073a';

/// "Görevlerim" ViewModel'i: tüm projelerdeki görevleri gruplar, niyetleri yönetir.

abstract class _$TasksViewModel extends $Notifier<AsyncValue<TasksState>> {
  AsyncValue<TasksState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TasksState>, AsyncValue<TasksState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TasksState>, AsyncValue<TasksState>>,
              AsyncValue<TasksState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
