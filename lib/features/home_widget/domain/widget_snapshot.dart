import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_snapshot.freezed.dart';
part 'widget_snapshot.g.dart';

/// iOS ana ekran widget'ına App Group üzerinden aktarılan özet.
/// Swift tarafındaki `Snapshot` (ios/Plan2meWidget) ile birebir eşleşmeli;
/// alan eklerken [kWidgetSnapshotVersion]'ı artırın.
const kWidgetSnapshotVersion = 1;

@freezed
abstract class WidgetSnapshot with _$WidgetSnapshot {
  const factory WidgetSnapshot({
    @Default(kWidgetSnapshotVersion) int v,
    required String generatedAt,
    required WidgetStats stats,

    /// Tüm açık projelerin son tarihleri (yyyy-MM-dd). Widget, gecikmiş ve bu hafta
    /// sayılarını render anında bugüne göre hesaplar (gece yarısı güncel kalır).
    @Default(<String>[]) List<String> activeDueDates,
    @Default(<WidgetProject>[]) List<WidgetProject> projects,
    @Default(<WidgetCard>[]) List<WidgetCard> cards,
  }) = _WidgetSnapshot;

  factory WidgetSnapshot.fromJson(Map<String, dynamic> json) =>
      _$WidgetSnapshotFromJson(json);
}

@freezed
abstract class WidgetStats with _$WidgetStats {
  const factory WidgetStats({
    @Default(0) int active,
    @Default(0) int inProgress,
    @Default(0) int openCards,
    @Default(0) int doneCards,
  }) = _WidgetStats;

  factory WidgetStats.fromJson(Map<String, dynamic> json) =>
      _$WidgetStatsFromJson(json);
}

@freezed
abstract class WidgetProject with _$WidgetProject {
  const factory WidgetProject({
    required String id,
    required String title,
    required String status,
    required String statusLabel,
    required String priority,
    required String priorityLabel,
    required String priorityColor,
    String? due,
    @Default(0) int done,
    @Default(0) int total,
  }) = _WidgetProject;

  factory WidgetProject.fromJson(Map<String, dynamic> json) =>
      _$WidgetProjectFromJson(json);
}

@freezed
abstract class WidgetCard with _$WidgetCard {
  const factory WidgetCard({
    required String id,
    required String projectId,
    required String projectTitle,
    required String title,
    required String priority,
    required String priorityColor,
    required String due,
  }) = _WidgetCard;

  factory WidgetCard.fromJson(Map<String, dynamic> json) =>
      _$WidgetCardFromJson(json);
}
