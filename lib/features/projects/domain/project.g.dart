// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority:
      $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
      Priority.medium,
  status:
      $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
      ProjectStatus.backlog,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  responsiblePersonId: json['responsiblePersonId'] as String?,
  details: json['details'] as String?,
  position: (json['position'] as num?)?.toDouble() ?? 0,
  isInbox: json['isInbox'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'priority': _$PriorityEnumMap[instance.priority]!,
  'status': _$ProjectStatusEnumMap[instance.status]!,
  'startDate': instance.startDate?.toIso8601String(),
  'dueDate': instance.dueDate?.toIso8601String(),
  'responsiblePersonId': instance.responsiblePersonId,
  'details': instance.details,
  'position': instance.position,
  'isInbox': instance.isInbox,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
  Priority.critical: 'critical',
};

const _$ProjectStatusEnumMap = {
  ProjectStatus.backlog: 'backlog',
  ProjectStatus.planned: 'planned',
  ProjectStatus.inProgress: 'inProgress',
  ProjectStatus.onHold: 'onHold',
  ProjectStatus.done: 'done',
  ProjectStatus.cancelled: 'cancelled',
};
