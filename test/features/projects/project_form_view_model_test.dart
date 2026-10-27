import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/app_database.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/core/domain/enums.dart';
import 'package:plan2me/features/people/data/people_providers.dart';
import 'package:plan2me/features/people/domain/person.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/presentation/project_form_view_model.dart';

import '../../helpers.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = memoryDb();
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      retry: (_, _) => null,
    );
  });
  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('yeni proje taslağında "ben" varsayılan sorumlu olur', () async {
    final me = await container
        .read(personRepositoryProvider)
        .create(const PersonInput(name: 'Ben', isMe: true));
    final provider = projectFormViewModelProvider(null);
    final sub = container.listen(provider, (_, _) {});
    final draft = await container.read(provider.future);
    expect(draft.responsiblePersonId, me.id);
    sub.close();
  });

  test(
    'form kaydı varsayılan sütunlarla proje oluşturur, düzenleme günceller',
    () async {
      final provider = projectFormViewModelProvider(null);
      final sub = container.listen(provider, (_, _) {});
      await container.read(provider.future);
      final vm = container.read(provider.notifier)
        ..setTitle('  Yeni proje  ')
        ..setPriority(Priority.critical)
        ..setStartDate(DateTime(2026, 5, 10))
        ..setDueDate(DateTime(2026, 5, 1)); // başlangıçtan önce: kabul edilir
      expect(vm.canSave, isTrue);
      final id = await vm.save(defaultColumns: ['A', 'B']);
      sub.close();

      final o = (await container
          .read(projectRepositoryProvider)
          .getOverview(id!))!;
      expect(o.project.title, 'Yeni proje');
      expect(o.project.priority, Priority.critical);

      final editProvider = projectFormViewModelProvider(id);
      final sub2 = container.listen(editProvider, (_, _) {});
      final draft = await container.read(editProvider.future);
      expect(draft.title, 'Yeni proje');
      container.read(editProvider.notifier).setStatus(ProjectStatus.done);
      await container
          .read(editProvider.notifier)
          .save(defaultColumns: const []);
      sub2.close();
      final updated = (await container
          .read(projectRepositoryProvider)
          .getOverview(id))!;
      expect(updated.project.status, ProjectStatus.done);
    },
  );

  test('başlık boşsa kaydetmez', () async {
    final provider = projectFormViewModelProvider(null);
    final sub = container.listen(provider, (_, _) {});
    await container.read(provider.future);
    expect(container.read(provider.notifier).canSave, isFalse);
    expect(
      await container.read(provider.notifier).save(defaultColumns: ['A']),
      isNull,
    );
    sub.close();
  });
}
