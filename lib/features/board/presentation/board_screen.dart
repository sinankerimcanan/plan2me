import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/widgets/common.dart';
import '../../projects/data/projects_providers.dart';
import '../domain/board_models.dart';
import 'board_view_model.dart';
import 'column_settings_sheet.dart';
import 'label_manager_sheet.dart';
import 'widgets/kanban_column.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final title = ref
        .watch(projectOverviewProvider(projectId))
        .value
        ?.project
        .title;
    final board = ref.watch(boardViewModelProvider(projectId));

    Future<void> addColumn() async {
      final name = await promptText(
        context,
        title: l.boardAddColumn,
        label: l.boardColumnName,
      );
      if (name != null && name.trim().isNotEmpty) {
        await ref
            .read(boardViewModelProvider(projectId).notifier)
            .addColumn(name);
      }
    }

    return LiquidScaffold(
      title: Text(title ?? '', overflow: TextOverflow.ellipsis),
      actions: [
        IconButton(
          tooltip: l.labelsManage,
          icon: const Icon(Icons.label_outline_rounded),
          onPressed: () => showLabelManager(context, projectId),
        ),
        IconButton(
          tooltip: l.boardAddColumn,
          icon: const Icon(Icons.view_column_outlined),
          onPressed: addColumn,
        ),
        const SizedBox(width: 4),
      ],
      body: AsyncView(
        value: board,
        data: (data) => _BoardBody(
          projectId: projectId,
          data: data,
          onAddColumn: addColumn,
        ),
      ),
    );
  }
}

class _BoardBody extends ConsumerStatefulWidget {
  const _BoardBody({
    required this.projectId,
    required this.data,
    required this.onAddColumn,
  });

  final String projectId;
  final BoardData data;
  final VoidCallback onAddColumn;

  @override
  ConsumerState<_BoardBody> createState() => _BoardBodyState();
}

class _BoardBodyState extends ConsumerState<_BoardBody> {
  PageController? _pages;
  double? _fraction;
  Timer? _autoScroll;
  double _edgeVelocity = 0;

  static const _edge = 56.0;

  PageController _controllerFor(double width) {
    // Telefonda ~1 sütun + komşunun ucu; geniş ekranda birden çok sütun.
    final fraction = math.min(0.88, 320 / width);
    if (_pages == null || _fraction != fraction) {
      final page = _pages?.hasClients == true ? _pages!.page?.round() ?? 0 : 0;
      _pages?.dispose();
      _pages = PageController(viewportFraction: fraction, initialPage: page);
      _fraction = fraction;
    }
    return _pages!;
  }

  @override
  void dispose() {
    _autoScroll?.cancel();
    _pages?.dispose();
    super.dispose();
  }

  // ------------------------------------------------ sürüklerken kenar kaydırma
  void _onDragStart() {
    _autoScroll?.cancel();
    _autoScroll = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final c = _pages;
      if (_edgeVelocity == 0 || c == null || !c.hasClients) return;
      final pos = c.position;
      final next = (pos.pixels + _edgeVelocity).clamp(
        pos.minScrollExtent,
        pos.maxScrollExtent,
      );
      if (next != pos.pixels) pos.jumpTo(next);
    });
  }

  void _onDragUpdate(Offset global) {
    final width = MediaQuery.sizeOf(context).width;
    if (global.dx < _edge) {
      _edgeVelocity = -14 * (1 - global.dx / _edge).clamp(0.3, 1);
    } else if (global.dx > width - _edge) {
      _edgeVelocity = 14 * (1 - (width - global.dx) / _edge).clamp(0.3, 1);
    } else {
      _edgeVelocity = 0;
    }
  }

  void _onDragEnd() {
    _autoScroll?.cancel();
    _autoScroll = null;
    _edgeVelocity = 0;
    final c = _pages;
    if (c != null && c.hasClients && c.page != null) {
      c.animateToPage(
        c.page!.round(),
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  // ------------------------------------------------ niyetler
  BoardViewModel get _vm =>
      ref.read(boardViewModelProvider(widget.projectId).notifier);

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  Future<void> _onColumnAction(BoardLane lane, ColumnAction action) async {
    final l = context.l10n;
    switch (action) {
      case ColumnAction.settings:
        final patch = await showColumnSettings(context, lane.column);
        if (patch != null) {
          await _guard(() => _vm.updateColumn(lane.column.id, patch));
        }
      case ColumnAction.moveLeft:
        await _guard(() => _vm.shiftColumn(lane.column.id, -1));
      case ColumnAction.moveRight:
        await _guard(() => _vm.shiftColumn(lane.column.id, 1));
      case ColumnAction.delete:
        if (widget.data.lanes.length <= 1) {
          showError(context, l.columnLastWarning);
          return;
        }
        if (await confirmColumnDelete(context, lane)) {
          await _guard(() => _vm.deleteColumn(lane.column.id));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final lanes = widget.data.lanes;
    final mq = MediaQuery.of(context);
    final drag = DragCallbacks(
      onStart: _onDragStart,
      onUpdate: _onDragUpdate,
      onEnd: _onDragEnd,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: mq.padding.top + 8,
        bottom: mq.padding.bottom + 12,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => PageView.builder(
          controller: _controllerFor(constraints.maxWidth),
          padEnds: false,
          itemCount: lanes.length + 1,
          itemBuilder: (context, i) {
            final Widget child;
            if (i == lanes.length) {
              child = _AddColumnTile(
                label: l.boardAddColumn,
                onTap: widget.onAddColumn,
              );
            } else {
              final lane = lanes[i];
              child = KanbanColumn(
                key: ValueKey(lane.column.id),
                lane: lane,
                isFirst: i == 0,
                isLast: i == lanes.length - 1,
                drag: drag,
                onMoveCard: (cardId, before) => _guard(
                  () => _vm.moveCard(
                    cardId,
                    lane.column.id,
                    beforeCardId: before,
                  ),
                ),
                onAddCard: (title) => _guard(
                  () => _vm.addCard(lane.column.id, title).then((_) {}),
                ),
                onOpenCard: (cardId) =>
                    context.push(Routes.card(widget.projectId, cardId)),
                onAction: (a) => _onColumnAction(lane, a),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                left: i == 0 ? 16 : 6,
                right: i == lanes.length ? 16 : 6,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class _AddColumnTile extends StatelessWidget {
  const _AddColumnTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: GlassSurface(
        opacity: 0.35,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(label, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
