import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../projects/data/projects_providers.dart';
import '../../settings/presentation/theme_mode_controller.dart';
import '../../tasks/data/tasks_providers.dart';
import '../domain/reminder_planner.dart';
import '../domain/reminder_settings.dart';
import 'notification_gateway.dart';

part 'reminders_providers.g.dart';

/// Yalnızca mobilde bildirim var; web'de null.
@Riverpod(keepAlive: true)
NotificationGateway? notificationGateway(Ref ref) =>
    (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android))
    ? LocalNotificationGateway()
    : null;

@Riverpod(keepAlive: true)
class ReminderSettingsController extends _$ReminderSettingsController {
  static const _key = 'reminder_settings';

  @override
  ReminderSettings build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(_key);
    if (raw == null) return const ReminderSettings();
    try {
      return ReminderSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const ReminderSettings();
    }
  }

  Future<void> _save(ReminderSettings s) async {
    state = s;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode(s.toJson()));
  }

  /// Açarken bildirim izni ister; izin yoksa kapalı kalır ve false döner.
  Future<bool> setEnabled(bool enabled) async {
    if (enabled) {
      final granted =
          await ref.read(notificationGatewayProvider)?.requestPermission() ??
          false;
      if (!granted) return false;
    }
    await _save(state.copyWith(enabled: enabled));
    return true;
  }

  Future<void> setTime(int hour, int minute) =>
      _save(state.copyWith(hour: hour, minute: minute));
  Future<void> setDayBefore(bool v) => _save(state.copyWith(dayBefore: v));
  Future<void> setDailyDigest(bool v) => _save(state.copyWith(dailyDigest: v));
}

/// Görev, proje veya ayar değişince bildirimleri yeniden kurar.
/// Riverpod 3 dinleyicisiz provider'ı duraklattığı için `listen` ile canlı tutulmalı.
@Riverpod(keepAlive: true)
class ReminderSync extends _$ReminderSync {
  static const debounce = Duration(milliseconds: 600);

  Timer? _timer;
  String? _lastSignature;

  @override
  void build() {
    final gateway = ref.watch(notificationGatewayProvider);
    if (gateway == null) return;
    ref.listen(
      allTasksProvider,
      (_, _) => _schedule(gateway),
      fireImmediately: true,
    );
    ref.listen(
      projectOverviewsProvider,
      (_, _) => _schedule(gateway),
      fireImmediately: true,
    );
    ref.listen(
      reminderSettingsControllerProvider,
      (_, _) => _schedule(gateway),
      fireImmediately: true,
    );
    ref.onDispose(() => _timer?.cancel());
  }

  void _schedule(NotificationGateway gateway) {
    _timer?.cancel();
    _timer = Timer(debounce, () => _apply(gateway));
  }

  Future<void> _apply(NotificationGateway gateway) async {
    final tasks = ref.read(allTasksProvider).value;
    final projects = ref.read(projectOverviewsProvider).value;
    if (tasks == null || projects == null) return;
    final plan = planReminders(
      tasks: tasks,
      projects: projects,
      settings: ref.read(reminderSettingsControllerProvider),
      now: DateTime.now(),
      l10n: lookupAppLocalizations(const Locale('tr')),
    );
    final signature = jsonEncode([
      for (final r in plan)
        [r.when.toIso8601String(), r.title, r.body, r.route],
    ]);
    if (signature == _lastSignature) return;
    _lastSignature = signature;
    try {
      await gateway.replaceAll(plan);
    } catch (e, st) {
      debugPrint('Hatırlatıcılar kurulamadı: $e\n$st');
    }
  }
}
