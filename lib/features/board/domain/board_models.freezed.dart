// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardColumn {

 String get id; String get projectId; String get name; double get position; String? get colorHex; int? get wipLimit; bool get isDoneColumn;
/// Create a copy of BoardColumn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardColumnCopyWith<BoardColumn> get copyWith => _$BoardColumnCopyWithImpl<BoardColumn>(this as BoardColumn, _$identity);

  /// Serializes this BoardColumn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BoardColumn;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardColumn&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.wipLimit, _this.wipLimit) || other.wipLimit == _this.wipLimit)&&(identical(other.isDoneColumn, _this.isDoneColumn) || other.isDoneColumn == _this.isDoneColumn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BoardColumn;
  return Object.hash(runtimeType,_this.id,_this.projectId,_this.name,_this.position,_this.colorHex,_this.wipLimit,_this.isDoneColumn);
}

@override
String toString() {
  final _this = this as BoardColumn;
  return 'BoardColumn(id: ${_this.id}, projectId: ${_this.projectId}, name: ${_this.name}, position: ${_this.position}, colorHex: ${_this.colorHex}, wipLimit: ${_this.wipLimit}, isDoneColumn: ${_this.isDoneColumn})';
}


}

/// @nodoc
abstract mixin class $BoardColumnCopyWith<$Res>  {
  factory $BoardColumnCopyWith(BoardColumn value, $Res Function(BoardColumn) _then) = _$BoardColumnCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String name, double position, String? colorHex, int? wipLimit, bool isDoneColumn
});




}
/// @nodoc
class _$BoardColumnCopyWithImpl<$Res>
    implements $BoardColumnCopyWith<$Res> {
  _$BoardColumnCopyWithImpl(this._self, this._then);

  final BoardColumn _self;
  final $Res Function(BoardColumn) _then;

/// Create a copy of BoardColumn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? position = null,Object? colorHex = freezed,Object? wipLimit = freezed,Object? isDoneColumn = null,}) {
  return _then(BoardColumn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,wipLimit: freezed == wipLimit ? _self.wipLimit : wipLimit // ignore: cast_nullable_to_non_nullable
as int?,isDoneColumn: null == isDoneColumn ? _self.isDoneColumn : isDoneColumn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardColumn].
extension BoardColumnPatterns on BoardColumn {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardColumn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardColumn() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardColumn value)  $default,){
final _that = this;
switch (_that) {
case _BoardColumn():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardColumn value)?  $default,){
final _that = this;
switch (_that) {
case _BoardColumn() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  double position,  String? colorHex,  int? wipLimit,  bool isDoneColumn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardColumn() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.position,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  double position,  String? colorHex,  int? wipLimit,  bool isDoneColumn)  $default,) {final _that = this;
switch (_that) {
case _BoardColumn():
return $default(_that.id,_that.projectId,_that.name,_that.position,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String name,  double position,  String? colorHex,  int? wipLimit,  bool isDoneColumn)?  $default,) {final _that = this;
switch (_that) {
case _BoardColumn() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.position,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardColumn implements BoardColumn {
  const _BoardColumn({required this.id, required this.projectId, required this.name, required this.position, this.colorHex, this.wipLimit, this.isDoneColumn = false});
  factory _BoardColumn.fromJson(Map<String, dynamic> json) => _$BoardColumnFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String name;
@override final  double position;
@override final  String? colorHex;
@override final  int? wipLimit;
@override@JsonKey() final  bool isDoneColumn;

/// Create a copy of BoardColumn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardColumnCopyWith<_BoardColumn> get copyWith => __$BoardColumnCopyWithImpl<_BoardColumn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardColumnToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardColumn&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.wipLimit, wipLimit) || other.wipLimit == wipLimit)&&(identical(other.isDoneColumn, isDoneColumn) || other.isDoneColumn == isDoneColumn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,projectId,name,position,colorHex,wipLimit,isDoneColumn);
}

@override
String toString() {
    return 'BoardColumn(id: $id, projectId: $projectId, name: $name, position: $position, colorHex: $colorHex, wipLimit: $wipLimit, isDoneColumn: $isDoneColumn)';
}


}

/// @nodoc
abstract mixin class _$BoardColumnCopyWith<$Res> implements $BoardColumnCopyWith<$Res> {
  factory _$BoardColumnCopyWith(_BoardColumn value, $Res Function(_BoardColumn) _then) = __$BoardColumnCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String name, double position, String? colorHex, int? wipLimit, bool isDoneColumn
});




}
/// @nodoc
class __$BoardColumnCopyWithImpl<$Res>
    implements _$BoardColumnCopyWith<$Res> {
  __$BoardColumnCopyWithImpl(this._self, this._then);

  final _BoardColumn _self;
  final $Res Function(_BoardColumn) _then;

/// Create a copy of BoardColumn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? position = null,Object? colorHex = freezed,Object? wipLimit = freezed,Object? isDoneColumn = null,}) {
  return _then(_BoardColumn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,wipLimit: freezed == wipLimit ? _self.wipLimit : wipLimit // ignore: cast_nullable_to_non_nullable
as int?,isDoneColumn: null == isDoneColumn ? _self.isDoneColumn : isDoneColumn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$KanbanCard {

 String get id; String get projectId; String get columnId; String get title; String? get description; Priority get priority; DateTime? get dueDate; double get position; DateTime? get completedAt; String? get assigneePersonId; Recurrence? get recurrence; Place? get location; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<KanbanCard> get copyWith => _$KanbanCardCopyWithImpl<KanbanCard>(this as KanbanCard, _$identity);

  /// Serializes this KanbanCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KanbanCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanbanCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.columnId, _this.columnId) || other.columnId == _this.columnId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.assigneePersonId, _this.assigneePersonId) || other.assigneePersonId == _this.assigneePersonId)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KanbanCard;
  return Object.hash(runtimeType,_this.id,_this.projectId,_this.columnId,_this.title,_this.description,_this.priority,_this.dueDate,_this.position,_this.completedAt,_this.assigneePersonId,_this.recurrence,_this.location,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as KanbanCard;
  return 'KanbanCard(id: ${_this.id}, projectId: ${_this.projectId}, columnId: ${_this.columnId}, title: ${_this.title}, description: ${_this.description}, priority: ${_this.priority}, dueDate: ${_this.dueDate}, position: ${_this.position}, completedAt: ${_this.completedAt}, assigneePersonId: ${_this.assigneePersonId}, recurrence: ${_this.recurrence}, location: ${_this.location}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $KanbanCardCopyWith<$Res>  {
  factory $KanbanCardCopyWith(KanbanCard value, $Res Function(KanbanCard) _then) = _$KanbanCardCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String columnId, String title, String? description, Priority priority, DateTime? dueDate, double position, DateTime? completedAt, String? assigneePersonId, Recurrence? recurrence, Place? location, DateTime createdAt, DateTime updatedAt
});


$PlaceCopyWith<$Res>? get location;

}
/// @nodoc
class _$KanbanCardCopyWithImpl<$Res>
    implements $KanbanCardCopyWith<$Res> {
  _$KanbanCardCopyWithImpl(this._self, this._then);

  final KanbanCard _self;
  final $Res Function(KanbanCard) _then;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? columnId = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? dueDate = freezed,Object? position = null,Object? completedAt = freezed,Object? assigneePersonId = freezed,Object? recurrence = freezed,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(KanbanCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,columnId: null == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assigneePersonId: freezed == assigneePersonId ? _self.assigneePersonId : assigneePersonId // ignore: cast_nullable_to_non_nullable
as String?,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Place?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [KanbanCard].
extension KanbanCardPatterns on KanbanCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanbanCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanbanCard value)  $default,){
final _that = this;
switch (_that) {
case _KanbanCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanbanCard value)?  $default,){
final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String columnId,  String title,  String? description,  Priority priority,  DateTime? dueDate,  double position,  DateTime? completedAt,  String? assigneePersonId,  Recurrence? recurrence,  Place? location,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that.id,_that.projectId,_that.columnId,_that.title,_that.description,_that.priority,_that.dueDate,_that.position,_that.completedAt,_that.assigneePersonId,_that.recurrence,_that.location,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String columnId,  String title,  String? description,  Priority priority,  DateTime? dueDate,  double position,  DateTime? completedAt,  String? assigneePersonId,  Recurrence? recurrence,  Place? location,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _KanbanCard():
return $default(_that.id,_that.projectId,_that.columnId,_that.title,_that.description,_that.priority,_that.dueDate,_that.position,_that.completedAt,_that.assigneePersonId,_that.recurrence,_that.location,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String columnId,  String title,  String? description,  Priority priority,  DateTime? dueDate,  double position,  DateTime? completedAt,  String? assigneePersonId,  Recurrence? recurrence,  Place? location,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _KanbanCard() when $default != null:
return $default(_that.id,_that.projectId,_that.columnId,_that.title,_that.description,_that.priority,_that.dueDate,_that.position,_that.completedAt,_that.assigneePersonId,_that.recurrence,_that.location,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanbanCard extends KanbanCard {
  const _KanbanCard({required this.id, required this.projectId, required this.columnId, required this.title, this.description, this.priority = Priority.medium, this.dueDate, required this.position, this.completedAt, this.assigneePersonId, this.recurrence, this.location, required this.createdAt, required this.updatedAt}): super._();
  factory _KanbanCard.fromJson(Map<String, dynamic> json) => _$KanbanCardFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String columnId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  Priority priority;
@override final  DateTime? dueDate;
@override final  double position;
@override final  DateTime? completedAt;
@override final  String? assigneePersonId;
@override final  Recurrence? recurrence;
@override final  Place? location;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanbanCardCopyWith<_KanbanCard> get copyWith => __$KanbanCardCopyWithImpl<_KanbanCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanbanCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanbanCard&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.columnId, columnId) || other.columnId == columnId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.position, position) || other.position == position)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.assigneePersonId, assigneePersonId) || other.assigneePersonId == assigneePersonId)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,projectId,columnId,title,description,priority,dueDate,position,completedAt,assigneePersonId,recurrence,location,createdAt,updatedAt);
}

