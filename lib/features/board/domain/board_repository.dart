import 'board_models.dart';

/// Proje board'u (sütun, kart, checklist, etiket) için sözleşme.
/// Agregat kökü projedir; tüm yazımlar kartın/sütunun projesini korur.
abstract interface class BoardRepository {
  Stream<BoardData> watchBoard(String projectId);
  Stream<CardDetail?> watchCard(String cardId);

  /// Açık projelerdeki, son tarihi olan ve tamamlanmamış kartlar (en yakın tarih önce).
  Stream<List<UpcomingCard>> watchUpcomingCards({int limit = 8});

  // Sütunlar
  Future<String> addColumn(String projectId, String name);
  Future<void> updateColumn(String columnId, ColumnPatch patch);
  Future<void> moveColumn(String columnId, {String? beforeColumnId});
  Future<void> deleteColumn(String columnId);

  // Kartlar
  /// [initial] ile son tarih, öncelik, sorumlu, tekrar baştan verilebilir.
  Future<String> addCard(
    String columnId,
    String title, {
    CardPatch initial = const CardPatch(),
  });

  /// Kartı projenin tamamlanma sütununa taşır (tekrarlıysa sonraki tekrar oluşur).
  Future<void> completeCard(String cardId);

  /// Tamamlanmış kartı ilk açık sütunun sonuna geri taşır.
  Future<void> reopenCard(String cardId);
  Future<void> updateCard(String cardId, CardPatch patch);

  /// [beforeCardId] null ise hedef sütunun sonuna taşır.
  Future<void> moveCard(
    String cardId,
    String toColumnId, {
    String? beforeCardId,
  });
  Future<void> deleteCard(String cardId);

  // Etiketler
  Future<Label> createLabel(String projectId, String name, String colorHex);
  Future<void> updateLabel(String labelId, String name, String colorHex);
  Future<void> deleteLabel(String labelId);
  Future<void> setCardLabel(
    String cardId,
    String labelId, {
    required bool enabled,
  });

  // Checklist
  Future<void> addChecklistItem(String cardId, String title);
  Future<void> setChecklistItemDone(String itemId, {required bool done});
  Future<void> renameChecklistItem(String itemId, String title);
  Future<void> moveChecklistItem(String itemId, {String? beforeItemId});
  Future<void> deleteChecklistItem(String itemId);
}
