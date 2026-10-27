import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../projects/data/projects_providers.dart';
import '../../settings/presentation/theme_mode_controller.dart';
import '../../tasks/data/tasks_providers.dart';
import '../domain/calendar_sync_plan.dart';
import 'calendar_link_store.dart';
import 'device_calendar_gateway.dart';

part 'calendar_sync_providers.freezed.dart';
part 'calendar_sync_providers.g.dart';

/// Yalnızca mobilde telefon takvimi var.
@Riverpod(keepAlive: true)
DeviceCalendarGateway? deviceCalendarGateway(Ref ref) =>
    (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android))
    ? PluginDeviceCalendarGateway()
    : null;

@Riverpod(keepAlive: true)
CalendarLinkStore calendarLinkStore(Ref ref) =>
    CalendarLinkStore(ref.watch(appDatabaseProvider));

@freezed
abstract class CalendarSyncSettings with _$CalendarSyncSettings {
  const factory CalendarSyncSettings({
    @Default(false) bool enabled,
    @Default(false) bool showDeviceEvents,
    String? calendarId,
  }) = _CalendarSyncSettings;
}

@Riverpod(keepAlive: true)
class CalendarSyncSettingsController extends _$CalendarSyncSettingsController {
  static const _enabledKey = 'calendar_sync_enabled';
  static const _showKey = 'calendar_show_device_events';
  static const _idKey = 'calendar_sync_calendar_id';

  @override
  CalendarSyncSettings build() {
    final p = ref.watch(sharedPreferencesProvider);
    return CalendarSyncSettings(
      enabled: p.getBool(_enabledKey) ?? false,
      showDeviceEvents: p.getBool(_showKey) ?? false,
      calendarId: p.getString(_idKey),
    );
  }

  Future<bool> _ensureAccess() async =>
      await ref.read(deviceCalendarGatewayProvider)?.requestFullAccess() ??
      false;

  /// Açarken tam takvim erişimi ister. Kapatınca CalendarSync plan2me takvimini
  /// ve yazılan etkinlikleri telefondan kaldırır.
  Future<bool> setEnabled(bool enabled) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (enabled) {
      if (!await _ensureAccess()) return false;
      await prefs.setBool(_enabledKey, true);
      state = state.copyWith(enabled: true);
      return true;
    }
    await prefs.setBool(_enabledKey, false);
    // Telefondaki plan2me takvimini CalendarSync bu değişikliği görünce kaldırır.
    state = state.copyWith(enabled: false);
    return true;
  }

  Future<bool> setShowDeviceEvents(bool show) async {
    if (show && !await _ensureAccess()) return false;
    await ref.read(sharedPreferencesProvider).setBool(_showKey, show);
    state = state.copyWith(showDeviceEvents: show);
    return true;
  }

  Future<void> setCalendarId(String? id) async {
    final prefs = ref.read(sharedPreferencesProvider);
    id == null ? await prefs.remove(_idKey) : await prefs.setString(_idKey, id);
    state = state.copyWith(calendarId: id);
  }
}

/// Görev ve proje değişince telefon takvimini eşitler. `listen` ile canlı tutulmalı
/// (Riverpod 3 dinleyicisiz provider'ı duraklatır).
@Riverpod(keepAlive: true)
class CalendarSync extends _$CalendarSync {
  static const debounce = Duration(milliseconds: 900);
  static const calendarColor = '#7CB342';

  Timer? _timer;
  bool _running = false;
  bool _again = false;
  Future<void>? _pendingTeardown;

  /// Kapatma sonrası temizlik bitene kadar bekler (testler ve ayarlar için).
  Future<void> waitForTeardown() async => _pendingTeardown;

  @override
  void build() {
    if (ref.watch(deviceCalendarGatewayProvider) == null) return;
    ref.listen(allTasksProvider, (_, _) => _schedule(), fireImmediately: true);
    ref.listen(
      projectOverviewsProvider,
      (_, _) => _schedule(),
      fireImmediately: true,
    );
    ref.listen(calendarSyncSettingsControllerProvider, (prev, next) {
      if (prev?.enabled == next.enabled) return;
      if (next.enabled) {
        _schedule();
      } else {
        _timer?.cancel();
        _pendingTeardown = teardown();
      }
    });
    ref.onDispose(() => _timer?.cancel());
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(debounce, syncNow);
  }

