import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/database/database_provider.dart';
import 'package:plan2me/features/reminders/data/notification_gateway.dart';
import 'package:plan2me/features/reminders/data/reminders_providers.dart';
import 'package:plan2me/features/reminders/domain/reminder_planner.dart';
import 'package:plan2me/features/settings/presentation/theme_mode_controller.dart';
import 'package:plan2me/features/tasks/data/tasks_providers.dart';
import 'package:plan2me/features/tasks/domain/task_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

class FakeGateway implements NotificationGateway {
  bool permission = true;
  final batches = <List<PlannedReminder>>[];

  @override
  Future<void> initialize({
    required void Function(String route) onOpen,
  }) async {}
  @override
  Future<String?> launchRoute() async => null;
  @override
  Future<bool> requestPermission() async => permission;
  @override
  Future<void> replaceAll(List<PlannedReminder> reminders) async =>
      batches.add(reminders);
}

void main() {
  late FakeGateway gateway;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = memoryDb();
    gateway = FakeGateway();
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
        notificationGatewayProvider.overrideWithValue(gateway),
      ],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    container.listen(reminderSyncProvider, (_, _) {});
  });

  Future<void> settle() => Future<void>.delayed(ReminderSync.debounce * 2);

  test('izin yoksa açılmaz; açılınca görevler için bildirim kurulur ve ayarlar saklanır', () async {
    final ctrl = container.read(reminderSettingsControllerProvider.notifier);
    gateway.permission = false;
    expect(await ctrl.setEnabled(true), isFalse);
    expect(container.read(reminderSettingsControllerProvider).enabled, isFalse);

    gateway.permission = true;
    expect(await ctrl.setEnabled(true), isTrue);
    await ctrl.setDailyDigest(false);
    final due = DateTime.now().add(const Duration(days: 3));
    await container
        .read(taskRepositoryProvider)
        .addTask(
          QuickTaskInput(title: 'Rapor', dueDate: due),
          inboxTitle: 'Gelen kutusu',
          defaultColumns: ['A', 'B'],
        );
    await settle();
    final last = gateway.batches.last;
    expect(last.map((r) => r.title), ['Yarın: Rapor', 'Bugün: Rapor']);
    expect(last.first.route, startsWith('/cards/'));

    final prefs = container.read(sharedPreferencesProvider);
    expect(prefs.getString('reminder_settings'), contains('"enabled":true'));
  });

  test('kapatınca bekleyen bildirimler temizlenir', () async {
    final ctrl = container.read(reminderSettingsControllerProvider.notifier);
    await ctrl.setEnabled(true);
    await container
        .read(taskRepositoryProvider)
        .addTask(
          QuickTaskInput(
            title: 'X',
            dueDate: DateTime.now().add(const Duration(days: 2)),
          ),
          inboxTitle: 'Gelen kutusu',
          defaultColumns: ['A', 'B'],
        );
    await settle();
    expect(gateway.batches.last, isNotEmpty);
    await ctrl.setEnabled(false);
    await settle();
    expect(gateway.batches.last, isEmpty);
  });
}
