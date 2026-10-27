import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/board/domain/board_repository.dart';
import 'package:plan2me/features/people/data/drift_person_repository.dart';
import 'package:plan2me/features/people/domain/person.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';

import '../../helpers.dart';

void main() {
  group('Recurrence.next', () {
    test('ay sonu taşması kırpılır', () {
      expect(
        Recurrence.monthly.next(DateTime.utc(2026, 1, 31)),
        DateTime.utc(2026, 2, 28),
      );
      expect(
        Recurrence.yearly.next(DateTime.utc(2028, 2, 29)),
        DateTime.utc(2029, 2, 28),
      );
      expect(
        Recurrence.weekly.next(DateTime.utc(2026, 12, 28)),
        DateTime.utc(2027, 1, 4),
      );
      expect(
        Recurrence.daily.next(DateTime.utc(2026, 10, 31)),
        DateTime.utc(2026, 11, 1),
      );
    });
  });

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

  test('completeCard / reopenCard tamamlanma sütununu kullanır', () async {
    final k = await board.addCard(cols[0], 'k');
    await board.completeCard(k);
    var d = (await board.watchCard(k).first)!;
    expect(d.column?.isDoneColumn, isTrue);
    expect(d.card.isCompleted, isTrue);
    await board.reopenCard(k);
    d = (await board.watchCard(k).first)!;
    expect(d.card.columnId, cols[0]);
    expect(d.card.isCompleted, isFalse);
  });

  test("kart sorumlusu atanır, board'da görünür ve kaldırılabilir", () async {
    final me = await DriftPersonRepository(db)
        .create(const PersonInput(name: 'Ben'));
    final k = await board.addCard(cols[0], 'k');
    await board.updateCard(k, CardPatch(assigneePersonId: me.id));
    var lane = (await board.watchBoard(projectId).first).lanes.first;
    expect(lane.cards.single.assignee?.name, 'Ben');
    await board.updateCard(k, const CardPatch(clearAssignee: true));
    lane = (await board.watchBoard(projectId).first).lanes.first;
    expect(lane.cards.single.assignee, isNull);
  });

  test('tekrarlı kart tamamlanınca sonraki tekrar etiket, sorumlu ve checklist ile oluşur', () async {
    final me = await DriftPersonRepository(db)
        .create(const PersonInput(name: 'Ben'));
    final now = DateTime.now();
    final due = DateTime.utc(now.year, now.month, now.day + 2);
    final k = await board.addCard(
      cols[0],
      'Haftalık rapor',
      initial: CardPatch(
        recurrence: Recurrence.weekly,
        assigneePersonId: me.id,
        priority: Priority.high,
        dueDate: due,
      ),
    );
    final label = await board.createLabel(projectId, 'Rapor', '#1E88E5');
    await board.setCardLabel(k, label.id, enabled: true);
    await board.addChecklistItem(k, 'Veri topla');
    final item = (await board.watchCard(k).first)!.checklist.single;
    await board.setChecklistItemDone(item.id, done: true);

    await board.completeCard(k);
    // Yeniden açıp tekrar tamamlamak ikinci bir kopya üretmez.
    await board.reopenCard(k);
    await board.completeCard(k);

    final open = [
      for (final lane in (await board.watchBoard(projectId).first).lanes)
        for (final c in lane.cards)
          if (!c.card.isCompleted) c,
    ];
    expect(open, hasLength(1));
    final next = open.single;
    expect(next.card.id, isNot(k));
    expect(next.card.columnId, cols[0]);
    expect(next.card.recurrence, Recurrence.weekly);
    expect(next.card.priority, Priority.high);
    expect(next.card.dueDate, Recurrence.weekly.next(due));
    expect(next.assignee?.id, me.id);
    expect(next.labels.single.name, 'Rapor');
    expect((next.checklistTotal, next.checklistDone), (1, 0));
  });

  test(
    'geç tamamlanan tekrar geçmişi atlar, sonraki tekrar yarına düşer',
    () async {
      // Bu dosyadaki sahte saat 2026-01-01 09:00 UTC'de başlar.
      final k = await board.addCard(
        cols[0],
        'Günlük',
        initial: CardPatch(
          recurrence: Recurrence.daily,
          dueDate: DateTime.utc(2020, 1, 1),
        ),
      );
      await board.completeCard(k);
      final next =
          (await board.watchBoard(projectId).first).lanes.first.cards.single;
      expect(next.card.dueDate, DateTime.utc(2026, 1, 2));
    },
  );

  test(
    'undoComplete kartı eski sütununa alır ve üretilen tekrarı siler',
    () async {
      final k = await board.addCard(
        cols[1],
        'Tekrarlı',
        initial: CardPatch(
          recurrence: Recurrence.daily,
          dueDate: DateTime.utc(2026, 1, 5),
        ),
      );
      await board.completeCard(k);
      var open = [
        for (final l in (await board.watchBoard(projectId).first).lanes)
          for (final c in l.cards)
            if (!c.card.isCompleted) c.card.id,
      ];
      expect(open, hasLength(1)); // sonraki tekrar

      await board.undoComplete(k, toColumnId: cols[1]);
      final lanes = (await board.watchBoard(projectId).first).lanes;
      open = [
        for (final l in lanes)
          for (final c in l.cards) c.card.id,
      ];
      expect(open, [k]);
      expect(lanes[1].cards.single.card.isCompleted, isFalse);

      // Tekrar tamamlanınca yine tek bir sonraki tekrar oluşur.
      await board.completeCard(k);
      final again = [
        for (final l in (await board.watchBoard(projectId).first).lanes)
          for (final c in l.cards)
            if (!c.card.isCompleted) c,
      ];
      expect(again, hasLength(1));
    },
  );
}