  /// Hemen eşitler; çalışırken tekrar çağrılırsa bitince bir kez daha çalışır.
  Future<void> syncNow() async {
    if (_running) {
      _again = true;
      return;
    }
    _running = true;
    try {
      do {
        _again = false;
        await _apply();
      } while (_again);
    } catch (e, st) {
      debugPrint('Takvim eşitlenemedi: $e\n$st');
    } finally {
      _running = false;
    }
  }

  Future<void> _apply() async {
    final gateway = ref.read(deviceCalendarGatewayProvider);
    final settings = ref.read(calendarSyncSettingsControllerProvider);
    if (gateway == null || !settings.enabled) return;
    final tasks = ref.read(allTasksProvider).value;
    final projects = ref.read(projectOverviewsProvider).value;
    if (tasks == null || projects == null) return;
    if (!await gateway.hasFullAccess()) return;

    final l10n = lookupAppLocalizations(const Locale('tr'));
    final store = ref.read(calendarLinkStoreProvider);
    final ctrl = ref.read(calendarSyncSettingsControllerProvider.notifier);

    final calendarId = await gateway.ensureCalendar(
      knownId: settings.calendarId,
      name: l10n.calendarSyncCalendarName,
      colorHex: calendarColor,
    );
    if (calendarId != settings.calendarId) {
      // Takvim yeniden oluşturulduysa (ör. kullanıcı sildi) eski eşleşmeler geçersiz.
      if (settings.calendarId != null) await store.clear();
      await ctrl.setCalendarId(calendarId);
    }

    final diff = diffCalendar(
      plannedCalendarEvents(tasks: tasks, projects: projects, l10n: l10n),
      await store.readAll(),
    );
    for (final e in diff.remove.entries) {
      await gateway.deleteEvent(e.value);
      await store.remove(e.key);
    }
    for (final (spec, oldId) in diff.replace) {
      await gateway.deleteEvent(oldId);
      await store.save(
        spec.key,
        await gateway.createAllDayEvent(spec, calendarId: calendarId),
        spec.signature,
      );
    }
    for (final spec in diff.create) {
      await store.save(
        spec.key,
        await gateway.createAllDayEvent(spec, calendarId: calendarId),
        spec.signature,
      );
    }
  }

  /// Eşitleme kapatılınca: plan2me takvimini (ya da varsayılan takvime
  /// yazılan etkinlikleri tek tek) siler, eşleşmeleri temizler.
  Future<void> teardown() async {
    final gateway = ref.read(deviceCalendarGatewayProvider);
    final store = ref.read(calendarLinkStoreProvider);
    final ctrl = ref.read(calendarSyncSettingsControllerProvider.notifier);
    final calendarId = ref
        .read(calendarSyncSettingsControllerProvider)
        .calendarId;
    try {
      if (gateway != null && await gateway.hasFullAccess()) {
        if (calendarId != null) {
          await gateway.deleteCalendar(calendarId);
        } else {
          for (final link in (await store.readAll()).values) {
            await gateway.deleteEvent(link.eventId);
          }
        }
      }
    } catch (e) {
      debugPrint('plan2me takvimi kaldırılamadı: $e');
    }
    await store.clear();
    await ctrl.setCalendarId(null);
  }
}

/// Uygulama takviminde gösterilecek telefon etkinlikleri ([month] ayının
/// bir hafta öncesi ile bir hafta sonrası arası; plan2me takvimi hariç).
@riverpod
Future<List<DeviceEvent>> deviceEvents(Ref ref, DateTime month) async {
  final gateway = ref.watch(deviceCalendarGatewayProvider);
  final settings = ref.watch(calendarSyncSettingsControllerProvider);
  if (gateway == null || !settings.showDeviceEvents) return const [];
  if (!await gateway.hasFullAccess()) return const [];
  final start = DateTime(
    month.year,
    month.month,
  ).subtract(const Duration(days: 7));
  final end = DateTime(
    month.year,
    month.month + 1,
  ).add(const Duration(days: 7));
  return gateway.listEvents(start, end, excludeCalendarId: settings.calendarId);
}
