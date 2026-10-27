/// Repository'lere enjekte edilen saat. Testlerde sabit zaman verilebilir.
typedef Clock = DateTime Function();

DateTime systemClock() => DateTime.now().toUtc();

/// Sadece tarih taşıyan alanlar (başlangıç / son tarih) UTC gece yarısı olarak saklanır.
/// Gösterirken `toLocal()` YAPILMAZ; yıl/ay/gün doğrudan okunur.
DateTime dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

/// Bugünün tarihi (yerel takvim günü), [dateOnly] formatında.
DateTime today() {
  final now = DateTime.now();
  return DateTime.utc(now.year, now.month, now.day);
}
