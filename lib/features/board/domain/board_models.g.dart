// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardColumn _$BoardColumnFromJson(Map<String, dynamic> json) => _BoardColumn(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  name: json['name'] as String,
  position: (json['position'] as num).toDouble(),
  colorHex: json['colorHex'] as String?,
  wipLimit: (json['wipLimit'] as num?)?.toInt(),
  isDoneColumn: json['isDoneColumn'] as bool? ?? false,
);

Map<String, dynamic> _$BoardColumnToJson(_BoardColumn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'name': instance.name,
      'position': instance.position,
      'colorHex': instance.colorHex,
      'wipLimit': instance.wipLimit,
      'isDoneColumn': instance.isDoneColumn,
    };

_KanbanCard _$KanbanCardFromJson(Map<String, dynamic> json) => _KanbanCard(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  columnId: json['columnId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority:
      $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
      Priority.medium,
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  position: (json['position'] as num).toDouble(),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$KanbanCardToJson(_KanbanCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'columnId': instance.columnId,
      'title': instance.title,
      'description': instance.description,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'dueDate': instance.dueDate?.toIso8601String(),
      'position': instance.position,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
  Priority.critical: 'critical',
};

_ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) =>
    _ChecklistItem(
      id: json['id'] as String,
      cardId: json['cardId'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
      position: (json['position'] as num).toDouble(),
    );

Map<String, dynamic> _$ChecklistItemToJson(_ChecklistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'title': instance.title,
      'isDone': instance.isDone,
      'position': instance.position,
    };

_Label _$LabelFromJson(Map<String, dynamic> json) => _Label(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  name: json['name'] as String,
  colorHex: json['colorHex'] as String,
);

Map<String, dynamic> _$LabelToJson(_Label instance) => <String, dynamic>{
  'id': instance.id,
  'projectId': instance.projectId,
  'name': instance.name,
  'colorHex': instance.colorHex,
};
