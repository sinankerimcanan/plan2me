import 'package:flutter/material.dart';

import '../domain/enums.dart';

/// Tema-bağımsız anlamlı renkler + cam (glass) ayarları.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.priorityLow,
    required this.priorityMedium,
    required this.priorityHigh,
    required this.priorityCritical,
    required this.overdue,
    required this.success,
    required this.glassTint,
    required this.glassBorder,
    required this.glassHighlight,
    required this.glassShadow,
    required this.blobs,
    required this.backgroundTop,
    required this.backgroundBottom,
  });

  final Color priorityLow;
  final Color priorityMedium;
  final Color priorityHigh;
  final Color priorityCritical;
  final Color overdue;
  final Color success;
  final Color glassTint;
  final Color glassBorder;
  final Color glassHighlight;
  final Color glassShadow;

  /// "Liquid" arka plan lekeleri (yeşil / sarı / lime).
  final List<Color> blobs;
  final Color backgroundTop;
  final Color backgroundBottom;

  static const light = AppSemanticColors(
    priorityLow: Color(0xFF6A9F2A),
    priorityMedium: Color(0xFFC9A227),
    priorityHigh: Color(0xFFE67E22),
    priorityCritical: Color(0xFFD64541),
    overdue: Color(0xFFD64541),
    success: Color(0xFF4E7A0B),
    glassTint: Color(0xFFFFFFFF),
    glassBorder: Color(0x99FFFFFF),
    glassHighlight: Color(0xB3FFFFFF),
    glassShadow: Color(0x1A4E7A0B),
    blobs: [Color(0xFFD9F07A), Color(0xFFFFE98A), Color(0xFFB9E4A0)],
    backgroundTop: Color(0xFFFAFDF0),
    backgroundBottom: Color(0xFFEFF6DC),
  );

  static const dark = AppSemanticColors(
    priorityLow: Color(0xFF9CCC65),
    priorityMedium: Color(0xFFE9C552),
    priorityHigh: Color(0xFFFFA559),
    priorityCritical: Color(0xFFFF6B66),
    overdue: Color(0xFFFF6B66),
    success: Color(0xFFB8E356),
    glassTint: Color(0xFF263020),
    glassBorder: Color(0x1FFFFFFF),
    glassHighlight: Color(0x14FFFFFF),
    glassShadow: Color(0x66000000),
    blobs: [Color(0xFF3D5A12), Color(0xFF4F4410), Color(0xFF1F4A2C)],
    backgroundTop: Color(0xFF12170F),
    backgroundBottom: Color(0xFF0C0F0A),
  );

  Color priority(Priority p) => switch (p) {
    Priority.low => priorityLow,
    Priority.medium => priorityMedium,
    Priority.high => priorityHigh,
    Priority.critical => priorityCritical,
  };

  Color status(ProjectStatus s, ColorScheme scheme) => switch (s) {
    ProjectStatus.backlog => scheme.outline,
    ProjectStatus.planned => scheme.secondary,
    ProjectStatus.inProgress => scheme.primary,
    ProjectStatus.onHold => priorityMedium,
    ProjectStatus.done => success,
    ProjectStatus.cancelled => scheme.error,
  };

  @override
  AppSemanticColors copyWith() => this;

  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppSemanticColors(
      priorityLow: l(priorityLow, other.priorityLow),
      priorityMedium: l(priorityMedium, other.priorityMedium),
      priorityHigh: l(priorityHigh, other.priorityHigh),
      priorityCritical: l(priorityCritical, other.priorityCritical),
      overdue: l(overdue, other.overdue),
      success: l(success, other.success),
      glassTint: l(glassTint, other.glassTint),
      glassBorder: l(glassBorder, other.glassBorder),
      glassHighlight: l(glassHighlight, other.glassHighlight),
      glassShadow: l(glassShadow, other.glassShadow),
      blobs: [
        for (var i = 0; i < blobs.length; i++) l(blobs[i], other.blobs[i]),
      ],
      backgroundTop: l(backgroundTop, other.backgroundTop),
      backgroundBottom: l(backgroundBottom, other.backgroundBottom),
    );
  }
}

extension SemanticColorsX on BuildContext {
  AppSemanticColors get semantic =>
      Theme.of(this).extension<AppSemanticColors>()!;
}
