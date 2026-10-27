import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/theme/app_theme.dart';
import 'package:plan2me/core/widgets/liquid_nav_bar.dart';

void main() {
  const items = [
    LiquidNavItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Projeler',
    ),
    LiquidNavItem(
      icon: Icons.task_alt_outlined,
      selectedIcon: Icons.task_alt_rounded,
      label: 'Görevler',
    ),
    LiquidNavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      label: 'Ayarlar',
    ),
  ];

  Widget host({
    required int index,
    required ValueChanged<int> onSelected,
    LiquidNavAction? action,
  }) => MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      extendBody: true,
      body: const SizedBox.expand(),
      bottomNavigationBar: LiquidNavBar(
        items: items,
        selectedIndex: index,
        onSelected: onSelected,
        action: action,
      ),
    ),
  );

  testWidgets(
    'sekmeye dokununca seçilir; seçili sekme dolu ikonla gösterilir',
    (tester) async {
      int? tapped;
      await tester.pumpWidget(host(index: 0, onSelected: (i) => tapped = i));
      expect(find.byIcon(Icons.dashboard_rounded), findsOneWidget);
      expect(find.byIcon(Icons.task_alt_outlined), findsOneWidget);
      await tester.tap(find.text('Görevler'));
      expect(tapped, 1);

      await tester.pumpWidget(host(index: 1, onSelected: (_) {}));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.task_alt_rounded), findsOneWidget);
    },
  );

  testWidgets('eylem düğmesi menünün yanında, içeriğin üstüne binmeden durur', (
    tester,
  ) async {
    var pressed = 0;
    await tester.pumpWidget(
      host(
        index: 0,
        onSelected: (_) {},
        action: LiquidNavAction(
          icon: Icons.add_rounded,
          tooltip: 'Yeni proje',
          onPressed: () => pressed++,
        ),
      ),
    );
    await tester.pumpAndSettle();
    final button = tester.getRect(find.byTooltip('Yeni proje'));
    final bar = tester.getRect(find.byType(LiquidNavBar));
    // Düğme menü şeridinin içinde: üst kenarı menünün üstünden taşmıyor.
    expect(button.top, greaterThanOrEqualTo(bar.top));
    expect(button.bottom, lessThanOrEqualTo(bar.bottom));
    await tester.tap(find.byTooltip('Yeni proje'));
    expect(pressed, 1);

    await tester.pumpWidget(host(index: 2, onSelected: (_) {}));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Yeni proje'), findsNothing);
  });
}
