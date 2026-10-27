/// Proje ve kart önceliği. Veritabanında `name` olarak (metin) saklanır;
/// bu yüzden mevcut değerlerin adı değiştirilmemeli, yeni değer sona eklenmeli.
enum Priority {
  low,
  medium,
  high,
  critical;

  /// Sıralamada yüksek öncelik önce gelsin diye.
  int get weight => index;
}

/// Jira mantığında proje aşaması.
enum ProjectStatus {
  backlog,
  planned,
  inProgress,
  onHold,
  done,
  cancelled;

  bool get isClosed => this == done || this == cancelled;
}

/// Tekrarlayan görev aralığı. Kart tamamlanınca bir sonraki tekrar oluşturulur.
enum Recurrence {
  daily,
  weekly,
  monthly,
  yearly;

  /// [from] tarihinden bir sonraki tekrar tarihi (ay sonu taşmaları kırpılır).
  DateTime next(DateTime from) {
    switch (this) {
      case Recurrence.daily:
        return DateTime.utc(from.year, from.month, from.day + 1);
      case Recurrence.weekly:
        return DateTime.utc(from.year, from.month, from.day + 7);
      case Recurrence.monthly:
        return _clamped(from.year, from.month + 1, from.day);
      case Recurrence.yearly:
        return _clamped(from.year + 1, from.month, from.day);
    }
  }

  static DateTime _clamped(int year, int month, int day) {
    final lastDay = DateTime.utc(year, month + 1, 0).day;
    return DateTime.utc(year, month, day > lastDay ? lastDay : day);
  }
}