@override
String toString() {
    return 'KanbanCard(id: $id, projectId: $projectId, columnId: $columnId, title: $title, description: $description, priority: $priority, dueDate: $dueDate, position: $position, completedAt: $completedAt, assigneePersonId: $assigneePersonId, recurrence: $recurrence, location: $location, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$KanbanCardCopyWith<$Res> implements $KanbanCardCopyWith<$Res> {
  factory _$KanbanCardCopyWith(_KanbanCard value, $Res Function(_KanbanCard) _then) = __$KanbanCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String columnId, String title, String? description, Priority priority, DateTime? dueDate, double position, DateTime? completedAt, String? assigneePersonId, Recurrence? recurrence, Place? location, DateTime createdAt, DateTime updatedAt
});


@override $PlaceCopyWith<$Res>? get location;

}
/// @nodoc
class __$KanbanCardCopyWithImpl<$Res>
    implements _$KanbanCardCopyWith<$Res> {
  __$KanbanCardCopyWithImpl(this._self, this._then);

  final _KanbanCard _self;
  final $Res Function(_KanbanCard) _then;

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? columnId = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? dueDate = freezed,Object? position = null,Object? completedAt = freezed,Object? assigneePersonId = freezed,Object? recurrence = freezed,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_KanbanCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,columnId: null == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assigneePersonId: freezed == assigneePersonId ? _self.assigneePersonId : assigneePersonId // ignore: cast_nullable_to_non_nullable
as String?,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Place?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of KanbanCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$ChecklistItem {

 String get id; String get cardId; String get title; bool get isDone; double get position;
/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChecklistItemCopyWith<ChecklistItem> get copyWith => _$ChecklistItemCopyWithImpl<ChecklistItem>(this as ChecklistItem, _$identity);

  /// Serializes this ChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChecklistItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.isDone, _this.isDone) || other.isDone == _this.isDone)&&(identical(other.position, _this.position) || other.position == _this.position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChecklistItem;
  return Object.hash(runtimeType,_this.id,_this.cardId,_this.title,_this.isDone,_this.position);
}

@override
String toString() {
  final _this = this as ChecklistItem;
  return 'ChecklistItem(id: ${_this.id}, cardId: ${_this.cardId}, title: ${_this.title}, isDone: ${_this.isDone}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $ChecklistItemCopyWith<$Res>  {
  factory $ChecklistItemCopyWith(ChecklistItem value, $Res Function(ChecklistItem) _then) = _$ChecklistItemCopyWithImpl;
@useResult
$Res call({
 String id, String cardId, String title, bool isDone, double position
});




}
/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._self, this._then);

  final ChecklistItem _self;
  final $Res Function(ChecklistItem) _then;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardId = null,Object? title = null,Object? isDone = null,Object? position = null,}) {
  return _then(ChecklistItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChecklistItem].
extension ChecklistItemPatterns on ChecklistItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChecklistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChecklistItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChecklistItem value)  $default,){
final _that = this;
switch (_that) {
case _ChecklistItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChecklistItem value)?  $default,){
final _that = this;
switch (_that) {
case _ChecklistItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cardId,  String title,  bool isDone,  double position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChecklistItem() when $default != null:
return $default(_that.id,_that.cardId,_that.title,_that.isDone,_that.position);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cardId,  String title,  bool isDone,  double position)  $default,) {final _that = this;
switch (_that) {
case _ChecklistItem():
return $default(_that.id,_that.cardId,_that.title,_that.isDone,_that.position);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cardId,  String title,  bool isDone,  double position)?  $default,) {final _that = this;
switch (_that) {
case _ChecklistItem() when $default != null:
return $default(_that.id,_that.cardId,_that.title,_that.isDone,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChecklistItem implements ChecklistItem {
  const _ChecklistItem({required this.id, required this.cardId, required this.title, this.isDone = false, required this.position});
  factory _ChecklistItem.fromJson(Map<String, dynamic> json) => _$ChecklistItemFromJson(json);

@override final  String id;
@override final  String cardId;
@override final  String title;
@override@JsonKey() final  bool isDone;
@override final  double position;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChecklistItemCopyWith<_ChecklistItem> get copyWith => __$ChecklistItemCopyWithImpl<_ChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChecklistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.title, title) || other.title == title)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,cardId,title,isDone,position);
}

