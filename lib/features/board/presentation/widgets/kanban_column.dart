import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/color_schemes.dart';
import '../../../../core/theme/glass.dart';
import '../../domain/board_models.dart';
import 'kanban_card_tile.dart';

/// Sürükleme olayları, board seviyesinde otomatik yatay kaydırma için.
class DragCallbacks {
  const DragCallbacks({
    required this.onStart,
    required this.onUpdate,
    required this.onEnd,
  });

  final VoidCallback onStart;
  final ValueChanged<Offset> onUpdate;
  final VoidCallback onEnd;
}

enum ColumnAction { settings, moveLeft, moveRight, delete }

class KanbanColumn extends StatefulWidget {
  const KanbanColumn({
    super.key,
    required this.lane,
    required this.isFirst,
    required this.isLast,
    required this.drag,
    required this.onMoveCard,
    required this.onAddCard,
    required this.onOpenCard,
    required this.onAction,
  });

  final BoardLane lane;
  final bool isFirst;
  final bool isLast;
  final DragCallbacks drag;

  /// (cardId, beforeCardId) — before null ise sona.
  final void Function(String cardId, String? beforeCardId) onMoveCard;
  final Future<void> Function(String title) onAddCard;
  final ValueChanged<String> onOpenCard;
  final ValueChanged<ColumnAction> onAction;

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  bool _adding = false;
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _adding = false);
      return;
    }
    _controller.clear();
    await widget.onAddCard(text);
    _focus.requestFocus(); // Arka arkaya hızlı ekleme.
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final lane = widget.lane;
    final column = lane.column;
    final color = colorFromHex(
      column.colorHex,
      fallback: theme.colorScheme.primary,
    );

    return GlassSurface(
      tint: column.colorHex == null ? null : color,
      borderRadius: BorderRadius.circular(26),
      child: Column(
        children: [
          _Header(
            lane: lane,
            color: color,
            isFirst: widget.isFirst,
            isLast: widget.isLast,
            onAction: widget.onAction,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              children: [
                for (final item in lane.cards)
                  _DraggableCard(
                    key: ValueKey(item.card.id),
                    item: item,
                    drag: widget.drag,
                    onDropBefore: (id) => widget.onMoveCard(id, item.card.id),
                    onTap: () => widget.onOpenCard(item.card.id),
                  ),
                _EndDropZone(
                  isEmpty: lane.cards.isEmpty,
                  onDrop: (id) => widget.onMoveCard(id, null),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _adding
                  ? TextField(
                      key: const ValueKey('field'),
                      controller: _controller,
                      focusNode: _focus,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      onTapOutside: (_) {
                        if (_controller.text.trim().isEmpty) {
                          setState(() => _adding = false);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: l.boardCardTitleHint,
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send_rounded),
                          onPressed: _submit,
                        ),
                      ),
                    )
                  : SizedBox(
                      key: const ValueKey('button'),
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () => setState(() => _adding = true),
                        icon: const Icon(Icons.add_rounded),
                        label: Text(l.boardAddCard),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.lane,
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.onAction,
  });

  final BoardLane lane;
  final Color color;
  final bool isFirst;
  final bool isLast;
  final ValueChanged<ColumnAction> onAction;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final column = lane.column;
    final over = lane.isOverWip;
    final count = column.wipLimit == null
        ? '${lane.cards.length}'
        : '${lane.cards.length}/${column.wipLimit}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 4, 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              column.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (column.isDoneColumn)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(Icons.verified_rounded, size: 18, color: color),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: (over ? theme.colorScheme.error : color).withValues(
                alpha: 0.16,
              ),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              count,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: over ? theme.colorScheme.error : null,
              ),
            ),
          ),
          PopupMenuButton<ColumnAction>(
            onSelected: onAction,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: ColumnAction.settings,
                child: ListTile(
                  leading: const Icon(Icons.tune_rounded),
                  title: Text(l.columnSettings),
                ),
              ),
              if (!isFirst)
                PopupMenuItem(
                  value: ColumnAction.moveLeft,
                  child: ListTile(
                    leading: const Icon(Icons.arrow_back_rounded),
                    title: Text(l.columnMoveLeft),
                  ),
                ),
              if (!isLast)
                PopupMenuItem(
                  value: ColumnAction.moveRight,
                  child: ListTile(
                    leading: const Icon(Icons.arrow_forward_rounded),
                    title: Text(l.columnMoveRight),
                  ),
                ),
              PopupMenuItem(
                value: ColumnAction.delete,
                child: ListTile(
                  leading: const Icon(Icons.delete_outline_rounded),
                  title: Text(l.commonDelete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Uzun basınca sürüklenen kart; üstüne bırakılan kart bunun ÖNÜNE yerleşir.
class _DraggableCard extends StatelessWidget {
  const _DraggableCard({
    super.key,
    required this.item,
    required this.drag,
    required this.onDropBefore,
    required this.onTap,
  });

  final BoardCard item;
  final DragCallbacks drag;
  final ValueChanged<String> onDropBefore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DragTarget<String>(
      onWillAcceptWithDetails: (d) => d.data != item.card.id,
      onAcceptWithDetails: (d) => onDropBefore(d.data),
      builder: (context, candidates, _) {
        final hovering = candidates.isNotEmpty;
        return Column(
          children: [
            // Bırakma yeri göstergesi
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              height: hovering ? 54 : 0,
              margin: EdgeInsets.only(bottom: hovering ? 8 : 0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(
                    alpha: hovering ? 0.6 : 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: LayoutBuilder(
                builder: (context, constraints) => LongPressDraggable<String>(
                  data: item.card.id,
                  delay: const Duration(milliseconds: 220),
                  hapticFeedbackOnStart: true,
                  onDragStarted: () {
                    HapticFeedback.mediumImpact();
                    drag.onStart();
                  },
                  onDragUpdate: (d) => drag.onUpdate(d.globalPosition),
                  onDragEnd: (_) => drag.onEnd(),
                  onDraggableCanceled: (_, _) => drag.onEnd(),
                  feedback: SizedBox(
                    width: constraints.maxWidth,
                    child: Transform.rotate(
                      angle: 0.035,
                      child: Transform.scale(
                        scale: 1.04,
                        child: Material(
                          type: MaterialType.transparency,
                          child: KanbanCardTile(item: item, elevated: true),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.25,
                    child: KanbanCardTile(item: item),
                  ),
                  child: KanbanCardTile(item: item, onTap: onTap),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EndDropZone extends StatelessWidget {
  const _EndDropZone({required this.isEmpty, required this.onDrop});

  final bool isEmpty;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DragTarget<String>(
      onAcceptWithDetails: (d) => onDrop(d.data),
      builder: (context, candidates, _) {
        final hovering = candidates.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: isEmpty ? 120 : 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hovering
                ? theme.colorScheme.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (hovering || isEmpty)
                  ? theme.colorScheme.primary.withValues(
                      alpha: hovering ? 0.6 : 0.2,
                    )
                  : Colors.transparent,
            ),
          ),
          child: (hovering || isEmpty)
              ? Text(
                  context.l10n.boardEmptyColumn,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
        );
      },
    );
  }
}
