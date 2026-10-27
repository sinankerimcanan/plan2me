import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/board/domain/board_repository.dart';
import 'package:plan2me/features/board/presentation/board_view_model.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

KanbanCard _card(String id, String col, double pos) => KanbanCard(
  id: id,
  projectId: 'p',
  columnId: col,
  title: id,
  position: pos,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);

BoardData _board() => BoardData(
  projectId: 'p',
  lanes: [
    BoardLane(
      column: const BoardColumn(
        id: 'todo',
        projectId: 'p',
        name: 'Yapılacak',
        position: 1,
      ),
      cards: [
        BoardCard(card: _card('a', 'todo', 1)),
        BoardCard(card: _card('b', 'todo', 2)),
      ],
    ),
    const BoardLane(
      column: BoardColumn(
        id: 'done',
        projectId: 'p',
        name: 'Bitti',
        position: 2,
        isDoneColumn: true,
      ),
    ),
  ],
);

void main() {
  late MockBoardRepository repo;
  late StreamController<BoardData> stream;
  late ProviderContainer container;

  setUp(() {
    repo = MockBoardRepository();
    stream = StreamController<BoardData>.broadcast();
    when(() => repo.watchBoard('p')).thenAnswer((_) => stream.stream);
    container = ProviderContainer(
      overrides: [boardRepositoryProvider.overrideWithValue(repo)],
      retry: (_, _) => null,
    );
  });
  tearDown(() {
    container.dispose();
    stream.close();
  });

  Future<BoardViewModel> ready() async {
    final provider = boardViewModelProvider('p');
    container.listen(provider, (_, _) {});
    stream.add(_board());
    await container.read(provider.future);
    return container.read(provider.notifier);
  }

  List<String> ids(String col) => [
    for (final c
        in container
            .read(boardViewModelProvider('p'))
            .value!
            .lanes
            .firstWhere((l) => l.column.id == col)
            .cards)
      c.card.id,
  ];

  test('moveCard UI\'ı repository yanıtından önce iyimser günceller', () async {
    final vm = await ready();
    final pending = Completer<void>();
    when(() => repo.moveCard('a', 'done', beforeCardId: null))
        .thenAnswer((_) => pending.future);

    final future = vm.moveCard('a', 'done');
    expect(ids('todo'), ['b']);
    expect(ids('done'), ['a']);
    expect(
      container
          .read(boardViewModelProvider('p'))
          .value!
          .findCard('a')!
          .card
          .isCompleted,
      isTrue,
    );
    pending.complete();
    await future;
    verify(() => repo.moveCard('a', 'done', beforeCardId: null)).called(1);
  });

  test('repository hata verirse önceki sıraya geri döner', () async {
    final vm = await ready();
    when(() => repo.moveCard('b', 'todo', beforeCardId: 'a'))
        .thenThrow(StateError('db'));

    await expectLater(
      vm.moveCard('b', 'todo', beforeCardId: 'a'),
      throwsStateError,
    );
    expect(ids('todo'), ['a', 'b']);
  });

  test('kart kendi önüne bırakılırsa hiçbir şey yapılmaz', () async {
    final vm = await ready();
    await vm.moveCard('a', 'todo', beforeCardId: 'a');
    verifyNever(
      () =>
          repo.moveCard(any(), any(), beforeCardId: any(named: 'beforeCardId')),
    );
  });

  test('shiftColumn doğru "önüne" hedefini hesaplar', () async {
    final vm = await ready();
    when(
      () =>
          repo.moveColumn(any(), beforeColumnId: any(named: 'beforeColumnId')),
    ).thenAnswer((_) async {});
    await vm.shiftColumn('todo', 1);
    verify(() => repo.moveColumn('todo', beforeColumnId: null)).called(1);
    await vm.shiftColumn('done', -1);
    verify(() => repo.moveColumn('done', beforeColumnId: 'todo')).called(1);
  });
}