@override
String toString() {
    return 'ChecklistItem(id: $id, cardId: $cardId, title: $title, isDone: $isDone, position: $position)';
}


}

/// @nodoc
abstract mixin class _$ChecklistItemCopyWith<$Res> implements $ChecklistItemCopyWith<$Res> {
  factory _$ChecklistItemCopyWith(_ChecklistItem value, $Res Function(_ChecklistItem) _then) = __$ChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String cardId, String title, bool isDone, double position
});




}
/// @nodoc
class __$ChecklistItemCopyWithImpl<$Res>
    implements _$ChecklistItemCopyWith<$Res> {
  __$ChecklistItemCopyWithImpl(this._self, this._then);

  final _ChecklistItem _self;
  final $Res Function(_ChecklistItem) _then;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardId = null,Object? title = null,Object? isDone = null,Object? position = null,}) {
  return _then(_ChecklistItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Label {

 String get id; String get projectId; String get name; String get colorHex;
/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelCopyWith<Label> get copyWith => _$LabelCopyWithImpl<Label>(this as Label, _$identity);

  /// Serializes this Label to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Label;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Label&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Label;
  return Object.hash(runtimeType,_this.id,_this.projectId,_this.name,_this.colorHex);
}

@override
String toString() {
  final _this = this as Label;
  return 'Label(id: ${_this.id}, projectId: ${_this.projectId}, name: ${_this.name}, colorHex: ${_this.colorHex})';
}


}

/// @nodoc
abstract mixin class $LabelCopyWith<$Res>  {
  factory $LabelCopyWith(Label value, $Res Function(Label) _then) = _$LabelCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String name, String colorHex
});




}
/// @nodoc
class _$LabelCopyWithImpl<$Res>
    implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._self, this._then);

  final Label _self;
  final $Res Function(Label) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? colorHex = null,}) {
  return _then(Label(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Label].
extension LabelPatterns on Label {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Label value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Label value)  $default,){
final _that = this;
switch (_that) {
case _Label():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Label value)?  $default,){
final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  String colorHex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.colorHex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  String colorHex)  $default,) {final _that = this;
switch (_that) {
case _Label():
return $default(_that.id,_that.projectId,_that.name,_that.colorHex);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String name,  String colorHex)?  $default,) {final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.colorHex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Label implements Label {
  const _Label({required this.id, required this.projectId, required this.name, required this.colorHex});
  factory _Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String name;
@override final  String colorHex;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelCopyWith<_Label> get copyWith => __$LabelCopyWithImpl<_Label>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Label&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,projectId,name,colorHex);
}

@override
String toString() {
    return 'Label(id: $id, projectId: $projectId, name: $name, colorHex: $colorHex)';
}


}

/// @nodoc
abstract mixin class _$LabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory _$LabelCopyWith(_Label value, $Res Function(_Label) _then) = __$LabelCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String name, String colorHex
});




}
/// @nodoc
class __$LabelCopyWithImpl<$Res>
    implements _$LabelCopyWith<$Res> {
  __$LabelCopyWithImpl(this._self, this._then);

  final _Label _self;
  final $Res Function(_Label) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? colorHex = null,}) {
  return _then(_Label(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BoardCard {

 KanbanCard get card; List<Label> get labels; int get checklistTotal; int get checklistDone; Person? get assignee;
/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardCardCopyWith<BoardCard> get copyWith => _$BoardCardCopyWithImpl<BoardCard>(this as BoardCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BoardCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardCard&&(identical(other.card, _this.card) || other.card == _this.card)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.checklistTotal, _this.checklistTotal) || other.checklistTotal == _this.checklistTotal)&&(identical(other.checklistDone, _this.checklistDone) || other.checklistDone == _this.checklistDone)&&(identical(other.assignee, _this.assignee) || other.assignee == _this.assignee));
}


@override
int get hashCode {
  final _this = this as BoardCard;
  return Object.hash(runtimeType,_this.card,const DeepCollectionEquality().hash(_this.labels),_this.checklistTotal,_this.checklistDone,_this.assignee);
}

@override
String toString() {
  final _this = this as BoardCard;
  return 'BoardCard(card: ${_this.card}, labels: ${_this.labels}, checklistTotal: ${_this.checklistTotal}, checklistDone: ${_this.checklistDone}, assignee: ${_this.assignee})';
}


}

/// @nodoc
abstract mixin class $BoardCardCopyWith<$Res>  {
  factory $BoardCardCopyWith(BoardCard value, $Res Function(BoardCard) _then) = _$BoardCardCopyWithImpl;
@useResult
$Res call({
 KanbanCard card, List<Label> labels, int checklistTotal, int checklistDone, Person? assignee
});


$KanbanCardCopyWith<$Res> get card;$PersonCopyWith<$Res>? get assignee;

}
/// @nodoc
class _$BoardCardCopyWithImpl<$Res>
    implements $BoardCardCopyWith<$Res> {
  _$BoardCardCopyWithImpl(this._self, this._then);

  final BoardCard _self;
  final $Res Function(BoardCard) _then;

/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? labels = null,Object? checklistTotal = null,Object? checklistDone = null,Object? assignee = freezed,}) {
  return _then(BoardCard(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,checklistTotal: null == checklistTotal ? _self.checklistTotal : checklistTotal // ignore: cast_nullable_to_non_nullable
as int,checklistDone: null == checklistDone ? _self.checklistDone : checklistDone // ignore: cast_nullable_to_non_nullable
as int,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as Person?,
  ));
}
/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get assignee {
    if (_self.assignee == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.assignee!, (value) {
    return _then(_self.copyWith(assignee: value));
  });
}
}


/// Adds pattern-matching-related methods to [BoardCard].
extension BoardCardPatterns on BoardCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardCard value)  $default,){
final _that = this;
switch (_that) {
case _BoardCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardCard value)?  $default,){
final _that = this;
switch (_that) {
case _BoardCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KanbanCard card,  List<Label> labels,  int checklistTotal,  int checklistDone,  Person? assignee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardCard() when $default != null:
return $default(_that.card,_that.labels,_that.checklistTotal,_that.checklistDone,_that.assignee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KanbanCard card,  List<Label> labels,  int checklistTotal,  int checklistDone,  Person? assignee)  $default,) {final _that = this;
switch (_that) {
case _BoardCard():
return $default(_that.card,_that.labels,_that.checklistTotal,_that.checklistDone,_that.assignee);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KanbanCard card,  List<Label> labels,  int checklistTotal,  int checklistDone,  Person? assignee)?  $default,) {final _that = this;
switch (_that) {
case _BoardCard() when $default != null:
return $default(_that.card,_that.labels,_that.checklistTotal,_that.checklistDone,_that.assignee);case _:
  return null;

}
}

}

/// @nodoc


class _BoardCard implements BoardCard {
  const _BoardCard({required this.card,  List<Label> labels = const <Label>[], this.checklistTotal = 0, this.checklistDone = 0, this.assignee}): _labels = labels;
  

@override final  KanbanCard card;
 final  List<Label> _labels;
@override@JsonKey() List<Label> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey() final  int checklistTotal;
@override@JsonKey() final  int checklistDone;
@override final  Person? assignee;

/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardCardCopyWith<_BoardCard> get copyWith => __$BoardCardCopyWithImpl<_BoardCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardCard&&(identical(other.card, card) || other.card == card)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.checklistTotal, checklistTotal) || other.checklistTotal == checklistTotal)&&(identical(other.checklistDone, checklistDone) || other.checklistDone == checklistDone)&&(identical(other.assignee, assignee) || other.assignee == assignee));
}


