import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/features/trash/presentation/trash_screen.dart';

import '../../helpers.dart';
import '../../helpers_widget.dart';

void main() {
  setUpAll(() => initializeDateFormatting('tr'));

  testWidgets('silinen kart çöpte görünür, geri yükle ile board\'a döner', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final db = memoryDb();
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await tester.runAsync(db.close);
    });
    late String pid;
    late String cardId;
    await tester.runAsync(() async {
      pid = await container
          .read(projectRepositoryProvider)
          .create(const ProjectDraft(title: 'Proje'), defaultColumns: ['A']);
      final board = container.read(boardRepositoryProvider);
      final col = (await board.watchBoard(pid).first).lanes.single.column.id;
      cardId = await board.addCard(col, 'Silinecek kart');
      await board.deleteCard(cardId);
    });

    await tester.pumpWidget(testApp(container, const TrashScreen()));
    await settleDb(tester);
    expect(find.text('Silinecek kart'), findsOneWidget);
    expect(find.textContaining('Görev · Proje'), findsOneWidget);

    await tester.tap(find.byTooltip('Geri yükle'));
    await settleDb(tester);
    expect(find.text('Çöp kutusu boş'), findsOneWidget);
    final lanes = await tester.runAsync(
      () async =>
          (await container.read(boardRepositoryProvider).watchBoard(pid).first)
              .lanes,
    );
    expect(lanes!.single.cards.single.card.id, cardId);
  });
}
