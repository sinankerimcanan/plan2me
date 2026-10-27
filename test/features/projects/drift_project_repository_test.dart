import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/core/domain/place.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/people/data/drift_person_repository.dart';
import 'package:plan2me/features/people/domain/person.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late DriftProjectRepository projects;
  late DriftPersonRepository people;
  late DriftBoardRepository board;

  setUp(() {
    db = memoryDb();
    final clock = fakeClock();
    projects = DriftProjectRepository(db, clock: clock);
    people = DriftPersonRepository(db, clock: clock);
    board = DriftBoardRepository(db, clock: clock);
  });
  tearDown(() => db.close());

  const columns = ['Yapılacak', 'Devam ediyor', 'Tamamlandı'];

  test(
    'proje varsayılan sütunlarla oluşur, son sütun tamamlanma sütunu',
    () async {
      final id = await projects.create(
        const ProjectDraft(title: 'Web sitesi'),
        defaultColumns: columns,
      );
      final data = await board.watchBoard(id).first;
      expect(data.lanes.map((l) => l.column.name), columns);
      expect(data.lanes.map((l) => l.column.isDoneColumn), [
        false,
        false,
        true,
      ]);
    },
  );

  test('talep edenler eklenir, çıkarılır ve tekrar eklenebilir', () async {
    final ali = await people.create(const PersonInput(name: 'Ali Veli'));
    final ayse = await people.create(const PersonInput(name: 'Ayşe'));
    final id = await projects.create(
      ProjectDraft(
        title: 'P',
        requesterIds: [ali.id, ayse.id],
        responsiblePersonId: ali.id,
      ),
      defaultColumns: columns,
    );
    var o = (await projects.getOverview(id))!;
    expect(o.requesters.map((p) => p.name), ['Ali Veli', 'Ayşe']);
    expect(o.responsible?.id, ali.id);

    await projects.update(
      id,
      ProjectDraft.fromOverview(o).copyWith(requesterIds: [ayse.id]),
    );
    o = (await projects.getOverview(id))!;
    expect(o.requesters.map((p) => p.id), [ayse.id]);

    // Tombstone dirilir, UNIQUE çakışması olmaz.
    await projects.update(
      id,
      ProjectDraft.fromOverview(o).copyWith(requesterIds: [ali.id, ayse.id]),
    );
    o = (await projects.getOverview(id))!;
    expect(o.requesters.length, 2);
  });

  test('kişi silinince sorumluluk ve talep kayıtları temizlenir', () async {
    final ali = await people.create(const PersonInput(name: 'Ali'));
    final id = await projects.create(
      ProjectDraft(
        title: 'P',
        requesterIds: [ali.id],
        responsiblePersonId: ali.id,
      ),
      defaultColumns: columns,
    );
    await people.delete(ali.id);
    final o = (await projects.getOverview(id))!;
    expect(o.responsible, isNull);
    expect(o.requesters, isEmpty);
  });

  test('ilerleme tamamlanma sütunundaki kartlardan hesaplanır', () async {
    final id = await projects.create(
      const ProjectDraft(title: 'P'),
      defaultColumns: columns,
    );
    final lanes = (await board.watchBoard(id).first).lanes;
    final c1 = await board.addCard(lanes[0].column.id, 'Bir');
    await board.addCard(lanes[0].column.id, 'İki');
    await board.moveCard(c1, lanes[2].column.id);
    final o = (await projects.getOverview(id))!;
    expect((o.totalCards, o.doneCards), (2, 1));
  });

  test('proje silinince tüm board içeriği soft-delete olur', () async {
    final id = await projects.create(
      const ProjectDraft(title: 'P'),
      defaultColumns: columns,
    );
    final col = (await board.watchBoard(id).first).lanes.first.column.id;
    final card = await board.addCard(col, 'Kart');
    await board.addChecklistItem(card, 'Madde');
    await projects.delete(id);

    expect(await projects.getOverview(id), isNull);
    final aliveCards = await (db.select(
      db.cards,
    )..where((t) => t.deletedAt.isNull())).get();
    final aliveItems = await (db.select(
      db.checklistItems,
    )..where((t) => t.deletedAt.isNull())).get();
    expect(aliveCards, isEmpty);
    expect(aliveItems, isEmpty);
    // Satırlar fiziksel olarak duruyor (senkron için tombstone).
    expect(await db.select(db.cards).get(), hasLength(1));
  });

  test(
    'manuel sıralama: yeni proje başa eklenir, move ile yer değişir',
    () async {
      final a = await projects.create(
        const ProjectDraft(title: 'A'),
        defaultColumns: columns,
      );
      final b = await projects.create(
        const ProjectDraft(title: 'B'),
        defaultColumns: columns,
      );
      var list = await projects.watchOverviews().first;
      expect(list.map((o) => o.project.title), ['B', 'A']);
      await projects.move(b); // sona
      list = await projects.watchOverviews().first;
      expect(list.map((o) => o.project.id), [a, b]);
    },
  );

  test('durum güncellemesi version artırır', () async {
    final id = await projects.create(
      const ProjectDraft(title: 'P'),
      defaultColumns: columns,
    );
    await projects.updateStatus(id, ProjectStatus.inProgress);
    final row = await (db.select(
      db.projects,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(row.status, ProjectStatus.inProgress);
    expect(row.version, 2);
  });

  test('proje konumu oluşturulur ve düzenlemede kaldırılabilir', () async {
    const yer = Place(
      name: 'Şantiye, Ataşehir',
      latitude: 40.98,
      longitude: 29.12,
    );
    final id = await projects.create(
      const ProjectDraft(title: 'Saha', location: yer),
      defaultColumns: columns,
    );
    var o = (await projects.getOverview(id))!;
    expect(o.project.location, yer);
    expect(ProjectDraft.fromOverview(o).location, yer);
    await projects.update(
      id,
      ProjectDraft.fromOverview(o).copyWith(location: null),
    );
    o = (await projects.getOverview(id))!;
    expect(o.project.location, isNull);
  });
}