@override
int get hashCode {
    return Object.hash(runtimeType,card,const DeepCollectionEquality().hash(_labels),checklistTotal,checklistDone,assignee);
}

@override
String toString() {
    return 'BoardCard(card: $card, labels: $labels, checklistTotal: $checklistTotal, checklistDone: $checklistDone, assignee: $assignee)';
}


}

/// @nodoc
abstract mixin class _$BoardCardCopyWith<$Res> implements $BoardCardCopyWith<$Res> {
  factory _$BoardCardCopyWith(_BoardCard value, $Res Function(_BoardCard) _then) = __$BoardCardCopyWithImpl;
@override @useResult
$Res call({
 KanbanCard card, List<Label> labels, int checklistTotal, int checklistDone, Person? assignee
});


@override $KanbanCardCopyWith<$Res> get card;@override $PersonCopyWith<$Res>? get assignee;

}
/// @nodoc
class __$BoardCardCopyWithImpl<$Res>
    implements _$BoardCardCopyWith<$Res> {
  __$BoardCardCopyWithImpl(this._self, this._then);

  final _BoardCard _self;
  final $Res Function(_BoardCard) _then;

/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? labels = null,Object? checklistTotal = null,Object? checklistDone = null,Object? assignee = freezed,}) {
  return _then(_BoardCard(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,checklistTotal: null == checklistTotal ? _self.checklistTotal : checklistTotal // ignore: cast_nullable_to_non_nullable
as int,checklistDone: null == checklistDone ? _self.checklistDone : checklistDone // ignore: cast_nullable_to_non_nullable
as int,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as Person?,
  ));
}

/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of BoardCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get assignee {
    if (_self.assignee == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.assignee!, (value) {
    return _then(_self.copyWith(assignee: value));
  });
}
}

/// @nodoc
mixin _$BoardLane {

 BoardColumn get column; List<BoardCard> get cards;
/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardLaneCopyWith<BoardLane> get copyWith => _$BoardLaneCopyWithImpl<BoardLane>(this as BoardLane, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BoardLane;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardLane&&(identical(other.column, _this.column) || other.column == _this.column)&&const DeepCollectionEquality().equals(other.cards, _this.cards));
}


@override
int get hashCode {
  final _this = this as BoardLane;
  return Object.hash(runtimeType,_this.column,const DeepCollectionEquality().hash(_this.cards));
}

@override
String toString() {
  final _this = this as BoardLane;
  return 'BoardLane(column: ${_this.column}, cards: ${_this.cards})';
}


}

/// @nodoc
abstract mixin class $BoardLaneCopyWith<$Res>  {
  factory $BoardLaneCopyWith(BoardLane value, $Res Function(BoardLane) _then) = _$BoardLaneCopyWithImpl;
@useResult
$Res call({
 BoardColumn column, List<BoardCard> cards
});


$BoardColumnCopyWith<$Res> get column;

}
/// @nodoc
class _$BoardLaneCopyWithImpl<$Res>
    implements $BoardLaneCopyWith<$Res> {
  _$BoardLaneCopyWithImpl(this._self, this._then);

  final BoardLane _self;
  final $Res Function(BoardLane) _then;

/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? column = null,Object? cards = null,}) {
  return _then(BoardLane(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as BoardColumn,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<BoardCard>,
  ));
}
/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardColumnCopyWith<$Res> get column {
  
  return $BoardColumnCopyWith<$Res>(_self.column, (value) {
    return _then(_self.copyWith(column: value));
  });
}
}


/// Adds pattern-matching-related methods to [BoardLane].
extension BoardLanePatterns on BoardLane {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardLane value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardLane() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardLane value)  $default,){
final _that = this;
switch (_that) {
case _BoardLane():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardLane value)?  $default,){
final _that = this;
switch (_that) {
case _BoardLane() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BoardColumn column,  List<BoardCard> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardLane() when $default != null:
return $default(_that.column,_that.cards);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BoardColumn column,  List<BoardCard> cards)  $default,) {final _that = this;
switch (_that) {
case _BoardLane():
return $default(_that.column,_that.cards);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BoardColumn column,  List<BoardCard> cards)?  $default,) {final _that = this;
switch (_that) {
case _BoardLane() when $default != null:
return $default(_that.column,_that.cards);case _:
  return null;

}
}

}

/// @nodoc


class _BoardLane extends BoardLane {
  const _BoardLane({required this.column,  List<BoardCard> cards = const <BoardCard>[]}): _cards = cards,super._();
  

@override final  BoardColumn column;
 final  List<BoardCard> _cards;
@override@JsonKey() List<BoardCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardLaneCopyWith<_BoardLane> get copyWith => __$BoardLaneCopyWithImpl<_BoardLane>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardLane&&(identical(other.column, column) || other.column == column)&&const DeepCollectionEquality().equals(other.cards, _cards));
}


@override
int get hashCode {
    return Object.hash(runtimeType,column,const DeepCollectionEquality().hash(_cards));
}

@override
String toString() {
    return 'BoardLane(column: $column, cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$BoardLaneCopyWith<$Res> implements $BoardLaneCopyWith<$Res> {
  factory _$BoardLaneCopyWith(_BoardLane value, $Res Function(_BoardLane) _then) = __$BoardLaneCopyWithImpl;
@override @useResult
$Res call({
 BoardColumn column, List<BoardCard> cards
});


@override $BoardColumnCopyWith<$Res> get column;

}
/// @nodoc
class __$BoardLaneCopyWithImpl<$Res>
    implements _$BoardLaneCopyWith<$Res> {
  __$BoardLaneCopyWithImpl(this._self, this._then);

  final _BoardLane _self;
  final $Res Function(_BoardLane) _then;

/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? column = null,Object? cards = null,}) {
  return _then(_BoardLane(
column: null == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as BoardColumn,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<BoardCard>,
  ));
}

/// Create a copy of BoardLane
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardColumnCopyWith<$Res> get column {
  
  return $BoardColumnCopyWith<$Res>(_self.column, (value) {
    return _then(_self.copyWith(column: value));
  });
}
}

/// @nodoc
mixin _$BoardData {

 String get projectId; List<BoardLane> get lanes; List<Label> get labels;
/// Create a copy of BoardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardDataCopyWith<BoardData> get copyWith => _$BoardDataCopyWithImpl<BoardData>(this as BoardData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BoardData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardData&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&const DeepCollectionEquality().equals(other.lanes, _this.lanes)&&const DeepCollectionEquality().equals(other.labels, _this.labels));
}


@override
int get hashCode {
  final _this = this as BoardData;
  return Object.hash(runtimeType,_this.projectId,const DeepCollectionEquality().hash(_this.lanes),const DeepCollectionEquality().hash(_this.labels));
}

@override
String toString() {
  final _this = this as BoardData;
  return 'BoardData(projectId: ${_this.projectId}, lanes: ${_this.lanes}, labels: ${_this.labels})';
}


}

