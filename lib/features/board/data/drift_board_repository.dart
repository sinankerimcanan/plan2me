import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/enums.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/ids.dart';
import '../../../core/utils/positioning.dart';
import '../domain/board_models.dart';
import '../domain/board_repository.dart';

BoardColumn columnFromRow(BoardColumnRow r) => BoardColumn(
  id: r.id,
  projectId: r.projectId,
  name: r.name,
  position: r.position,
  colorHex: r.colorHex,
  wipLimit: r.wipLimit,
  isDoneColumn: r.isDoneColumn,
);

KanbanCard cardFromRow(CardRow r) => KanbanCard(
  id: r.id,
  projectId: r.projectId,
  columnId: r.columnId,
  title: r.title,
  description: r.description,
  priority: r.priority,
  dueDate: r.dueDate,
  position: r.position,
  completedAt: r.completedAt,
  createdAt: r.createdAt,
  updatedAt: r.updatedAt,
);

ChecklistItem checklistFromRow(ChecklistItemRow r) => ChecklistItem(
  id: r.id,
  cardId: r.cardId,
  title: r.title,
  isDone: r.isDone,
  position: r.position,
);

Label labelFromRow(LabelRow r) =>
    Label(id: r.id, projectId: r.projectId, name: r.name, colorHex: r.colorHex);

class BoardRuleException implements Exception {
  BoardRuleException(this.message);
  final String message;
  @override
  String toString() => 'BoardRuleException: $message';
}

class DriftBoardRepository implements BoardRepository {
  DriftBoardRepository(this._db, {this._clock = systemClock});

  final AppDatabase _db;
  final Clock _clock;

  List<TableInfo<Table, Object?>> get _boardTables => [
    _db.boardColumns,
    _db.cards,
    _db.labels,
    _db.cardLabels,
    _db.checklistItems,
  ];

  // ---------------------------------------------------------------- okuma

  @override
  Stream<BoardData> watchBoard(String projectId) =>
      _db.watchTables(_boardTables, () => _loadBoard(projectId));

