import 'package:add_2_calendar/add_2_calendar.dart' as cal;

import '../domain/enums.dart';

/// Telefonun takvim uygulamasına tüm gün etkinliği ekler.
/// Sistem düzenleme ekranı açılır; kullanıcı onaylayınca kaydedilir
/// (uygulama takvimi okumaz, izin yalnızca ekleme içindir).
abstract final class DeviceCalendar {
  static Future<bool> addAllDayEvent({
    required String title,
    required DateTime date,
    String? description,
    Recurrence? recurrence,
  }) {
    final day = DateTime(date.year, date.month, date.day);
    return cal.Add2Calendar.addEvent2Cal(
      cal.Event(
        title: title,
        description: description,
        startDate: day,
        endDate: day.add(const Duration(days: 1)),
        allDay: true,
        iosParams: const cal.IOSParams(
          reminder: Duration(hours: 15),
        ), // önceki gün 09:00
        recurrence: recurrence == null
            ? null
            : cal.Recurrence(frequency: _frequency(recurrence)),
      ),
    );
  }

  static cal.Frequency _frequency(Recurrence r) => switch (r) {
    Recurrence.daily => cal.Frequency.daily,
    Recurrence.weekly => cal.Frequency.weekly,
    Recurrence.monthly => cal.Frequency.monthly,
    Recurrence.yearly => cal.Frequency.yearly,
  };
}