/// @nodoc
abstract mixin class $BoardDataCopyWith<$Res>  {
  factory $BoardDataCopyWith(BoardData value, $Res Function(BoardData) _then) = _$BoardDataCopyWithImpl;
@useResult
$Res call({
 String projectId, List<BoardLane> lanes, List<Label> labels
});




}
/// @nodoc
class _$BoardDataCopyWithImpl<$Res>
    implements $BoardDataCopyWith<$Res> {
  _$BoardDataCopyWithImpl(this._self, this._then);

  final BoardData _self;
  final $Res Function(BoardData) _then;

/// Create a copy of BoardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? lanes = null,Object? labels = null,}) {
  return _then(BoardData(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,lanes: null == lanes ? _self.lanes : lanes // ignore: cast_nullable_to_non_nullable
as List<BoardLane>,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardData].
extension BoardDataPatterns on BoardData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardData value)  $default,){
final _that = this;
switch (_that) {
case _BoardData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardData value)?  $default,){
final _that = this;
switch (_that) {
case _BoardData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectId,  List<BoardLane> lanes,  List<Label> labels)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardData() when $default != null:
return $default(_that.projectId,_that.lanes,_that.labels);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectId,  List<BoardLane> lanes,  List<Label> labels)  $default,) {final _that = this;
switch (_that) {
case _BoardData():
return $default(_that.projectId,_that.lanes,_that.labels);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectId,  List<BoardLane> lanes,  List<Label> labels)?  $default,) {final _that = this;
switch (_that) {
case _BoardData() when $default != null:
return $default(_that.projectId,_that.lanes,_that.labels);case _:
  return null;

}
}

}

/// @nodoc


class _BoardData extends BoardData {
  const _BoardData({required this.projectId,  List<BoardLane> lanes = const <BoardLane>[],  List<Label> labels = const <Label>[]}): _lanes = lanes,_labels = labels,super._();
  

@override final  String projectId;
 final  List<BoardLane> _lanes;
@override@JsonKey() List<BoardLane> get lanes {
  if (_lanes is EqualUnmodifiableListView) return _lanes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lanes);
}

 final  List<Label> _labels;
@override@JsonKey() List<Label> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}


/// Create a copy of BoardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardDataCopyWith<_BoardData> get copyWith => __$BoardDataCopyWithImpl<_BoardData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardData&&(identical(other.projectId, projectId) || other.projectId == projectId)&&const DeepCollectionEquality().equals(other.lanes, _lanes)&&const DeepCollectionEquality().equals(other.labels, _labels));
}


@override
int get hashCode {
    return Object.hash(runtimeType,projectId,const DeepCollectionEquality().hash(_lanes),const DeepCollectionEquality().hash(_labels));
}

@override
String toString() {
    return 'BoardData(projectId: $projectId, lanes: $lanes, labels: $labels)';
}


}

/// @nodoc
abstract mixin class _$BoardDataCopyWith<$Res> implements $BoardDataCopyWith<$Res> {
  factory _$BoardDataCopyWith(_BoardData value, $Res Function(_BoardData) _then) = __$BoardDataCopyWithImpl;
@override @useResult
$Res call({
 String projectId, List<BoardLane> lanes, List<Label> labels
});




}
/// @nodoc
class __$BoardDataCopyWithImpl<$Res>
    implements _$BoardDataCopyWith<$Res> {
  __$BoardDataCopyWithImpl(this._self, this._then);

  final _BoardData _self;
  final $Res Function(_BoardData) _then;

/// Create a copy of BoardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? lanes = null,Object? labels = null,}) {
  return _then(_BoardData(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,lanes: null == lanes ? _self._lanes : lanes // ignore: cast_nullable_to_non_nullable
as List<BoardLane>,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,
  ));
}


}

/// @nodoc
mixin _$CardDetail {

 KanbanCard get card; List<BoardColumn> get columns; List<ChecklistItem> get checklist; List<Label> get projectLabels; Set<String> get labelIds;
/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardDetailCopyWith<CardDetail> get copyWith => _$CardDetailCopyWithImpl<CardDetail>(this as CardDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CardDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardDetail&&(identical(other.card, _this.card) || other.card == _this.card)&&const DeepCollectionEquality().equals(other.columns, _this.columns)&&const DeepCollectionEquality().equals(other.checklist, _this.checklist)&&const DeepCollectionEquality().equals(other.projectLabels, _this.projectLabels)&&const DeepCollectionEquality().equals(other.labelIds, _this.labelIds));
}


@override
int get hashCode {
  final _this = this as CardDetail;
  return Object.hash(runtimeType,_this.card,const DeepCollectionEquality().hash(_this.columns),const DeepCollectionEquality().hash(_this.checklist),const DeepCollectionEquality().hash(_this.projectLabels),const DeepCollectionEquality().hash(_this.labelIds));
}

@override
String toString() {
  final _this = this as CardDetail;
  return 'CardDetail(card: ${_this.card}, columns: ${_this.columns}, checklist: ${_this.checklist}, projectLabels: ${_this.projectLabels}, labelIds: ${_this.labelIds})';
}


}

/// @nodoc
abstract mixin class $CardDetailCopyWith<$Res>  {
  factory $CardDetailCopyWith(CardDetail value, $Res Function(CardDetail) _then) = _$CardDetailCopyWithImpl;
@useResult
$Res call({
 KanbanCard card, List<BoardColumn> columns, List<ChecklistItem> checklist, List<Label> projectLabels, Set<String> labelIds
});


$KanbanCardCopyWith<$Res> get card;

}
/// @nodoc
class _$CardDetailCopyWithImpl<$Res>
    implements $CardDetailCopyWith<$Res> {
  _$CardDetailCopyWithImpl(this._self, this._then);

  final CardDetail _self;
  final $Res Function(CardDetail) _then;

/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? columns = null,Object? checklist = null,Object? projectLabels = null,Object? labelIds = null,}) {
  return _then(CardDetail(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as List<BoardColumn>,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,projectLabels: null == projectLabels ? _self.projectLabels : projectLabels // ignore: cast_nullable_to_non_nullable
as List<Label>,labelIds: null == labelIds ? _self.labelIds : labelIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}
/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [CardDetail].
extension CardDetailPatterns on CardDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardDetail value)  $default,){
final _that = this;
switch (_that) {
case _CardDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardDetail value)?  $default,){
final _that = this;
switch (_that) {
case _CardDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KanbanCard card,  List<BoardColumn> columns,  List<ChecklistItem> checklist,  List<Label> projectLabels,  Set<String> labelIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardDetail() when $default != null:
return $default(_that.card,_that.columns,_that.checklist,_that.projectLabels,_that.labelIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KanbanCard card,  List<BoardColumn> columns,  List<ChecklistItem> checklist,  List<Label> projectLabels,  Set<String> labelIds)  $default,) {final _that = this;
switch (_that) {
case _CardDetail():
return $default(_that.card,_that.columns,_that.checklist,_that.projectLabels,_that.labelIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KanbanCard card,  List<BoardColumn> columns,  List<ChecklistItem> checklist,  List<Label> projectLabels,  Set<String> labelIds)?  $default,) {final _that = this;
switch (_that) {
case _CardDetail() when $default != null:
return $default(_that.card,_that.columns,_that.checklist,_that.projectLabels,_that.labelIds);case _:
  return null;

}
}

}

/// @nodoc


class _CardDetail extends CardDetail {
  const _CardDetail({required this.card, required  List<BoardColumn> columns,  List<ChecklistItem> checklist = const <ChecklistItem>[],  List<Label> projectLabels = const <Label>[],  Set<String> labelIds = const <String>{}}): _columns = columns,_checklist = checklist,_projectLabels = projectLabels,_labelIds = labelIds,super._();
  

@override final  KanbanCard card;
 final  List<BoardColumn> _columns;
@override List<BoardColumn> get columns {
  if (_columns is EqualUnmodifiableListView) return _columns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_columns);
}

 final  List<ChecklistItem> _checklist;
@override@JsonKey() List<ChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

 final  List<Label> _projectLabels;
@override@JsonKey() List<Label> get projectLabels {
  if (_projectLabels is EqualUnmodifiableListView) return _projectLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projectLabels);
}

 final  Set<String> _labelIds;
