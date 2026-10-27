import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/semantic_colors.dart';

class LiquidNavItem {
  const LiquidNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Sekmenin bağlamsal eylemi (menünün yanındaki yuvarlak cam düğme).
class LiquidNavAction {
  const LiquidNavAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
}

/// Liquid cam alt menü: buzlu cam kapsül, sekmeler arasında akan cam "damla"
/// ve menüyle aynı hizada duran bağlamsal eylem düğmesi.
class LiquidNavBar extends StatelessWidget {
  const LiquidNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.action,
  });

  final List<LiquidNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// null ise eylem düğmesi yumuşakça gizlenir.
  final LiquidNavAction? action;

  static const height = 62.0;
  static const actionSize = 56.0;
  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: _GlassCapsule(
                child: _Tabs(
                  items: items,
                  selectedIndex: selectedIndex,
                  onSelected: onSelected,
                ),
              ),
            ),
            // Eylem varken menü daralır, düğme yerine akar.
            AnimatedContainer(
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
              width: action == null ? 0 : actionSize + _gap,
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                switchInCurve: Curves.easeOutBack,
                transitionBuilder: (child, a) => ScaleTransition(
                  scale: a,
                  child: FadeTransition(opacity: a, child: child),
                ),
                child: action == null
                    ? const SizedBox.shrink()
                    : _ActionButton(
                        key: ValueKey(action!.icon),
                        action: action!,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Buzlu cam kapsül zemin.
class _GlassCapsule extends StatelessWidget {
  const _GlassCapsule({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = context.semantic;
    final dark = Theme.of(context).brightness == Brightness.dark;
    const radius = BorderRadius.all(Radius.circular(LiquidNavBar.height / 2));
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: s.glassShadow,
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: s.glassBorder),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  s.glassTint.withValues(alpha: dark ? 0.62 : 0.62),
                  s.glassTint.withValues(alpha: dark ? 0.42 : 0.38),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Tabs extends StatefulWidget {
  const _Tabs({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<LiquidNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  )..value = 1;
  late double _from = widget.selectedIndex.toDouble();
  late double _to = widget.selectedIndex.toDouble();

  @override
  void didUpdateWidget(_Tabs old) {
    super.didUpdateWidget(old);
    if (old.selectedIndex != widget.selectedIndex) {
      // Animasyonun o anki konumundan yeni hedefe akar (hızlı art arda dokunuşta zıplamaz).
      _from = _position;
      _to = widget.selectedIndex.toDouble();
      _c.forward(from: 0);
    }
  }

  double get _position {
    final t = Curves.easeOutBack.transform(_c.value);
    return lerpDouble(_from, _to, t)!;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.items.length;
    return LayoutBuilder(
      builder: (context, constraints) {
        final tabW = constraints.maxWidth / n;
        return Stack(
          children: [
            AnimatedBuilder(
              animation: _c,
              builder: (context, _) {
                // Damla yolun ortasında uzar, varınca toplanır: sıvı hissi.
                final travel = (_to - _from).abs().clamp(0, 2);
                final stretch = math.sin(math.pi * _c.value) * 0.28 * travel;
                final w = tabW - 4 + tabW * stretch;
                final center = (_position + 0.5) * tabW;
                return Positioned(
                  left: (center - w / 2).clamp(
                    4.0,
                    constraints.maxWidth - w - 4,
                  ),
                  width: w,
                  top: 5,
                  bottom: 5,
                  child: const _Droplet(),
                );
              },
            ),
            Row(
              children: [
                for (var i = 0; i < n; i++)
                  Expanded(
                    child: _TabButton(
                      item: widget.items[i],
                      selected: i == widget.selectedIndex,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        widget.onSelected(i);
                      },
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Seçili sekmenin arkasındaki cam damla.
class _Droplet extends StatelessWidget {
  const _Droplet();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = context.semantic;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LiquidNavBar.height / 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: dark ? 0.30 : 0.22),
            scheme.primary.withValues(alpha: dark ? 0.14 : 0.10),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: dark ? 0.16 : 0.75),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: dark ? 0.25 : 0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Üst kenarda ince parlama.
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LiquidNavBar.height / 2),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [s.glassHighlight, s.glassHighlight.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final LiquidNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: selected ? 1.12 : 1,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutBack,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  selected ? item.selectedIcon : item.icon,
                  key: ValueKey(selected),
                  size: 23,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: theme.textTheme.labelSmall!.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 10.5,
              ),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menüyle aynı yükseklikte, renkli cam yuvarlak eylem düğmesi.
class _ActionButton extends StatefulWidget {
  const _ActionButton({super.key, required this.action});

  final LiquidNavAction action;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    const size = LiquidNavBar.actionSize;
    return Tooltip(
      message: widget.action.tooltip,
      child: Semantics(
        button: true,
        label: widget.action.tooltip,
        excludeSemantics: true,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          onTap: () {
            HapticFeedback.lightImpact();
            widget.action.onPressed();
          },
          child: AnimatedScale(
            scale: _pressed ? 0.9 : 1,
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOut,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (dark ? scheme.primary : const Color(0xFF7FA61A))
                        .withValues(alpha: 0.35),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(
                          alpha: dark ? 0.22 : 0.7,
                        ),
                        width: 1.2,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // Açık temada sarımtırak lime cam, koyu temada parlak lime.
                        colors: dark
                            ? [
                                scheme.primary.withValues(alpha: 0.9),
                                scheme.primary.withValues(alpha: 0.68),
                              ]
                            : [
                                scheme.primaryContainer.withValues(alpha: 0.95),
                                const Color(0xFFB5D334).withValues(alpha: 0.88),
                              ],
                      ),
                    ),
                    child: DecoratedBox(
                      // Cam parlaması
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: const Alignment(-0.4, -0.6),
                          radius: 0.9,
                          colors: [
                            Colors.white.withValues(alpha: dark ? 0.18 : 0.35),
                            Colors.white.withValues(alpha: 0),
                          ],
                        ),
                      ),
                      child: Icon(
                        widget.action.icon,
                        color: dark ? scheme.onPrimary : scheme.onPrimaryContainer,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
