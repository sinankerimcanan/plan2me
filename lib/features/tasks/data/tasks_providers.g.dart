// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskRepository)
final taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'fca71e0f0f65c8da8624dd32c19e9a696fe65bd2';

/// Tüm açık görevler (görevler, takvim, hatırlatıcılar ve widget bunu kullanır).

@ProviderFor(allTasks)
final allTasksProvider = AllTasksProvider._();

/// Tüm açık görevler (görevler, takvim, hatırlatıcılar ve widget bunu kullanır).

final class AllTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskItem>>,
          List<TaskItem>,
          Stream<List<TaskItem>>
        >
    with $FutureModifier<List<TaskItem>>, $StreamProvider<List<TaskItem>> {
  /// Tüm açık görevler (görevler, takvim, hatırlatıcılar ve widget bunu kullanır).
  AllTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTasksHash();

  @$internal
  @override
  $StreamProviderElement<List<TaskItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TaskItem>> create(Ref ref) {
    return allTasks(ref);
  }
}

String _$allTasksHash() => r'1a1214a1a219c3edaa1ecbc9877ddc2c67aaa1ae';
