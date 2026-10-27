// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WidgetSnapshot _$WidgetSnapshotFromJson(Map<String, dynamic> json) =>
    _WidgetSnapshot(
      v: (json['v'] as num?)?.toInt() ?? kWidgetSnapshotVersion,
      generatedAt: json['generatedAt'] as String,
      stats: WidgetStats.fromJson(json['stats'] as Map<String, dynamic>),
      activeDueDates:
          (json['activeDueDates'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      projects:
          (json['projects'] as List<dynamic>?)
              ?.map((e) => WidgetProject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WidgetProject>[],
      cards:
          (json['cards'] as List<dynamic>?)
              ?.map((e) => WidgetCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WidgetCard>[],
    );

Map<String, dynamic> _$WidgetSnapshotToJson(_WidgetSnapshot instance) =>
    <String, dynamic>{
      'v': instance.v,
      'generatedAt': instance.generatedAt,
      'stats': instance.stats,
      'activeDueDates': instance.activeDueDates,
      'projects': instance.projects,
      'cards': instance.cards,
    };

_WidgetStats _$WidgetStatsFromJson(Map<String, dynamic> json) => _WidgetStats(
  active: (json['active'] as num?)?.toInt() ?? 0,
  inProgress: (json['inProgress'] as num?)?.toInt() ?? 0,
  openCards: (json['openCards'] as num?)?.toInt() ?? 0,
  doneCards: (json['doneCards'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WidgetStatsToJson(_WidgetStats instance) =>
    <String, dynamic>{
      'active': instance.active,
      'inProgress': instance.inProgress,
      'openCards': instance.openCards,
      'doneCards': instance.doneCards,
    };

_WidgetProject _$WidgetProjectFromJson(Map<String, dynamic> json) =>
    _WidgetProject(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      statusLabel: json['statusLabel'] as String,
      priority: json['priority'] as String,
      priorityLabel: json['priorityLabel'] as String,
      priorityColor: json['priorityColor'] as String,
      due: json['due'] as String?,
      done: (json['done'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WidgetProjectToJson(_WidgetProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'statusLabel': instance.statusLabel,
      'priority': instance.priority,
      'priorityLabel': instance.priorityLabel,
      'priorityColor': instance.priorityColor,
      'due': instance.due,
      'done': instance.done,
      'total': instance.total,
    };

_WidgetCard _$WidgetCardFromJson(Map<String, dynamic> json) => _WidgetCard(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  projectTitle: json['projectTitle'] as String,
  title: json['title'] as String,
  priority: json['priority'] as String,
  priorityColor: json['priorityColor'] as String,
  due: json['due'] as String,
);

Map<String, dynamic> _$WidgetCardToJson(_WidgetCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'title': instance.title,
      'priority': instance.priority,
      'priorityColor': instance.priorityColor,
      'due': instance.due,
    };
