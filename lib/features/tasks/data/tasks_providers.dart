import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../board/data/board_providers.dart';
import '../../projects/data/projects_providers.dart';
import '../domain/task_item.dart';
import '../domain/task_repository.dart';
import 'drift_task_repository.dart';

part 'tasks_providers.g.dart';

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) => DriftTaskRepository(
  ref.watch(appDatabaseProvider),
  board: ref.watch(boardRepositoryProvider),
  projects: ref.watch(projectRepositoryProvider),
  clock: ref.watch(clockProvider),
);

/// Tüm açık görevler (görevler, takvim, hatırlatıcılar ve widget bunu kullanır).
@riverpod
Stream<List<TaskItem>> allTasks(Ref ref) =>
    ref.watch(taskRepositoryProvider).watchTasks();
