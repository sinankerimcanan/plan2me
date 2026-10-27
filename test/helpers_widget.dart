import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/theme/app_theme.dart';
import 'package:plan2me/core/widgets/toast.dart';
import 'package:plan2me/l10n/app_localizations.dart';

/// Ekranı gerçek tema, Türkçe yerelleştirme ve global snackbar ile sarar.
Widget testApp(ProviderContainer container, Widget home) => UncontrolledProviderScope(
  container: container,
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('tr'),
    scaffoldMessengerKey: rootMessengerKey,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: home,
  ),
);

/// Drift stream'leri gerçek async çalışır; birkaç tur gerçek zamanda bekleyip çizer.
Future<void> settleDb(WidgetTester tester, {int rounds = 5}) async {
  for (var i = 0; i < rounds; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 40)));
    await tester.pump(const Duration(milliseconds: 50));
  }
}
