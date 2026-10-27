import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late DriftBoardRepository board;
  late String projectId;
  late List<String> cols;

  setUp(() async {
    db = memoryDb();
    final clock = fakeClock();
    board = DriftBoardRepository(db, clock: clock);
    projectId = await DriftProjectRepository(db, clock: clock).create(
      const ProjectDraft(title: 'P'),
      defaultColumns: ['A', 'B', 'Bitti'],
    );
    cols = [
      for (final l in (await board.watchBoard(projectId).first).lanes)
        l.column.id,
    ];
  });
  tearDown(() => db.close());

  Future<List<String>> titles(int col) async => [
    for (final c in (await board.watchBoard(projectId).first).lanes[col].cards)
      c.card.title,
  ];

  test('kart sütun içinde ve sütunlar arasında taşınır', () async {
    final k1 = await board.addCard(cols[0], 'k1');
    final k2 = await board.addCard(cols[0], 'k2');
    final k3 = await board.addCard(cols[0], 'k3');
    await board.moveCard(k3, cols[0], beforeCardId: k1);
    expect(await titles(0), ['k3', 'k1', 'k2']);

    await board.moveCard(k1, cols[1]);
    expect(await titles(0), ['k3', 'k2']);
    expect(await titles(1), ['k1']);
    await board.moveCard(k2, cols[1], beforeCardId: k1);
    expect(await titles(1), ['k2', 'k1']);
  });

  test(
    'tamamlanma sütununa giren kart completedAt alır, çıkınca kaybeder',
    () async {
      final k = await board.addCard(cols[0], 'k');
      await board.moveCard(k, cols[2]);
      expect((await board.watchCard(k).first)!.card.isCompleted, isTrue);
      await board.moveCard(k, cols[1]);
      expect((await board.watchCard(k).first)!.card.isCompleted, isFalse);
    },
  );

  test(
    'sütun tamamlanma işareti değişince içindeki kartlar güncellenir',
    () async {
      final k = await board.addCard(cols[1], 'k');
      await board.updateColumn(
        cols[1],
        const ColumnPatch(name: 'B', isDoneColumn: true),
      );
      expect((await board.watchCard(k).first)!.card.isCompleted, isTrue);
    },
  );

  test('çok sayıda araya ekleme sırayı bozmaz (normalize)', () async {
    final first = await board.addCard(cols[0], 'first');
    final last = await board.addCard(cols[0], 'last');
    var before = last;
    for (var i = 0; i < 60; i++) {
      final k = await board.addCard(cols[0], 'm$i');
      await board.moveCard(k, cols[0], beforeCardId: before);
      before = k;
    }
    final t = await titles(0);
    expect(t.first, 'first');
    expect(t.last, 'last');
    expect(t.length, 62);
    expect(first, isNotEmpty);
  });

  test('etiket aç/kapa/aç ve checklist akışı', () async {
    final k = await board.addCard(cols[0], 'k');
    final label = await board.createLabel(projectId, 'Acil', '#E53935');
    await board.setCardLabel(k, label.id, enabled: true);
    await board.setCardLabel(k, label.id, enabled: false);
    await board.setCardLabel(k, label.id, enabled: true);
    var detail = (await board.watchCard(k).first)!;
    expect(detail.labelIds, {label.id});

    await board.addChecklistItem(k, 'bir');
    await board.addChecklistItem(k, 'iki');
    detail = (await board.watchCard(k).first)!;
    await board.setChecklistItemDone(detail.checklist.first.id, done: true);
    await board.moveChecklistItem(
      detail.checklist.last.id,
      beforeItemId: detail.checklist.first.id,
    );
    detail = (await board.watchCard(k).first)!;
    expect(detail.checklist.map((i) => i.title), ['iki', 'bir']);
    expect(detail.checklistDone, 1);

    final lane = (await board.watchBoard(projectId).first).lanes.first;
    expect(lane.cards.single.checklistTotal, 2);
    expect(lane.cards.single.labels.single.name, 'Acil');
  });

  test('başka projenin sütununa taşıma reddedilir', () async {
    final other = await DriftProjectRepository(db)
        .create(const ProjectDraft(title: 'Q'), defaultColumns: ['X']);
    final otherCol =
        (await board.watchBoard(other).first).lanes.single.column.id;
    final k = await board.addCard(cols[0], 'k');
    expect(
      () => board.moveCard(k, otherCol),
      throwsA(isA<BoardRuleException>()),
    );
  });

  test('watchBoard değişiklikte yeniden yayın yapar', () async {
    final emissions = <int>[];
    final sub = board
        .watchBoard(projectId)
        .listen((d) => emissions.add(d.lanes.first.cards.length));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await board.addCard(cols[0], 'k');
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await sub.cancel();
    expect(emissions.first, 0);
    expect(emissions.last, 1);
  });

  test('BoardData.moveCard iyimser taşıma', () async {
    final k1 = await board.addCard(cols[0], 'k1');
    final k2 = await board.addCard(cols[0], 'k2');
    final data = await board.watchBoard(projectId).first;
    final moved = data.moveCard(k2, cols[2], beforeCardId: null);
    expect(moved.lanes[0].cards.map((c) => c.card.id), [k1]);
    expect(moved.lanes[2].cards.single.card.isCompleted, isTrue);
    final back = moved.moveCard(k2, cols[0], beforeCardId: k1);
    expect(back.lanes[0].cards.map((c) => c.card.id), [k2, k1]);
  });
}
