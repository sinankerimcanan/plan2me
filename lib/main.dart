import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/database/demo_seed.dart';
import 'core/router/app_router.dart';
import 'features/board/data/board_providers.dart';
import 'features/home_widget/data/home_widget_sync.dart';
import 'features/people/data/people_providers.dart';
import 'features/projects/data/projects_providers.dart';
import 'features/settings/presentation/theme_mode_controller.dart';
import 'l10n/app_localizations_tr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr');
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      if (await _devStartRoute() case final route?)
        initialLocationProvider.overrideWithValue(route),
    ],
    // Yerel veritabanında hata tekrar denemeyle düzelmez; otomatik retry kapalı.
    retry: (retryCount, error) => null,
  );

  if (kSeedDemoData) {
    final l = AppLocalizationsTr();
    await seedDemoData(
      people: container.read(personRepositoryProvider),
      projects: container.read(projectRepositoryProvider),
      board: container.read(boardRepositoryProvider),
      defaultColumns: [
        l.defaultColumnTodo,
        l.defaultColumnDoing,
        l.defaultColumnDone,
      ],
    );
  }

  // iOS ana ekran widget'ı: App Group'u ayarla ve veri senkronunu başlat.
  // Not: Riverpod 3 dinleyicisi olmayan provider'ları duraklatır; bu yüzden
  // read değil, uygulama ömrü boyunca açık kalan bir listen kullanılıyor.
  if (container.read(widgetBridgeProvider) != null) {
    await HomeWidgetBridge.initialize();
    container.listen(homeWidgetSyncProvider, (_, _) {});
  }

  runApp(
    UncontrolledProviderScope(container: container, child: const Plan2MeApp()),
  );
}

/// Sadece geliştirme (PLAN2ME_SEED) modunda: Documents/dev_start_route.txt varsa
/// uygulama o rotadan açılır. Ekran görüntüsü/manuel test kolaylığı içindir.
Future<String?> _devStartRoute() async {
  if (!kSeedDemoData || kIsWeb || kReleaseMode) return null;
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/dev_start_route.txt');
  if (!file.existsSync()) return null;
  final route = file.readAsStringSync().trim();
  return route.startsWith('/') ? route : null;
}
