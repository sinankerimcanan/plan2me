import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/core/utils/clock.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/tasks/data/tasks_providers.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';
import 'package:plan2me/features/tasks/presentation/quick_add_sheet.dart';
import 'package:plan2me/features/tasks/presentation/tasks_screen.dart';

import '../../helpers.dart';
import '../../helpers_widget.dart';

void main() {
  setUpAll(() => initializeDateFormatting('tr'));

  late ProviderContainer container;

  Future<void> pumpTasks(WidgetTester tester) async {
    tester.view.physicalSize = const Size(430, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final db = memoryDb();
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await tester.runAsync(db.close);
    });
    await tester.runAsync(() async {
      final pid = await container
          .read(projectRepositoryProvider)
          .create(
            const ProjectDraft(title: 'Site'),
            defaultColumns: ['Yapılacak', 'Devam', 'Bitti'],
          );
      final col =
          (await container.read(boardRepositoryProvider).watchBoard(pid).first)
              .lanes[1]
              .column
              .id;
      await container
          .read(boardRepositoryProvider)
          .addCard(col, 'Devamdaki görev');
      await container
          .read(taskRepositoryProvider)
          .addTask(
            QuickTaskInput(title: 'Bugünkü görev', dueDate: today()),
            inboxTitle: 'Gelen kutusu',
            defaultColumns: ['Yapılacak', 'Devam', 'Bitti'],
          );
    });
    await tester.pumpWidget(testApp(container, const TasksScreen()));
    await settleDb(tester);
  }

  Future<TaskItem> task(WidgetTester tester, String title) async =>
      (await tester.runAsync(
        () async =>
            (await container.read(taskRepositoryProvider).watchTasks().first)
                .firstWhere((t) => t.card.title == title),
      ))!;

  testWidgets('gruplar ve Gelen kutusu etiketi görünür', (tester) async {
    await pumpTasks(tester);
    expect(find.text('Bugün'), findsWidgets);
    expect(find.text('Tarihsiz'), findsOneWidget);
    expect(find.text('Gelen kutusu'), findsOneWidget);
    expect(find.text('Site'), findsOneWidget);
  });

  testWidgets('daireye dokununca tamamlanır, Geri al eski sütuna döndürür', (
    tester,
  ) async {
    await pumpTasks(tester);
    final tile = find.ancestor(
      of: find.text('Devamdaki görev'),
      matching: find.byType(TaskRow),
    );
    await tester.tap(
      find.descendant(of: tile, matching: find.byType(InkResponse)).first,
    );
    await settleDb(tester);
    expect((await task(tester, 'Devamdaki görev')).isCompleted, isTrue);
    expect(find.text('Görev tamamlandı'), findsOneWidget);

    await tester.tap(find.text('Geri al'));
    await settleDb(tester);
    final t = await task(tester, 'Devamdaki görev');
    expect(t.isCompleted, isFalse);
    expect(t.columnName, 'Devam');
  });

  testWidgets('sağa kaydırma tamamlar, sola kaydırma yarına erteler', (
    tester,
  ) async {
    await pumpTasks(tester);
    await tester.drag(find.text('Bugünkü görev'), const Offset(-400, 0));
    await settleDb(tester);
    expect(
      (await task(tester, 'Bugünkü görev')).card.dueDate,
      today().add(const Duration(days: 1)),
    );
    expect(find.text('Yarına ertelendi'), findsOneWidget);

    await tester.drag(find.text('Bugünkü görev'), const Offset(400, 0));
    await settleDb(tester);
    expect((await task(tester, 'Bugünkü görev')).isCompleted, isTrue);
  });

  testWidgets('hızlı ekleme Enter ile ekler ve açık kalır', (tester) async {
    await pumpTasks(tester);
    // Menüdeki "+" düğmesinin çağırdığı akış.
    unawaited(showQuickAddSheet(tester.element(find.byType(TasksScreen))));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Süt al');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await settleDb(tester);
    expect(find.text('+1'), findsOneWidget);
    final added = await task(tester, 'Süt al');
    expect(added.isInbox, isTrue);
  });
}
