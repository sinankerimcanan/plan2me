import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/domain/place.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/positioning.dart';
import '../data/board_providers.dart';
import '../domain/board_models.dart';
import '../domain/board_repository.dart';

part 'card_detail_view_model.g.dart';

@riverpod
class CardDetailViewModel extends _$CardDetailViewModel {
  @override
  Stream<CardDetail?> build(String cardId) =>
      ref.watch(boardRepositoryProvider).watchCard(cardId);

  BoardRepository get _repo => ref.read(boardRepositoryProvider);

  Future<void> setTitle(String title) async {
    if (title.trim().isEmpty) return;
    await _repo.updateCard(cardId, CardPatch(title: title));
  }

  Future<void> setDescription(String text) =>
      _repo.updateCard(cardId, CardPatch(description: text));

  Future<void> setPriority(Priority p) =>
      _repo.updateCard(cardId, CardPatch(priority: p));

  Future<void> setDueDate(DateTime? d) => _repo.updateCard(
    cardId,
    d == null
        ? const CardPatch(clearDueDate: true)
        : CardPatch(dueDate: dateOnly(d)),
  );

  Future<void> setAssignee(String? personId) => _repo.updateCard(
    cardId,
    personId == null
        ? const CardPatch(clearAssignee: true)
        : CardPatch(assigneePersonId: personId),
  );

  Future<void> setRecurrence(Recurrence? r) => _repo.updateCard(
    cardId,
    r == null
        ? const CardPatch(clearRecurrence: true)
        : CardPatch(recurrence: r),
  );

  /// Tamamla / yeniden aç; geri alma fonksiyonu döner.
  Future<({bool completed, Future<void> Function() undo})>
  toggleComplete() async {
    final card = state.value?.card;
    if (card == null) return (completed: false, undo: () async {});
    if (card.isCompleted) {
      await _repo.reopenCard(cardId);
      return (completed: false, undo: () => _repo.completeCard(cardId));
    }
    await _repo.completeCard(cardId);
    return (
      completed: true,
      undo: () => _repo.undoComplete(cardId, toColumnId: card.columnId),
    );
  }

  Future<void> setLocation(Place? place) => _repo.updateCard(
    cardId,
    place == null
        ? const CardPatch(clearLocation: true)
        : CardPatch(location: place),
  );

  Future<void> moveToColumn(String columnId) =>
      _repo.moveCard(cardId, columnId);

  Future<void> toggleLabel(String labelId, {required bool enabled}) =>
      _repo.setCardLabel(cardId, labelId, enabled: enabled);

  Future<void> createAndAttachLabel(
    String projectId,
    String name,
    String hex,
  ) async {
    final label = await _repo.createLabel(projectId, name, hex);
    await _repo.setCardLabel(cardId, label.id, enabled: true);
  }

  Future<void> addChecklistItem(String title) async {
    if (title.trim().isEmpty) return;
    await _repo.addChecklistItem(cardId, title);
  }

  Future<void> toggleChecklistItem(String itemId, {required bool done}) =>
      _repo.setChecklistItemDone(itemId, done: done);

  Future<void> renameChecklistItem(String itemId, String title) async {
    if (title.trim().isEmpty) return deleteChecklistItem(itemId);
    await _repo.renameChecklistItem(itemId, title);
  }

  Future<void> deleteChecklistItem(String itemId) =>
      _repo.deleteChecklistItem(itemId);

  Future<void> reorderChecklist(int oldIndex, int newIndex) async {
    final items = state.value?.checklist;
    if (items == null) return;
    final ids = [for (final i in items) i.id];
    final before = beforeIdForReorder(ids, oldIndex, newIndex);
    // İyimser sıra
    final list = [...items];
    final moved = list.removeAt(oldIndex);
    list.insert(newIndex, moved);
    state = AsyncData(state.value!.copyWith(checklist: list));
    await _repo.moveChecklistItem(moved.id, beforeItemId: before);
  }

  Future<void> delete() => _repo.deleteCard(cardId);
}