  Future<BoardData> _loadBoard(String projectId) async {
    final columns =
        await (_db.select(_db.boardColumns)
              ..where(
                (t) => t.projectId.equals(projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final cards =
        await (_db.select(_db.cards)
              ..where(
                (t) => t.projectId.equals(projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final labels =
        (await (_db.select(_db.labels)
                  ..where(
                    (t) => t.projectId.equals(projectId) & t.deletedAt.isNull(),
                  )
                  ..orderBy([(t) => OrderingTerm.asc(t.name)]))
                .get())
            .map(labelFromRow)
            .toList();
    final labelById = {for (final l in labels) l.id: l};

    final cardIds = [for (final c in cards) c.id];
    final cardLabels = <String, List<Label>>{};
    if (cardIds.isNotEmpty) {
      final links = await (_db.select(
        _db.cardLabels,
      )..where((t) => t.cardId.isIn(cardIds) & t.deletedAt.isNull())).get();
      for (final link in links) {
        final label = labelById[link.labelId];
        if (label != null) (cardLabels[link.cardId] ??= []).add(label);
      }
    }

    final checklist = <String, (int, int)>{};
    final rows = await _db
        .customSelect(
          'SELECT ci.card_id AS card_id, COUNT(*) AS total, '
          'SUM(CASE WHEN ci.is_done THEN 1 ELSE 0 END) AS done '
          'FROM checklist_items ci JOIN cards c ON c.id = ci.card_id '
          'WHERE ci.deleted_at IS NULL AND c.deleted_at IS NULL '
          'AND c.project_id = ? GROUP BY ci.card_id',
          variables: [Variable<String>(projectId)],
          readsFrom: {_db.checklistItems, _db.cards},
        )
        .get();
    for (final r in rows) {
      checklist[r.read<String>('card_id')] = (
        r.read<int>('total'),
        r.read<int>('done'),
      );
    }

    final byColumn = <String, List<BoardCard>>{};
    for (final c in cards) {
      (byColumn[c.columnId] ??= []).add(
        BoardCard(
          card: cardFromRow(c),
          labels: cardLabels[c.id] ?? const [],
          checklistTotal: checklist[c.id]?.$1 ?? 0,
          checklistDone: checklist[c.id]?.$2 ?? 0,
        ),
      );
    }

    return BoardData(
      projectId: projectId,
      labels: labels,
      lanes: [
        for (final col in columns)
          BoardLane(
            column: columnFromRow(col),
            cards: byColumn[col.id] ?? const [],
          ),
      ],
    );
  }

  @override
  Stream<CardDetail?> watchCard(String cardId) =>
      _db.watchTables(_boardTables, () => _loadCard(cardId));

  Future<CardDetail?> _loadCard(String cardId) async {
    final row = await _aliveCard(cardId);
    if (row == null) return null;
    final columns =
        await (_db.select(_db.boardColumns)
              ..where(
                (t) => t.projectId.equals(row.projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final checklist =
        await (_db.select(_db.checklistItems)
              ..where((t) => t.cardId.equals(cardId) & t.deletedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final labels =
        await (_db.select(_db.labels)
              ..where(
                (t) => t.projectId.equals(row.projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.name)]))
            .get();
    final links = await (_db.select(
      _db.cardLabels,
    )..where((t) => t.cardId.equals(cardId) & t.deletedAt.isNull())).get();

    return CardDetail(
      card: cardFromRow(row),
      columns: columns.map(columnFromRow).toList(),
      checklist: checklist.map(checklistFromRow).toList(),
      projectLabels: labels.map(labelFromRow).toList(),
      labelIds: {for (final l in links) l.labelId},
    );
  }

  Future<CardRow?> _aliveCard(String id) => (_db.select(
    _db.cards,
  )..where((t) => t.id.equals(id) & t.deletedAt.isNull())).getSingleOrNull();

  Future<BoardColumnRow> _aliveColumn(String id) async {
    final row = await (_db.select(
      _db.boardColumns,
    )..where((t) => t.id.equals(id) & t.deletedAt.isNull())).getSingleOrNull();
    if (row == null) throw BoardRuleException('Sütun bulunamadı: $id');
    return row;
  }

  // ---------------------------------------------------------------- sütunlar

  @override
  Future<String> addColumn(String projectId, String name) =>
      _db.transaction(() async {
        final now = _clock();
        final id = newId();
        final positions = await _columnSiblings(projectId);
        await _db
            .into(_db.boardColumns)
            .insert(
              BoardColumnsCompanion.insert(
                id: id,
                createdAt: now,
                updatedAt: now,
                projectId: projectId,
                name: name.trim(),
                position: positionAtEnd(positions.map((s) => s.position)),
              ),
            );
        return id;
      });

  @override
  Future<void> updateColumn(String columnId, ColumnPatch patch) =>
      _db.transaction(() async {
        final now = _clock();
        final before = await _aliveColumn(columnId);
        await (_db.update(
          _db.boardColumns,
        )..where((t) => t.id.equals(columnId))).write(
          BoardColumnsCompanion(
            name: Value(patch.name.trim()),
            colorHex: Value(patch.colorHex),
            wipLimit: Value(patch.wipLimit),
            isDoneColumn: Value(patch.isDoneColumn),
            updatedAt: Value(now),
          ),
        );
        await _db.bumpVersion(_db.boardColumns, columnId);

        // "Tamamlandı" işareti değiştiyse içindeki kartların durumu da değişir.
        if (before.isDoneColumn != patch.isDoneColumn) {
          final cards =
              await (_db.select(_db.cards)..where(
                    (t) => t.columnId.equals(columnId) & t.deletedAt.isNull(),
                  ))
                  .get();
          for (final c in cards) {
            final completedAt = patch.isDoneColumn
                ? (c.completedAt ?? now)
                : null;
            if (completedAt == c.completedAt) continue;
            await _writeCard(
              c.id,
              CardsCompanion(completedAt: Value(completedAt)),
              now,
            );
          }
        }
      });

  @override
  Future<void> moveColumn(String columnId, {String? beforeColumnId}) =>
      _db.transaction(() async {
        final col = await _aliveColumn(columnId);
        final siblings = [
          for (final s in await _columnSiblings(col.projectId))
            if (s.id != columnId) s,
        ];
        final now = _clock();
        await _setColumnPosition(
          columnId,
          positionBefore(siblings, beforeColumnId),
          now,
        );
        final all = await _columnSiblings(col.projectId);
        if (needsRenormalize([for (final s in all) s.position])) {
          final fresh = renormalized(all.length);
          for (var i = 0; i < all.length; i++) {
            await _setColumnPosition(all[i].id, fresh[i], now);
          }
        }
      });

  @override
  Future<void> deleteColumn(String columnId) => _db.transaction(() async {
    final now = _clock();
    final arg = [Variable<String>(columnId)];
    const cardsOfColumn =
        'card_id IN (SELECT id FROM cards WHERE column_id = ?)';
    await _db.softDeleteWhere(_db.checklistItems, cardsOfColumn, arg, now);
    await _db.softDeleteWhere(_db.cardLabels, cardsOfColumn, arg, now);
    await _db.softDeleteWhere(_db.cards, 'column_id = ?', arg, now);
    await _db.softDeleteWhere(_db.boardColumns, 'id = ?', arg, now);
  });

  Future<List<Ordered>> _columnSiblings(String projectId) async => [
    for (final r
        in await (_db.select(_db.boardColumns)
              ..where(
                (t) => t.projectId.equals(projectId) & t.deletedAt.isNull(),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get())
      (id: r.id, position: r.position),
  ];

  Future<void> _setColumnPosition(String id, double pos, DateTime now) async {
    await (_db.update(_db.boardColumns)..where((t) => t.id.equals(id))).write(
      BoardColumnsCompanion(position: Value(pos), updatedAt: Value(now)),
    );
    await _db.bumpVersion(_db.boardColumns, id);
  }

  // ---------------------------------------------------------------- kartlar

  @override
  Future<String> addCard(String columnId, String title) =>
      _db.transaction(() async {
        final now = _clock();
        final col = await _aliveColumn(columnId);
        final siblings = await _cardSiblings(columnId);
        final id = newId();
        await _db
            .into(_db.cards)
            .insert(
              CardsCompanion.insert(
                id: id,
                createdAt: now,
                updatedAt: now,
                columnId: columnId,
                projectId: col.projectId,
                title: title.trim(),
                priority: Priority.medium,
                position: positionAtEnd(siblings.map((s) => s.position)),
                completedAt: Value(col.isDoneColumn ? now : null),
              ),
            );
        return id;
      });

  @override
  Future<void> updateCard(String cardId, CardPatch patch) =>
      _db.transaction(() async {
        await _writeCard(
          cardId,
          CardsCompanion(
            title: patch.title == null
                ? const Value.absent()
                : Value(patch.title!.trim()),
            description: patch.description == null
                ? const Value.absent()
                : Value(_blankToNull(patch.description)),
            priority: patch.priority == null
                ? const Value.absent()
                : Value(patch.priority!),
            dueDate: patch.clearDueDate
                ? const Value(null)
                : (patch.dueDate == null
                      ? const Value.absent()
                      : Value(patch.dueDate)),
          ),
          _clock(),
        );
      });

  @override
  Future<void> moveCard(
    String cardId,
    String toColumnId, {
    String? beforeCardId,
  }) => _db.transaction(() async {
    final now = _clock();
    final card = await _aliveCard(cardId);
    if (card == null) throw BoardRuleException('Kart bulunamadı: $cardId');
    final target = await _aliveColumn(toColumnId);
    if (target.projectId != card.projectId) {
      throw BoardRuleException('Kart başka bir projenin sütununa taşınamaz.');
    }

    final siblings = [
      for (final s in await _cardSiblings(toColumnId))
        if (s.id != cardId) s,
    ];
    final completedAt = target.isDoneColumn ? (card.completedAt ?? now) : null;
    await _writeCard(
      cardId,
      CardsCompanion(
        columnId: Value(toColumnId),
        position: Value(positionBefore(siblings, beforeCardId)),
        completedAt: Value(completedAt),
      ),
      now,
    );

    final all = await _cardSiblings(toColumnId);
    if (needsRenormalize([for (final s in all) s.position])) {
      final fresh = renormalized(all.length);
      for (var i = 0; i < all.length; i++) {
        await _writeCard(
          all[i].id,
          CardsCompanion(position: Value(fresh[i])),
          now,
        );
      }
    }
  });

  @override
  Future<void> deleteCard(String cardId) => _db.transaction(() async {
    final now = _clock();
    final arg = [Variable<String>(cardId)];
    await _db.softDeleteWhere(_db.checklistItems, 'card_id = ?', arg, now);
    await _db.softDeleteWhere(_db.cardLabels, 'card_id = ?', arg, now);
    await _db.softDeleteWhere(_db.cards, 'id = ?', arg, now);
  });

  Future<List<Ordered>> _cardSiblings(String columnId) async => [
    for (final r
        in await (_db.select(_db.cards)
              ..where((t) => t.columnId.equals(columnId) & t.deletedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get())
      (id: r.id, position: r.position),
  ];

  Future<void> _writeCard(String id, CardsCompanion c, DateTime now) async {
    await (_db.update(
      _db.cards,
    )..where((t) => t.id.equals(id))).write(c.copyWith(updatedAt: Value(now)));
    await _db.bumpVersion(_db.cards, id);
  }

  // ---------------------------------------------------------------- etiketler

  @override
  Future<Label> createLabel(String projectId, String name, String colorHex) =>
      _db.transaction(() async {
        final now = _clock();
        final id = newId();
        await _db
            .into(_db.labels)
            .insert(
              LabelsCompanion.insert(
                id: id,
                createdAt: now,
                updatedAt: now,
                projectId: projectId,
                name: name.trim(),
                colorHex: colorHex,
              ),
            );
        return Label(
          id: id,
          projectId: projectId,
          name: name.trim(),
          colorHex: colorHex,
        );
      });

  @override
  Future<void> updateLabel(String labelId, String name, String colorHex) =>
      _db.transaction(() async {
        await (_db.update(
          _db.labels,
        )..where((t) => t.id.equals(labelId))).write(
          LabelsCompanion(
            name: Value(name.trim()),
            colorHex: Value(colorHex),
            updatedAt: Value(_clock()),
          ),
        );
        await _db.bumpVersion(_db.labels, labelId);
      });

  @override
  Future<void> deleteLabel(String labelId) => _db.transaction(() async {
    final now = _clock();
    final arg = [Variable<String>(labelId)];
    await _db.softDeleteWhere(_db.cardLabels, 'label_id = ?', arg, now);
    await _db.softDeleteWhere(_db.labels, 'id = ?', arg, now);
  });

  @override
  Future<void> setCardLabel(
    String cardId,
    String labelId, {
    required bool enabled,
  }) => _db.transaction(() async {
    final now = _clock();
    final existing =
        await (_db.select(_db.cardLabels)..where(
              (t) => t.cardId.equals(cardId) & t.labelId.equals(labelId),
            ))
            .getSingleOrNull();
    if (enabled) {
      if (existing == null) {
        await _db
            .into(_db.cardLabels)
            .insert(
              CardLabelsCompanion.insert(
                id: newId(),
                createdAt: now,
                updatedAt: now,
                cardId: cardId,
                labelId: labelId,
              ),
            );
      } else if (existing.deletedAt != null) {
        // Tombstone'u dirilt (UNIQUE(card_id, label_id) çakışmasın).
        await (_db.update(
          _db.cardLabels,
        )..where((t) => t.id.equals(existing.id))).write(
          CardLabelsCompanion(
            deletedAt: const Value(null),
            updatedAt: Value(now),
          ),
        );
        await _db.bumpVersion(_db.cardLabels, existing.id);
      }
    } else if (existing != null && existing.deletedAt == null) {
      await _db.softDeleteWhere(_db.cardLabels, 'id = ?', [
        Variable<String>(existing.id),
      ], now);
    }
  });

  // ---------------------------------------------------------------- checklist

  @override
  Future<void> addChecklistItem(String cardId, String title) =>
      _db.transaction(() async {
        final now = _clock();
        final siblings = await _checklistSiblings(cardId);
        await _db
            .into(_db.checklistItems)
            .insert(
              ChecklistItemsCompanion.insert(
                id: newId(),
                createdAt: now,
                updatedAt: now,
                cardId: cardId,
                title: title.trim(),
                position: positionAtEnd(siblings.map((s) => s.position)),
              ),
            );
      });

  @override
  Future<void> setChecklistItemDone(String itemId, {required bool done}) =>
      _writeChecklist(itemId, ChecklistItemsCompanion(isDone: Value(done)));

  @override
  Future<void> renameChecklistItem(String itemId, String title) =>
      _writeChecklist(
        itemId,
        ChecklistItemsCompanion(title: Value(title.trim())),
      );

  @override
  Future<void> moveChecklistItem(String itemId, {String? beforeItemId}) =>
      _db.transaction(() async {
        final item = await (_db.select(
          _db.checklistItems,
        )..where((t) => t.id.equals(itemId))).getSingle();
        final siblings = [
          for (final s in await _checklistSiblings(item.cardId))
            if (s.id != itemId) s,
        ];
        await _writeChecklist(
          itemId,
          ChecklistItemsCompanion(
            position: Value(positionBefore(siblings, beforeItemId)),
          ),
        );
        final all = await _checklistSiblings(item.cardId);
        if (needsRenormalize([for (final s in all) s.position])) {
          final fresh = renormalized(all.length);
          for (var i = 0; i < all.length; i++) {
            await _writeChecklist(
              all[i].id,
              ChecklistItemsCompanion(position: Value(fresh[i])),
            );
          }
        }
      });

  @override
  Future<void> deleteChecklistItem(String itemId) => _db.softDeleteWhere(
    _db.checklistItems,
    'id = ?',
    [Variable<String>(itemId)],
    _clock(),
  );

  Future<List<Ordered>> _checklistSiblings(String cardId) async => [
    for (final r
        in await (_db.select(_db.checklistItems)
              ..where((t) => t.cardId.equals(cardId) & t.deletedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get())
      (id: r.id, position: r.position),
  ];

  Future<void> _writeChecklist(String id, ChecklistItemsCompanion c) =>
      _db.transaction(() async {
        await (_db.update(_db.checklistItems)..where((t) => t.id.equals(id)))
            .write(c.copyWith(updatedAt: Value(_clock())));
        await _db.bumpVersion(_db.checklistItems, id);
      });
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return (t == null || t.isEmpty) ? null : t;
}