@override@JsonKey() Set<String> get labelIds {
  if (_labelIds is EqualUnmodifiableSetView) return _labelIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_labelIds);
}


/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardDetailCopyWith<_CardDetail> get copyWith => __$CardDetailCopyWithImpl<_CardDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardDetail&&(identical(other.card, card) || other.card == card)&&const DeepCollectionEquality().equals(other.columns, _columns)&&const DeepCollectionEquality().equals(other.checklist, _checklist)&&const DeepCollectionEquality().equals(other.projectLabels, _projectLabels)&&const DeepCollectionEquality().equals(other.labelIds, _labelIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,card,const DeepCollectionEquality().hash(_columns),const DeepCollectionEquality().hash(_checklist),const DeepCollectionEquality().hash(_projectLabels),const DeepCollectionEquality().hash(_labelIds));
}

@override
String toString() {
    return 'CardDetail(card: $card, columns: $columns, checklist: $checklist, projectLabels: $projectLabels, labelIds: $labelIds)';
}


}

/// @nodoc
abstract mixin class _$CardDetailCopyWith<$Res> implements $CardDetailCopyWith<$Res> {
  factory _$CardDetailCopyWith(_CardDetail value, $Res Function(_CardDetail) _then) = __$CardDetailCopyWithImpl;
@override @useResult
$Res call({
 KanbanCard card, List<BoardColumn> columns, List<ChecklistItem> checklist, List<Label> projectLabels, Set<String> labelIds
});


@override $KanbanCardCopyWith<$Res> get card;

}
/// @nodoc
class __$CardDetailCopyWithImpl<$Res>
    implements _$CardDetailCopyWith<$Res> {
  __$CardDetailCopyWithImpl(this._self, this._then);

  final _CardDetail _self;
  final $Res Function(_CardDetail) _then;

/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? columns = null,Object? checklist = null,Object? projectLabels = null,Object? labelIds = null,}) {
  return _then(_CardDetail(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,columns: null == columns ? _self._columns : columns // ignore: cast_nullable_to_non_nullable
as List<BoardColumn>,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,projectLabels: null == projectLabels ? _self._projectLabels : projectLabels // ignore: cast_nullable_to_non_nullable
as List<Label>,labelIds: null == labelIds ? _self._labelIds : labelIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of CardDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}

/// @nodoc
mixin _$CardPatch {

 String? get title; String? get description; Priority? get priority; DateTime? get dueDate; bool get clearDueDate; String? get assigneePersonId; bool get clearAssignee; Recurrence? get recurrence; bool get clearRecurrence; Place? get location; bool get clearLocation;
/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardPatchCopyWith<CardPatch> get copyWith => _$CardPatchCopyWithImpl<CardPatch>(this as CardPatch, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CardPatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPatch&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.clearDueDate, _this.clearDueDate) || other.clearDueDate == _this.clearDueDate)&&(identical(other.assigneePersonId, _this.assigneePersonId) || other.assigneePersonId == _this.assigneePersonId)&&(identical(other.clearAssignee, _this.clearAssignee) || other.clearAssignee == _this.clearAssignee)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&(identical(other.clearRecurrence, _this.clearRecurrence) || other.clearRecurrence == _this.clearRecurrence)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.clearLocation, _this.clearLocation) || other.clearLocation == _this.clearLocation));
}


@override
int get hashCode {
  final _this = this as CardPatch;
  return Object.hash(runtimeType,_this.title,_this.description,_this.priority,_this.dueDate,_this.clearDueDate,_this.assigneePersonId,_this.clearAssignee,_this.recurrence,_this.clearRecurrence,_this.location,_this.clearLocation);
}

@override
String toString() {
  final _this = this as CardPatch;
  return 'CardPatch(title: ${_this.title}, description: ${_this.description}, priority: ${_this.priority}, dueDate: ${_this.dueDate}, clearDueDate: ${_this.clearDueDate}, assigneePersonId: ${_this.assigneePersonId}, clearAssignee: ${_this.clearAssignee}, recurrence: ${_this.recurrence}, clearRecurrence: ${_this.clearRecurrence}, location: ${_this.location}, clearLocation: ${_this.clearLocation})';
}


}

/// @nodoc
abstract mixin class $CardPatchCopyWith<$Res>  {
  factory $CardPatchCopyWith(CardPatch value, $Res Function(CardPatch) _then) = _$CardPatchCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, Priority? priority, DateTime? dueDate, bool clearDueDate, String? assigneePersonId, bool clearAssignee, Recurrence? recurrence, bool clearRecurrence, Place? location, bool clearLocation
});


