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
