import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/trash_item.dart';
import 'drift_trash_repository.dart';

part 'trash_providers.g.dart';

@Riverpod(keepAlive: true)
TrashRepository trashRepository(Ref ref) => DriftTrashRepository(
  ref.watch(appDatabaseProvider),
  clock: ref.watch(clockProvider),
);

@riverpod
Stream<List<TrashItem>> trashItems(Ref ref) =>
    ref.watch(trashRepositoryProvider).watchTrash();
