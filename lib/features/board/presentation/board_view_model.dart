import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/board_providers.dart';
import '../domain/board_models.dart';

part 'board_view_model.g.dart';

/// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
/// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.
@riverpod
class BoardViewModel extends _$BoardViewModel {
  @override
  Stream<BoardData> build(String projectId) =>
      ref.watch(boardRepositoryProvider).watchBoard(projectId);

  Future<void> moveCard(
    String cardId,
    String toColumnId, {
    String? beforeCardId,
  }) async {
    if (cardId == beforeCardId) return;
    final current = state.value;
    if (current != null) {
      state = AsyncData(
        current.moveCard(cardId, toColumnId, beforeCardId: beforeCardId),
      );
    }
    try {
      await ref
          .read(boardRepositoryProvider)
          .moveCard(cardId, toColumnId, beforeCardId: beforeCardId);
    } catch (_) {
      // Başarısızsa önceki duruma dön; hata UI'a iletilir.
      if (ref.mounted && current != null) state = AsyncData(current);
      rethrow;
    }
  }

  Future<String> addCard(String columnId, String title) =>
      ref.read(boardRepositoryProvider).addCard(columnId, title);

  Future<String> addColumn(String name) =>
      ref.read(boardRepositoryProvider).addColumn(projectId, name);

  Future<void> updateColumn(String columnId, ColumnPatch patch) =>
      ref.read(boardRepositoryProvider).updateColumn(columnId, patch);

  Future<void> deleteColumn(String columnId) =>
      ref.read(boardRepositoryProvider).deleteColumn(columnId);

  /// Sütunu bir sola/sağa kaydırır ([delta] = -1 / +1).
  Future<void> shiftColumn(String columnId, int delta) async {
    final lanes = state.value?.lanes;
    if (lanes == null) return;
    final ids = [for (final l in lanes) l.column.id];
    final i = ids.indexOf(columnId);
    final target = i + delta;
    if (i < 0 || target < 0 || target >= ids.length) return;
    // Sağa: hedefin bir sonrakinin önüne; sola: hedefin önüne.
    final String? beforeId = delta > 0
        ? (target + 1 < ids.length ? ids[target + 1] : null)
        : ids[target];
    await ref
        .read(boardRepositoryProvider)
        .moveColumn(columnId, beforeColumnId: beforeId);
  }

  Future<Label> createLabel(String name, String colorHex) =>
      ref.read(boardRepositoryProvider).createLabel(projectId, name, colorHex);

  Future<void> updateLabel(String id, String name, String colorHex) =>
      ref.read(boardRepositoryProvider).updateLabel(id, name, colorHex);

  Future<void> deleteLabel(String id) =>
      ref.read(boardRepositoryProvider).deleteLabel(id);
}
