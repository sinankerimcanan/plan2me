import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../people/domain/person.dart';

part 'board_models.freezed.dart';
part 'board_models.g.dart';

@freezed
abstract class BoardColumn with _$BoardColumn {
  const factory BoardColumn({
    required String id,
    required String projectId,
    required String name,
    required double position,
    String? colorHex,
    int? wipLimit,
    @Default(false) bool isDoneColumn,
  }) = _BoardColumn;

  factory BoardColumn.fromJson(Map<String, dynamic> json) =>
      _$BoardColumnFromJson(json);
}

/// Kanban kartı (Material `Card` ile çakışmasın diye KanbanCard).
@freezed
abstract class KanbanCard with _$KanbanCard {
  const KanbanCard._();

  const factory KanbanCard({
    required String id,
    required String projectId,
    required String columnId,
    required String title,
    String? description,
    @Default(Priority.medium) Priority priority,
    DateTime? dueDate,
    required double position,
    DateTime? completedAt,
    String? assigneePersonId,
    Recurrence? recurrence,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _KanbanCard;

  factory KanbanCard.fromJson(Map<String, dynamic> json) =>
      _$KanbanCardFromJson(json);

  bool get isCompleted => completedAt != null;
}

@freezed
abstract class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    required String cardId,
    required String title,
    @Default(false) bool isDone,
    required double position,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}

@freezed
abstract class Label with _$Label {
  const factory Label({
    required String id,
    required String projectId,
    required String name,
    required String colorHex,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}

/// Board üzerinde gösterilen kart: etiketler ve checklist özeti ile.
@freezed
abstract class BoardCard with _$BoardCard {
  const factory BoardCard({
    required KanbanCard card,
    @Default(<Label>[]) List<Label> labels,
    @Default(0) int checklistTotal,
    @Default(0) int checklistDone,
    Person? assignee,
  }) = _BoardCard;
}

@freezed
abstract class BoardLane with _$BoardLane {
  const BoardLane._();

  const factory BoardLane({
    required BoardColumn column,
    @Default(<BoardCard>[]) List<BoardCard> cards,
  }) = _BoardLane;

  bool get isOverWip =>
      column.wipLimit != null && cards.length > column.wipLimit!;
}

@freezed
abstract class BoardData with _$BoardData {
  const BoardData._();

  const factory BoardData({
    required String projectId,
    @Default(<BoardLane>[]) List<BoardLane> lanes,
    @Default(<Label>[]) List<Label> labels,
  }) = _BoardData;

  BoardCard? findCard(String cardId) {
    for (final lane in lanes) {
      for (final c in lane.cards) {
        if (c.card.id == cardId) return c;
      }
    }
    return null;
  }

  /// İyimser (optimistic) güncelleme için kartı yerel olarak taşır.
  /// Kalıcı pozisyonu repository hesaplar; burada sadece sıra önemlidir.
  BoardData moveCard(String cardId, String toColumnId, {String? beforeCardId}) {
    final moving = findCard(cardId);
    if (moving == null) return this;
    final target = lanes.where((l) => l.column.id == toColumnId).firstOrNull;
    if (target == null) return this;

    final isDone = target.column.isDoneColumn;
    final movedCard = moving.copyWith(
      card: moving.card.copyWith(
        columnId: toColumnId,
        completedAt: isDone
            ? (moving.card.completedAt ?? DateTime.now().toUtc())
            : null,
      ),
    );

    return copyWith(
      lanes: [
        for (final lane in lanes)
          () {
            final rest = [
              for (final c in lane.cards)
                if (c.card.id != cardId) c,
            ];
            if (lane.column.id != toColumnId) return lane.copyWith(cards: rest);
            var index = beforeCardId == null
                ? rest.length
                : rest.indexWhere((c) => c.card.id == beforeCardId);
            if (index < 0) index = rest.length;
            return lane.copyWith(cards: [...rest]..insert(index, movedCard));
          }(),
      ],
    );
  }
}

/// Kart detay ekranı verisi.
@freezed
abstract class CardDetail with _$CardDetail {
  const CardDetail._();

  const factory CardDetail({
    required KanbanCard card,
    required List<BoardColumn> columns,
    @Default(<ChecklistItem>[]) List<ChecklistItem> checklist,
    @Default(<Label>[]) List<Label> projectLabels,
    @Default(<String>{}) Set<String> labelIds,
  }) = _CardDetail;

  BoardColumn? get column =>
      columns.where((c) => c.id == card.columnId).firstOrNull;

  int get checklistDone => checklist.where((i) => i.isDone).length;
}

/// Kart düzenleme alanları (null = değiştirme). Tarih temizlemek için [clearDueDate].
@freezed
abstract class CardPatch with _$CardPatch {
  const factory CardPatch({
    String? title,
    String? description,
    Priority? priority,
    DateTime? dueDate,
    @Default(false) bool clearDueDate,
    String? assigneePersonId,
    @Default(false) bool clearAssignee,
    Recurrence? recurrence,
    @Default(false) bool clearRecurrence,
  }) = _CardPatch;
}

@freezed
abstract class ColumnPatch with _$ColumnPatch {
  const factory ColumnPatch({
    required String name,
    String? colorHex,
    int? wipLimit,
    @Default(false) bool isDoneColumn,
  }) = _ColumnPatch;
}

/// Projeler arası, son tarihi olan ve tamamlanmamış kart (ana ekran widget'ı için).
@freezed
abstract class UpcomingCard with _$UpcomingCard {
  const factory UpcomingCard({
    required String cardId,
    required String projectId,
    required String projectTitle,
    required String title,
    required Priority priority,
    required DateTime dueDate,
  }) = _UpcomingCard;
}