$PlaceCopyWith<$Res>? get location;

}
/// @nodoc
class _$CardPatchCopyWithImpl<$Res>
    implements $CardPatchCopyWith<$Res> {
  _$CardPatchCopyWithImpl(this._self, this._then);

  final CardPatch _self;
  final $Res Function(CardPatch) _then;

/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? priority = freezed,Object? dueDate = freezed,Object? clearDueDate = null,Object? assigneePersonId = freezed,Object? clearAssignee = null,Object? recurrence = freezed,Object? clearRecurrence = null,Object? location = freezed,Object? clearLocation = null,}) {
  return _then(CardPatch(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,clearDueDate: null == clearDueDate ? _self.clearDueDate : clearDueDate // ignore: cast_nullable_to_non_nullable
as bool,assigneePersonId: freezed == assigneePersonId ? _self.assigneePersonId : assigneePersonId // ignore: cast_nullable_to_non_nullable
as String?,clearAssignee: null == clearAssignee ? _self.clearAssignee : clearAssignee // ignore: cast_nullable_to_non_nullable
as bool,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence?,clearRecurrence: null == clearRecurrence ? _self.clearRecurrence : clearRecurrence // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Place?,clearLocation: null == clearLocation ? _self.clearLocation : clearLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [CardPatch].
extension CardPatchPatterns on CardPatch {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardPatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardPatch() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardPatch value)  $default,){
final _that = this;
switch (_that) {
case _CardPatch():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardPatch value)?  $default,){
final _that = this;
switch (_that) {
case _CardPatch() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  Priority? priority,  DateTime? dueDate,  bool clearDueDate,  String? assigneePersonId,  bool clearAssignee,  Recurrence? recurrence,  bool clearRecurrence,  Place? location,  bool clearLocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardPatch() when $default != null:
return $default(_that.title,_that.description,_that.priority,_that.dueDate,_that.clearDueDate,_that.assigneePersonId,_that.clearAssignee,_that.recurrence,_that.clearRecurrence,_that.location,_that.clearLocation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  Priority? priority,  DateTime? dueDate,  bool clearDueDate,  String? assigneePersonId,  bool clearAssignee,  Recurrence? recurrence,  bool clearRecurrence,  Place? location,  bool clearLocation)  $default,) {final _that = this;
switch (_that) {
case _CardPatch():
return $default(_that.title,_that.description,_that.priority,_that.dueDate,_that.clearDueDate,_that.assigneePersonId,_that.clearAssignee,_that.recurrence,_that.clearRecurrence,_that.location,_that.clearLocation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  Priority? priority,  DateTime? dueDate,  bool clearDueDate,  String? assigneePersonId,  bool clearAssignee,  Recurrence? recurrence,  bool clearRecurrence,  Place? location,  bool clearLocation)?  $default,) {final _that = this;
switch (_that) {
case _CardPatch() when $default != null:
return $default(_that.title,_that.description,_that.priority,_that.dueDate,_that.clearDueDate,_that.assigneePersonId,_that.clearAssignee,_that.recurrence,_that.clearRecurrence,_that.location,_that.clearLocation);case _:
  return null;

}
}

}

/// @nodoc


class _CardPatch implements CardPatch {
  const _CardPatch({this.title, this.description, this.priority, this.dueDate, this.clearDueDate = false, this.assigneePersonId, this.clearAssignee = false, this.recurrence, this.clearRecurrence = false, this.location, this.clearLocation = false});
  

@override final  String? title;
@override final  String? description;
@override final  Priority? priority;
@override final  DateTime? dueDate;
@override@JsonKey() final  bool clearDueDate;
@override final  String? assigneePersonId;
@override@JsonKey() final  bool clearAssignee;
@override final  Recurrence? recurrence;
@override@JsonKey() final  bool clearRecurrence;
@override final  Place? location;
@override@JsonKey() final  bool clearLocation;

/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardPatchCopyWith<_CardPatch> get copyWith => __$CardPatchCopyWithImpl<_CardPatch>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardPatch&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.clearDueDate, clearDueDate) || other.clearDueDate == clearDueDate)&&(identical(other.assigneePersonId, assigneePersonId) || other.assigneePersonId == assigneePersonId)&&(identical(other.clearAssignee, clearAssignee) || other.clearAssignee == clearAssignee)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.clearRecurrence, clearRecurrence) || other.clearRecurrence == clearRecurrence)&&(identical(other.location, location) || other.location == location)&&(identical(other.clearLocation, clearLocation) || other.clearLocation == clearLocation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,priority,dueDate,clearDueDate,assigneePersonId,clearAssignee,recurrence,clearRecurrence,location,clearLocation);
}

@override
String toString() {
    return 'CardPatch(title: $title, description: $description, priority: $priority, dueDate: $dueDate, clearDueDate: $clearDueDate, assigneePersonId: $assigneePersonId, clearAssignee: $clearAssignee, recurrence: $recurrence, clearRecurrence: $clearRecurrence, location: $location, clearLocation: $clearLocation)';
}


}

/// @nodoc
abstract mixin class _$CardPatchCopyWith<$Res> implements $CardPatchCopyWith<$Res> {
  factory _$CardPatchCopyWith(_CardPatch value, $Res Function(_CardPatch) _then) = __$CardPatchCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, Priority? priority, DateTime? dueDate, bool clearDueDate, String? assigneePersonId, bool clearAssignee, Recurrence? recurrence, bool clearRecurrence, Place? location, bool clearLocation
});


