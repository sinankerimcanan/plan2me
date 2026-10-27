import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/core/theme/app_theme.dart';
import 'package:plan2me/features/board/data/board_providers.dart';
import 'package:plan2me/features/board/presentation/board_screen.dart';
import 'package:plan2me/features/board/presentation/widgets/kanban_card_tile.dart';
import 'package:plan2me/features/projects/data/projects_providers.dart';
import 'package:plan2me/features/projects/domain/project.dart';
import 'package:plan2me/l10n/app_localizations.dart';

import '../../helpers.dart';

void main() {
  setUpAll(() => initializeDateFormatting('tr'));

  testWidgets('kart uzun basıp başka sütuna sürüklenince taşınır', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
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

    late String projectId;
    late List<String> columns;
    await tester.runAsync(() async {
      projectId = await container
          .read(projectRepositoryProvider)
          .create(
            const ProjectDraft(title: 'Test'),
            defaultColumns: ['Yapılacak', 'Devam', 'Bitti'],
          );
      final board = container.read(boardRepositoryProvider);
      columns = [
        for (final l in (await board.watchBoard(projectId).first).lanes)
          l.column.id,
      ];
      await board.addCard(columns[0], 'Sürüklenecek kart');
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('tr'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: BoardScreen(projectId: projectId),
        ),
      ),
    );
    // Drift stream'leri gerçek async; yüklenmesi için gerçek zamanda bekle.
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
    }

    final card = find.text('Sürüklenecek kart');
    expect(card, findsOneWidget);
    expect(find.text('Devam'), findsOneWidget);

    // Hedef: "Devam" sütununun boş bırakma alanı (ilk sütunda kart olduğu için
    // bu metin sadece boş sütunlarda görünür; ilki "Devam").
    final target = tester.getCenter(find.text('Kartı buraya bırak').first);
    final gesture = await tester.startGesture(tester.getCenter(card));
    await tester.pump(
      const Duration(milliseconds: 400),
    ); // uzun basma gecikmesi
    await gesture.moveBy(const Offset(20, 0));
    await tester.pump();
    await gesture.moveTo(target);
    await tester.pump();
    await gesture.up();
    await tester.pump();

    // İyimser güncelleme: kart anında yeni sütunda.
    expect(find.byType(KanbanCardTile), findsOneWidget);

    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
    }
    final lanes = await tester.runAsync(
      () async =>
          (await container
                  .read(boardRepositoryProvider)
                  .watchBoard(projectId)
                  .first)
              .lanes,
    );
    expect(lanes![0].cards, isEmpty);
    expect(lanes[1].cards.single.card.title, 'Sürüklenecek kart');
    expect(lanes[1].cards.single.card.isCompleted, isFalse);
    await tester.pumpWidget(const SizedBox());
  });
}
