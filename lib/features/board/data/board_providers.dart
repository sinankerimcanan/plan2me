import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/board_repository.dart';
import 'drift_board_repository.dart';

part 'board_providers.g.dart';

@Riverpod(keepAlive: true)
BoardRepository boardRepository(Ref ref) => DriftBoardRepository(
  ref.watch(appDatabaseProvider),
  clock: ref.watch(clockProvider),
);
