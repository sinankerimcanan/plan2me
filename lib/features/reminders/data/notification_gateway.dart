import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../domain/reminder_planner.dart';

/// Yerel bildirim platformu soyutlaması (testlerde sahtesi kullanılır).
abstract interface class NotificationGateway {
  Future<void> initialize({required void Function(String route) onOpen});

  /// Uygulama bir bildirime dokunularak açıldıysa o bildirimin rotası.
  Future<String?> launchRoute();
  Future<bool> requestPermission();

  /// Bekleyen tüm hatırlatmaları siler ve [reminders]'ı kurar.
  Future<void> replaceAll(List<PlannedReminder> reminders);
}

class LocalNotificationGateway implements NotificationGateway {
  final _plugin = FlutterLocalNotificationsPlugin();

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'reminders',
      'Hatırlatıcılar',
      channelDescription: 'Görev ve proje son tarihleri',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(threadIdentifier: 'plan2me-reminders'),
  );

  @override
  Future<void> initialize({required void Function(String route) onOpen}) async {
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e) {
      debugPrint('Saat dilimi alınamadı, UTC kullanılacak: $e');
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // İzin, kullanıcı Ayarlar'dan hatırlatıcıları açınca istenir.
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final route = response.payload;
        if (route != null && route.startsWith('/')) onOpen(route);
      },
    );
  }

  @override
  Future<String?> launchRoute() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp != true) return null;
    final route = details!.notificationResponse?.payload;
    return route != null && route.startsWith('/') ? route : null;
  }

  @override
  Future<bool> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.requestNotificationsPermission() ??
          false;
    }
    return false;
  }

  @override
  Future<void> replaceAll(List<PlannedReminder> reminders) async {
    await _plugin.cancelAll();
    for (var i = 0; i < reminders.length; i++) {
      final r = reminders[i];
      await _plugin.zonedSchedule(
        id: 1000 + i,
        title: r.title,
        body: r.body,
        payload: r.route,
        scheduledDate: tz.TZDateTime.from(r.when, tz.local),
        notificationDetails: _details,
        // Kesin alarm izni gerektirmez; birkaç dakikalık sapma kabul edilebilir.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}
