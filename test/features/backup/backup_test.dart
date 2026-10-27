import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/backup/data/backup_service.dart';
import 'package:plan2me/features/board/data/drift_board_repository.dart';
import 'package:plan2me/features/board/domain/board_models.dart';
import 'package:plan2me/features/people/data/drift_person_repository.dart';
import 'package:plan2me/features/people/domain/person.dart';
import 'package:plan2me/features/projects/data/drift_project_repository.dart';
import 'package:plan2me/features/projects/domain/project.dart';

import '../../helpers.dart';

void main() {
  test(
    'dışa aktarılan yedek başka bir veritabanına birebir geri yüklenir',
    () async {
      final source = memoryDb();
      final people = DriftPersonRepository(source);
      final projects = DriftProjectRepository(source);
      final board = DriftBoardRepository(source);
      final me = await people.create(
        const PersonInput(name: 'Ben', isMe: true, colorHex: '#7CB342'),
      );
      final pid = await projects.create(
        ProjectDraft(
          title: 'Şirket sitesi',
          priority: Priority.critical,
          status: ProjectStatus.inProgress,
          dueDate: DateTime.utc(2026, 12, 1),
          responsiblePersonId: me.id,
          requesterIds: [me.id],
        ),
        defaultColumns: ['A', 'Bitti'],
      );
      final col = (await board.watchBoard(pid).first).lanes.first.column.id;
      final k = await board.addCard(
        col,
        'Kart',
        initial: CardPatch(
          recurrence: Recurrence.monthly,
          dueDate: DateTime.utc(2026, 11, 5),
          assigneePersonId: me.id,
        ),
      );
      await board.addChecklistItem(k, 'Madde');
      final deleted = await board.addCard(col, 'Silinmiş');
      await board.deleteCard(deleted);

      final json = await BackupService(source).exportJson();
      await source.close();

      final target = memoryDb();
      // Hedefte önceden duran veri silinmeli.
      await DriftPersonRepository(target)
          .create(const PersonInput(name: 'Eski'));
      final service = BackupService(target);
      expect(service.inspect(json), (projects: 1, cards: 1, persons: 1));
      await service.importJson(json);

      final o = (await DriftProjectRepository(target).getOverview(pid))!;
      expect(o.project.title, 'Şirket sitesi');
      expect(o.project.priority, Priority.critical);
      expect(o.project.dueDate, DateTime.utc(2026, 12, 1));
      expect(o.responsible?.name, 'Ben');
      expect(o.requesters.single.id, me.id);
      final card = (await DriftBoardRepository(target).watchCard(k).first)!;
      expect(card.card.recurrence, Recurrence.monthly);
      expect(card.card.assigneePersonId, me.id);
      expect(card.checklist.single.title, 'Madde');
      expect(
        await target.select(target.cards).get(),
        hasLength(2),
      ); // silinmiş kayıt da korunur
      expect((await target.select(target.persons).get()).map((p) => p.name), [
        'Ben',
      ]);
      await target.close();
    },
  );

  test('geçersiz dosyalar anlaşılır hata verir ve veriyi bozmaz', () async {
    final db = memoryDb();
    await DriftPersonRepository(db).create(const PersonInput(name: 'Kalsın'));
    final service = BackupService(db);
    expect(
      () => service.importJson('bozuk'),
      throwsA(isA<BackupFormatException>()),
    );
    expect(
      () => service.importJson('{"format":"baska"}'),
      throwsA(isA<BackupFormatException>()),
    );
    expect(
      () => service.importJson(
        '{"format":"plan2me-backup","schemaVersion":99,"tables":{}}',
      ),
      throwsA(isA<BackupFormatException>()),
    );
    expect((await db.select(db.persons).get()).single.name, 'Kalsın');
    await db.close();
  });
}
