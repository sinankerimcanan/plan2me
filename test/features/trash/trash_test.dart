import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/people/data/drift_person_repository.dart';
import 'package:plan2me/features/people/domain/person.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/trash/data/drift_trash_repository.dart';
import 'package:plan2me/features/trash/domain/trash_item.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late DriftBoardRepository board;
  late DriftProjectRepository projects;
  late DriftPersonRepository people;
  late DriftTrashRepository trash;
  late String pid;
  late List<String> cols;

  setUp(() async {
    db = memoryDb();
    final clock = fakeClock();
    board = DriftBoardRepository(db, clock: clock);
    projects = DriftProjectRepository(db, clock: clock);
    people = DriftPersonRepository(db, clock: clock);
    trash = DriftTrashRepository(db, clock: clock);
    pid = await projects.create(
      const ProjectDraft(title: 'Proje'),
      defaultColumns: ['A', 'B'],
    );
    cols = [
      for (final l in (await board.watchBoard(pid).first).lanes) l.column.id,
    ];
  });
  tearDown(() => db.close());

  test('proje silinip geri alınınca tüm içeriği döner', () async {
    final k = await board.addCard(cols[0], 'Kart');
    await board.addChecklistItem(k, 'Madde');
    final label = await board.createLabel(pid, 'E', '#7CB342');
    await board.setCardLabel(k, label.id, enabled: true);

    await projects.delete(pid);
    final items = await trash.watchTrash().first;
    expect(items.single.kind, TrashKind.project);

    await trash.restore(items.single);
    final data = await board.watchBoard(pid).first;
    expect(data.lanes, hasLength(2));
    final card = data.lanes.first.cards.single;
    expect(card.checklistTotal, 1);
    expect(card.labels.single.name, 'E');
    expect(await trash.watchTrash().first, isEmpty);
  });

  test(
    'daha önce ayrıca silinmiş kart proje geri alınınca geri gelmez',
    () async {
      final keep = await board.addCard(cols[0], 'Kalan');
      final gone = await board.addCard(cols[0], 'Önceden silinen');
      await board.deleteCard(gone);
      await projects.delete(pid);
      await trash.restoreProject(pid);
      final titles = [
        for (final c in (await board.watchBoard(pid).first).lanes.first.cards)
          c.card.id,
      ];
      expect(titles, [keep]);
      expect((await trash.watchTrash().first).single.id, gone);
    },
  );

  test('sütunu silinmiş kart geri alınınca ilk açık sütuna gider', () async {
    final k = await board.addCard(cols[1], 'Kart');
    await board.deleteColumn(cols[1]);
    await trash.restoreCard(k);
    final lanes = (await board.watchBoard(pid).first).lanes;
    expect(lanes, hasLength(1));
    expect(lanes.single.cards.single.card.id, k);
  });

  test('kişi geri alınınca talep eden kaydı da döner', () async {
    final p = await people.create(const PersonInput(name: 'Ali'));
    await projects.update(
      pid,
      ProjectDraft(title: 'Proje', requesterIds: [p.id]),
    );
    await people.delete(p.id);
    expect((await projects.getOverview(pid))!.requesters, isEmpty);
    await trash.restorePerson(p.id);
    expect((await projects.getOverview(pid))!.requesters.single.name, 'Ali');
  });

  test(
    'kalıcı silme ve çöpü boşaltma satırları fiziksel olarak siler',
    () async {
      final k = await board.addCard(cols[0], 'Kart');
      await board.addChecklistItem(k, 'Madde');
      await board.deleteCard(k);
      final item = (await trash.watchTrash().first).single;
      await trash.purge(item);
      expect(await db.select(db.cards).get(), isEmpty);
      expect(await db.select(db.checklistItems).get(), isEmpty);

      await projects.delete(pid);
      await trash.emptyTrash();
      expect(await db.select(db.projects).get(), isEmpty);
      expect(await db.select(db.boardColumns).get(), isEmpty);
    },
  );

  test('purgeOlderThan sadece eski çöpü siler', () async {
    final k = await board.addCard(cols[0], 'Kart');
    await board.deleteCard(k);
    expect(await trash.purgeOlderThan(const Duration(days: 30)), 0);
    expect(await trash.purgeOlderThan(Duration.zero), 1);
  });
}