@override $PlaceCopyWith<$Res>? get location;

}
/// @nodoc
class __$CardPatchCopyWithImpl<$Res>
    implements _$CardPatchCopyWith<$Res> {
  __$CardPatchCopyWithImpl(this._self, this._then);

  final _CardPatch _self;
  final $Res Function(_CardPatch) _then;

/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? priority = freezed,Object? dueDate = freezed,Object? clearDueDate = null,Object? assigneePersonId = freezed,Object? clearAssignee = null,Object? recurrence = freezed,Object? clearRecurrence = null,Object? location = freezed,Object? clearLocation = null,}) {
  return _then(_CardPatch(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,clearDueDate: null == clearDueDate ? _self.clearDueDate : clearDueDate // ignore: cast_nullable_to_non_nullable
as bool,assigneePersonId: freezed == assigneePersonId ? _self.assigneePersonId : assigneePersonId // ignore: cast_nullable_to_non_nullable
as String?,clearAssignee: null == clearAssignee ? _self.clearAssignee : clearAssignee // ignore: cast_nullable_to_non_nullable
as bool,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence?,clearRecurrence: null == clearRecurrence ? _self.clearRecurrence : clearRecurrence // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Place?,clearLocation: null == clearLocation ? _self.clearLocation : clearLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CardPatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc
mixin _$ColumnPatch {

 String get name; String? get colorHex; int? get wipLimit; bool get isDoneColumn;
/// Create a copy of ColumnPatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColumnPatchCopyWith<ColumnPatch> get copyWith => _$ColumnPatchCopyWithImpl<ColumnPatch>(this as ColumnPatch, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ColumnPatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColumnPatch&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.wipLimit, _this.wipLimit) || other.wipLimit == _this.wipLimit)&&(identical(other.isDoneColumn, _this.isDoneColumn) || other.isDoneColumn == _this.isDoneColumn));
}


@override
int get hashCode {
  final _this = this as ColumnPatch;
  return Object.hash(runtimeType,_this.name,_this.colorHex,_this.wipLimit,_this.isDoneColumn);
}

@override
String toString() {
  final _this = this as ColumnPatch;
  return 'ColumnPatch(name: ${_this.name}, colorHex: ${_this.colorHex}, wipLimit: ${_this.wipLimit}, isDoneColumn: ${_this.isDoneColumn})';
}


}

/// @nodoc
abstract mixin class $ColumnPatchCopyWith<$Res>  {
  factory $ColumnPatchCopyWith(ColumnPatch value, $Res Function(ColumnPatch) _then) = _$ColumnPatchCopyWithImpl;
@useResult
$Res call({
 String name, String? colorHex, int? wipLimit, bool isDoneColumn
});




}
/// @nodoc
class _$ColumnPatchCopyWithImpl<$Res>
    implements $ColumnPatchCopyWith<$Res> {
  _$ColumnPatchCopyWithImpl(this._self, this._then);

  final ColumnPatch _self;
  final $Res Function(ColumnPatch) _then;

/// Create a copy of ColumnPatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? colorHex = freezed,Object? wipLimit = freezed,Object? isDoneColumn = null,}) {
  return _then(ColumnPatch(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,wipLimit: freezed == wipLimit ? _self.wipLimit : wipLimit // ignore: cast_nullable_to_non_nullable
as int?,isDoneColumn: null == isDoneColumn ? _self.isDoneColumn : isDoneColumn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ColumnPatch].
extension ColumnPatchPatterns on ColumnPatch {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColumnPatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColumnPatch() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColumnPatch value)  $default,){
final _that = this;
switch (_that) {
case _ColumnPatch():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColumnPatch value)?  $default,){
final _that = this;
switch (_that) {
case _ColumnPatch() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? colorHex,  int? wipLimit,  bool isDoneColumn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColumnPatch() when $default != null:
return $default(_that.name,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? colorHex,  int? wipLimit,  bool isDoneColumn)  $default,) {final _that = this;
switch (_that) {
case _ColumnPatch():
return $default(_that.name,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? colorHex,  int? wipLimit,  bool isDoneColumn)?  $default,) {final _that = this;
switch (_that) {
case _ColumnPatch() when $default != null:
return $default(_that.name,_that.colorHex,_that.wipLimit,_that.isDoneColumn);case _:
  return null;

}
}

}

/// @nodoc


class _ColumnPatch implements ColumnPatch {
  const _ColumnPatch({required this.name, this.colorHex, this.wipLimit, this.isDoneColumn = false});
  

@override final  String name;
@override final  String? colorHex;
@override final  int? wipLimit;
@override@JsonKey() final  bool isDoneColumn;

/// Create a copy of ColumnPatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColumnPatchCopyWith<_ColumnPatch> get copyWith => __$ColumnPatchCopyWithImpl<_ColumnPatch>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColumnPatch&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.wipLimit, wipLimit) || other.wipLimit == wipLimit)&&(identical(other.isDoneColumn, isDoneColumn) || other.isDoneColumn == isDoneColumn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,colorHex,wipLimit,isDoneColumn);
}

@override
String toString() {
    return 'ColumnPatch(name: $name, colorHex: $colorHex, wipLimit: $wipLimit, isDoneColumn: $isDoneColumn)';
}


}

/// @nodoc
abstract mixin class _$ColumnPatchCopyWith<$Res> implements $ColumnPatchCopyWith<$Res> {
  factory _$ColumnPatchCopyWith(_ColumnPatch value, $Res Function(_ColumnPatch) _then) = __$ColumnPatchCopyWithImpl;
@override @useResult
$Res call({
 String name, String? colorHex, int? wipLimit, bool isDoneColumn
});




}
/// @nodoc
class __$ColumnPatchCopyWithImpl<$Res>
    implements _$ColumnPatchCopyWith<$Res> {
  __$ColumnPatchCopyWithImpl(this._self, this._then);

  final _ColumnPatch _self;
  final $Res Function(_ColumnPatch) _then;

/// Create a copy of ColumnPatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? colorHex = freezed,Object? wipLimit = freezed,Object? isDoneColumn = null,}) {
  return _then(_ColumnPatch(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,wipLimit: freezed == wipLimit ? _self.wipLimit : wipLimit // ignore: cast_nullable_to_non_nullable
as int?,isDoneColumn: null == isDoneColumn ? _self.isDoneColumn : isDoneColumn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$UpcomingCard {

 String get cardId; String get projectId; String get projectTitle; String get title; Priority get priority; DateTime get dueDate;
/// Create a copy of UpcomingCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingCardCopyWith<UpcomingCard> get copyWith => _$UpcomingCardCopyWithImpl<UpcomingCard>(this as UpcomingCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UpcomingCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingCard&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.projectTitle, _this.projectTitle) || other.projectTitle == _this.projectTitle)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate));
}


@override
int get hashCode {
  final _this = this as UpcomingCard;
  return Object.hash(runtimeType,_this.cardId,_this.projectId,_this.projectTitle,_this.title,_this.priority,_this.dueDate);
}

@override
String toString() {
  final _this = this as UpcomingCard;
  return 'UpcomingCard(cardId: ${_this.cardId}, projectId: ${_this.projectId}, projectTitle: ${_this.projectTitle}, title: ${_this.title}, priority: ${_this.priority}, dueDate: ${_this.dueDate})';
}


}

/// @nodoc
abstract mixin class $UpcomingCardCopyWith<$Res>  {
  factory $UpcomingCardCopyWith(UpcomingCard value, $Res Function(UpcomingCard) _then) = _$UpcomingCardCopyWithImpl;
@useResult
$Res call({
 String cardId, String projectId, String projectTitle, String title, Priority priority, DateTime dueDate
});




}
/// @nodoc
class _$UpcomingCardCopyWithImpl<$Res>
    implements $UpcomingCardCopyWith<$Res> {
  _$UpcomingCardCopyWithImpl(this._self, this._then);

  final UpcomingCard _self;
  final $Res Function(UpcomingCard) _then;

/// Create a copy of UpcomingCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? projectId = null,Object? projectTitle = null,Object? title = null,Object? priority = null,Object? dueDate = null,}) {
  return _then(UpcomingCard(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingCard].
extension UpcomingCardPatterns on UpcomingCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingCard value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingCard value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  String projectId,  String projectTitle,  String title,  Priority priority,  DateTime dueDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingCard() when $default != null:
return $default(_that.cardId,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.dueDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  String projectId,  String projectTitle,  String title,  Priority priority,  DateTime dueDate)  $default,) {final _that = this;
switch (_that) {
case _UpcomingCard():
return $default(_that.cardId,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.dueDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  String projectId,  String projectTitle,  String title,  Priority priority,  DateTime dueDate)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingCard() when $default != null:
return $default(_that.cardId,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.dueDate);case _:
  return null;

}
}

}

/// @nodoc


class _UpcomingCard implements UpcomingCard {
  const _UpcomingCard({required this.cardId, required this.projectId, required this.projectTitle, required this.title, required this.priority, required this.dueDate});
  

@override final  String cardId;
@override final  String projectId;
@override final  String projectTitle;
@override final  String title;
@override final  Priority priority;
@override final  DateTime dueDate;

/// Create a copy of UpcomingCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingCardCopyWith<_UpcomingCard> get copyWith => __$UpcomingCardCopyWithImpl<_UpcomingCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingCard&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectTitle, projectTitle) || other.projectTitle == projectTitle)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,cardId,projectId,projectTitle,title,priority,dueDate);
}

@override
String toString() {
    return 'UpcomingCard(cardId: $cardId, projectId: $projectId, projectTitle: $projectTitle, title: $title, priority: $priority, dueDate: $dueDate)';
}


}

/// @nodoc
abstract mixin class _$UpcomingCardCopyWith<$Res> implements $UpcomingCardCopyWith<$Res> {
  factory _$UpcomingCardCopyWith(_UpcomingCard value, $Res Function(_UpcomingCard) _then) = __$UpcomingCardCopyWithImpl;
@override @useResult
$Res call({
 String cardId, String projectId, String projectTitle, String title, Priority priority, DateTime dueDate
});




}
/// @nodoc
class __$UpcomingCardCopyWithImpl<$Res>
    implements _$UpcomingCardCopyWith<$Res> {
  __$UpcomingCardCopyWithImpl(this._self, this._then);

  final _UpcomingCard _self;
  final $Res Function(_UpcomingCard) _then;

/// Create a copy of UpcomingCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? projectId = null,Object? projectTitle = null,Object? title = null,Object? priority = null,Object? dueDate = null,}) {
  return _then(_UpcomingCard(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
