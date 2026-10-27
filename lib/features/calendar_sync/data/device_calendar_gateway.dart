import 'package:device_calendar_plus/device_calendar_plus.dart' as dc;
import 'package:flutter/foundation.dart';

import '../domain/calendar_sync_plan.dart';

/// Telefon takvimindeki (plan2me dışındaki) bir etkinlik.
class DeviceEvent {
  const DeviceEvent({
    required this.instanceId,
    required this.calendarId,
    required this.title,
    required this.start,
    required this.end,
    required this.allDay,
    this.location,
    this.colorHex,
  });

  final String instanceId;
  final String calendarId;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool allDay;
  final String? location;
  final String? colorHex;
}

/// Telefon takvimi soyutlaması (testlerde sahtesi kullanılır).
abstract interface class DeviceCalendarGateway {
  Future<bool> hasFullAccess();
  Future<bool> requestFullAccess();

  /// [knownId] takvimi hâlâ varsa onu, yoksa yeni "plan2me" takvimini döner.
  /// Cihaz yeni takvim açmaya izin vermiyorsa null (varsayılan takvim kullanılır).
  Future<String?> ensureCalendar({
    String? knownId,
    required String name,
    required String colorHex,
  });
  Future<void> deleteCalendar(String id);
  Future<String> createAllDayEvent(
    CalendarEventSpec spec, {
    String? calendarId,
  });

  /// Etkinlik zaten yoksa sessizce geçer.
  Future<void> deleteEvent(String eventId);
  Future<List<DeviceEvent>> listEvents(
    DateTime start,
    DateTime end, {
    String? excludeCalendarId,
  });
  Future<void> openEvent(String instanceId);
}

class PluginDeviceCalendarGateway implements DeviceCalendarGateway {
  final _cal = dc.DeviceCalendar.instance;

  @override
  Future<bool> hasFullAccess() async {
    try {
      return await _cal.hasPermissions() == dc.CalendarPermissionStatus.granted;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestFullAccess() async {
    try {
      return await _cal.requestPermissions() ==
          dc.CalendarPermissionStatus.granted;
    } catch (e) {
      debugPrint('Takvim izni istenemedi: $e');
      return false;
    }
  }

  @override
  Future<String?> ensureCalendar({
    String? knownId,
    required String name,
    required String colorHex,
  }) async {
    final calendars = await _cal.listCalendars();
    if (knownId != null &&
        calendars.any((c) => c.id == knownId && !c.readOnly)) {
      return knownId;
    }
    try {
      return await _cal.createCalendar(name: name, colorHex: colorHex);
    } on dc.DeviceCalendarException catch (e) {
      debugPrint(
        'plan2me takvimi oluşturulamadı, varsayılan takvim kullanılacak: $e',
      );
      return null;
    }
  }

  @override
  Future<void> deleteCalendar(String id) async {
    try {
      await _cal.deleteCalendar(id);
    } on dc.DeviceCalendarException catch (e) {
      if (e.errorCode != dc.DeviceCalendarError.notFound) rethrow;
    }
  }

  @override
  Future<String> createAllDayEvent(
    CalendarEventSpec spec, {
    String? calendarId,
  }) {
    final day = DateTime(spec.date.year, spec.date.month, spec.date.day);
    return _cal.createEvent(
      calendarId: calendarId,
      title: spec.title,
      startDate: day,
      endDate: day.add(const Duration(days: 1)),
      isAllDay: true,
      description: spec.description,
      location: spec.location,
      url: spec.url,
      availability: dc.EventAvailability.free,
    );
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      await _cal.deleteEvent(instanceId: eventId);
    } on dc.DeviceCalendarException catch (e) {
      if (e.errorCode != dc.DeviceCalendarError.notFound) rethrow;
    }
  }

  @override
  Future<List<DeviceEvent>> listEvents(
    DateTime start,
    DateTime end, {
    String? excludeCalendarId,
  }) async {
    final events = await _cal.listEvents(start, end);
    return [
      for (final e in events)
        if (e.calendarId != excludeCalendarId)
          DeviceEvent(
            instanceId: e.instanceId,
            calendarId: e.calendarId,
            title: e.title,
            start: e.startDate,
            end: e.endDate,
            allDay: e.isAllDay,
            location: e.location,
            colorHex: e.colorHex,
          ),
    ];
  }

  @override
  Future<void> openEvent(String instanceId) => _cal.showEventModal(instanceId);
}
