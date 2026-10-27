import 'dart:ui';

import 'package:flutter/material.dart';

import 'semantic_colors.dart';

/// Cam yüzey. [blur] true ise arkadakini bulanıklaştırır (pahalı: sadece
/// sabit yüzeylerde kullan). false ise "sahte cam": yarı saydam dolgu + kenarlık
/// + parlama, liste öğeleri ve kanban kartları için.
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.blur = false,
    this.sigma = 16,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.padding,
    this.opacity,
    this.tint,
    this.shadow = true,
  });

  final Widget child;
  final bool blur;
  final double sigma;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  /// Dolgu opaklığı; varsayılan blur'da 0.45, sahte camda 0.62 (light).
  final double? opacity;

  /// Dolguyu belirli bir renge çeker (ör. sütun rengi).
  final Color? tint;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final s = context.semantic;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = tint == null
        ? s.glassTint
        : Color.alphaBlend(tint!.withValues(alpha: 0.18), s.glassTint);
    final alpha =
        opacity ?? (blur ? (isDark ? 0.55 : 0.45) : (isDark ? 0.72 : 0.62));

    Widget content = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: s.glassBorder),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            base.withValues(alpha: (alpha + 0.12).clamp(0, 1)),
            base.withValues(alpha: alpha),
          ],
        ),
      ),
      child: DecoratedBox(
        // Üst kenarda ince "sıvı" parlama.
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [s.glassHighlight, s.glassHighlight.withValues(alpha: 0)],
            stops: const [0, 0.6],
          ),
        ),
        child: padding == null
            ? child
            : Padding(padding: padding!, child: child),
      ),
    );

    if (blur) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
            tileMode: TileMode.mirror,
          ),
          child: content,
        ),
      );
    }

    if (!shadow) return content;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: s.glassShadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: content,
    );
  }
}

/// Yumuşak yeşil/sarı lekeli statik arka plan. Cam yüzeylerin "gösterecek
/// bir şeyi" olsun diye. Statik ve RepaintBoundary içinde: maliyeti bir kez ödenir.
class LiquidBackground extends StatelessWidget {
  const LiquidBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final s = context.semantic;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [s.backgroundTop, s.backgroundBottom],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _Blob(
                  color: s.blobs[0],
                  alignment: const Alignment(-1.1, -0.9),
                  size: 1.1,
                ),
                _Blob(
                  color: s.blobs[1],
                  alignment: const Alignment(1.2, -0.2),
                  size: 0.9,
                ),
                _Blob(
                  color: s.blobs[2],
                  alignment: const Alignment(-0.6, 1.1),
                  size: 1.0,
                ),
              ],
            ),
          ),
        ),
        ?child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.alignment,
    required this.size,
  });

  final Color color;
  final Alignment alignment;
  final double size;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).shortestSide * size;
    return Align(
      alignment: alignment,
      child: SizedBox.square(
        dimension: w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.75),
                color.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Liquid arka planlı, cam app bar'lı sayfa iskeleti.
class LiquidScaffold extends StatelessWidget {
  const LiquidScaffold({
    super.key,
    this.title,
    this.actions,
    this.leading,
    required this.body,
    this.floatingActionButton,
    this.showAppBar = true,
    this.bottom,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return LiquidBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: showAppBar
            ? AppBar(
                title: title,
                actions: actions,
                leading: leading,
                bottom: bottom,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                flexibleSpace: const _GlassBarBackground(),
              )
            : null,
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

class _GlassBarBackground extends StatelessWidget {
  const _GlassBarBackground();

  @override
  Widget build(BuildContext context) {
    final s = context.semantic;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: s.glassTint.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.45
                  : 0.35,
            ),
            border: Border(bottom: BorderSide(color: s.glassBorder)),
          ),
        ),
      ),
    );
  }
}

/// Cam app bar'ın altında kalan içerik için üst boşluk.
EdgeInsets liquidBodyPadding(
  BuildContext context, {
  double horizontal = 16,
  double top = 8,
  double bottom = 24,
}) {
  final mq = MediaQuery.paddingOf(context);
  return EdgeInsets.fromLTRB(
    horizontal,
    mq.top + top,
    horizontal,
    mq.bottom + bottom,
  );
}
