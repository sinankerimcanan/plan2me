// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskItem {

 KanbanCard get card; String get projectTitle; bool get isInbox; String get columnName; Person? get assignee; List<Label> get labels; int get checklistTotal; int get checklistDone;
/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskItemCopyWith<TaskItem> get copyWith => _$TaskItemCopyWithImpl<TaskItem>(this as TaskItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskItem&&(identical(other.card, _this.card) || other.card == _this.card)&&(identical(other.projectTitle, _this.projectTitle) || other.projectTitle == _this.projectTitle)&&(identical(other.isInbox, _this.isInbox) || other.isInbox == _this.isInbox)&&(identical(other.columnName, _this.columnName) || other.columnName == _this.columnName)&&(identical(other.assignee, _this.assignee) || other.assignee == _this.assignee)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.checklistTotal, _this.checklistTotal) || other.checklistTotal == _this.checklistTotal)&&(identical(other.checklistDone, _this.checklistDone) || other.checklistDone == _this.checklistDone));
}


@override
int get hashCode {
  final _this = this as TaskItem;
  return Object.hash(runtimeType,_this.card,_this.projectTitle,_this.isInbox,_this.columnName,_this.assignee,const DeepCollectionEquality().hash(_this.labels),_this.checklistTotal,_this.checklistDone);
}

@override
String toString() {
  final _this = this as TaskItem;
  return 'TaskItem(card: ${_this.card}, projectTitle: ${_this.projectTitle}, isInbox: ${_this.isInbox}, columnName: ${_this.columnName}, assignee: ${_this.assignee}, labels: ${_this.labels}, checklistTotal: ${_this.checklistTotal}, checklistDone: ${_this.checklistDone})';
}


}

/// @nodoc
abstract mixin class $TaskItemCopyWith<$Res>  {
  factory $TaskItemCopyWith(TaskItem value, $Res Function(TaskItem) _then) = _$TaskItemCopyWithImpl;
@useResult
$Res call({
 KanbanCard card, String projectTitle, bool isInbox, String columnName, Person? assignee, List<Label> labels, int checklistTotal, int checklistDone
});


$KanbanCardCopyWith<$Res> get card;$PersonCopyWith<$Res>? get assignee;

}
/// @nodoc
class _$TaskItemCopyWithImpl<$Res>
    implements $TaskItemCopyWith<$Res> {
  _$TaskItemCopyWithImpl(this._self, this._then);

  final TaskItem _self;
  final $Res Function(TaskItem) _then;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? projectTitle = null,Object? isInbox = null,Object? columnName = null,Object? assignee = freezed,Object? labels = null,Object? checklistTotal = null,Object? checklistDone = null,}) {
  return _then(TaskItem(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,isInbox: null == isInbox ? _self.isInbox : isInbox // ignore: cast_nullable_to_non_nullable
as bool,columnName: null == columnName ? _self.columnName : columnName // ignore: cast_nullable_to_non_nullable
as String,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as Person?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,checklistTotal: null == checklistTotal ? _self.checklistTotal : checklistTotal // ignore: cast_nullable_to_non_nullable
as int,checklistDone: null == checklistDone ? _self.checklistDone : checklistDone // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of TaskItem
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


/// Adds pattern-matching-related methods to [TaskItem].
extension TaskItemPatterns on TaskItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskItem value)  $default,){
final _that = this;
switch (_that) {
case _TaskItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskItem value)?  $default,){
final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KanbanCard card,  String projectTitle,  bool isInbox,  String columnName,  Person? assignee,  List<Label> labels,  int checklistTotal,  int checklistDone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
return $default(_that.card,_that.projectTitle,_that.isInbox,_that.columnName,_that.assignee,_that.labels,_that.checklistTotal,_that.checklistDone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KanbanCard card,  String projectTitle,  bool isInbox,  String columnName,  Person? assignee,  List<Label> labels,  int checklistTotal,  int checklistDone)  $default,) {final _that = this;
switch (_that) {
case _TaskItem():
return $default(_that.card,_that.projectTitle,_that.isInbox,_that.columnName,_that.assignee,_that.labels,_that.checklistTotal,_that.checklistDone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KanbanCard card,  String projectTitle,  bool isInbox,  String columnName,  Person? assignee,  List<Label> labels,  int checklistTotal,  int checklistDone)?  $default,) {final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
return $default(_that.card,_that.projectTitle,_that.isInbox,_that.columnName,_that.assignee,_that.labels,_that.checklistTotal,_that.checklistDone);case _:
  return null;

}
}

}

/// @nodoc


class _TaskItem extends TaskItem {
  const _TaskItem({required this.card, required this.projectTitle, this.isInbox = false, required this.columnName, this.assignee,  List<Label> labels = const <Label>[], this.checklistTotal = 0, this.checklistDone = 0}): _labels = labels,super._();
  

@override final  KanbanCard card;
@override final  String projectTitle;
@override@JsonKey() final  bool isInbox;
@override final  String columnName;
@override final  Person? assignee;
 final  List<Label> _labels;
@override@JsonKey() List<Label> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey() final  int checklistTotal;
@override@JsonKey() final  int checklistDone;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskItemCopyWith<_TaskItem> get copyWith => __$TaskItemCopyWithImpl<_TaskItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskItem&&(identical(other.card, card) || other.card == card)&&(identical(other.projectTitle, projectTitle) || other.projectTitle == projectTitle)&&(identical(other.isInbox, isInbox) || other.isInbox == isInbox)&&(identical(other.columnName, columnName) || other.columnName == columnName)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.checklistTotal, checklistTotal) || other.checklistTotal == checklistTotal)&&(identical(other.checklistDone, checklistDone) || other.checklistDone == checklistDone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,card,projectTitle,isInbox,columnName,assignee,const DeepCollectionEquality().hash(_labels),checklistTotal,checklistDone);
}

@override
String toString() {
    return 'TaskItem(card: $card, projectTitle: $projectTitle, isInbox: $isInbox, columnName: $columnName, assignee: $assignee, labels: $labels, checklistTotal: $checklistTotal, checklistDone: $checklistDone)';
}


}

/// @nodoc
abstract mixin class _$TaskItemCopyWith<$Res> implements $TaskItemCopyWith<$Res> {
  factory _$TaskItemCopyWith(_TaskItem value, $Res Function(_TaskItem) _then) = __$TaskItemCopyWithImpl;
@override @useResult
$Res call({
 KanbanCard card, String projectTitle, bool isInbox, String columnName, Person? assignee, List<Label> labels, int checklistTotal, int checklistDone
});


@override $KanbanCardCopyWith<$Res> get card;@override $PersonCopyWith<$Res>? get assignee;

}
/// @nodoc
class __$TaskItemCopyWithImpl<$Res>
    implements _$TaskItemCopyWith<$Res> {
  __$TaskItemCopyWithImpl(this._self, this._then);

  final _TaskItem _self;
  final $Res Function(_TaskItem) _then;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? projectTitle = null,Object? isInbox = null,Object? columnName = null,Object? assignee = freezed,Object? labels = null,Object? checklistTotal = null,Object? checklistDone = null,}) {
  return _then(_TaskItem(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as KanbanCard,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,isInbox: null == isInbox ? _self.isInbox : isInbox // ignore: cast_nullable_to_non_nullable
as bool,columnName: null == columnName ? _self.columnName : columnName // ignore: cast_nullable_to_non_nullable
as String,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as Person?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<Label>,checklistTotal: null == checklistTotal ? _self.checklistTotal : checklistTotal // ignore: cast_nullable_to_non_nullable
as int,checklistDone: null == checklistDone ? _self.checklistDone : checklistDone // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KanbanCardCopyWith<$Res> get card {
  
  return $KanbanCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of TaskItem
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
mixin _$QuickTaskInput {

 String get title; String? get projectId; DateTime? get dueDate; CardPatch get extra;
/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickTaskInputCopyWith<QuickTaskInput> get copyWith => _$QuickTaskInputCopyWithImpl<QuickTaskInput>(this as QuickTaskInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuickTaskInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickTaskInput&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.extra, _this.extra) || other.extra == _this.extra));
}


@override
int get hashCode {
  final _this = this as QuickTaskInput;
  return Object.hash(runtimeType,_this.title,_this.projectId,_this.dueDate,_this.extra);
}

@override
String toString() {
  final _this = this as QuickTaskInput;
  return 'QuickTaskInput(title: ${_this.title}, projectId: ${_this.projectId}, dueDate: ${_this.dueDate}, extra: ${_this.extra})';
}


}

/// @nodoc
abstract mixin class $QuickTaskInputCopyWith<$Res>  {
  factory $QuickTaskInputCopyWith(QuickTaskInput value, $Res Function(QuickTaskInput) _then) = _$QuickTaskInputCopyWithImpl;
@useResult
$Res call({
 String title, String? projectId, DateTime? dueDate, CardPatch extra
});


$CardPatchCopyWith<$Res> get extra;

}
/// @nodoc
class _$QuickTaskInputCopyWithImpl<$Res>
    implements $QuickTaskInputCopyWith<$Res> {
  _$QuickTaskInputCopyWithImpl(this._self, this._then);

  final QuickTaskInput _self;
  final $Res Function(QuickTaskInput) _then;

/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? projectId = freezed,Object? dueDate = freezed,Object? extra = null,}) {
  return _then(QuickTaskInput(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as CardPatch,
  ));
}
/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardPatchCopyWith<$Res> get extra {
  
  return $CardPatchCopyWith<$Res>(_self.extra, (value) {
    return _then(_self.copyWith(extra: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuickTaskInput].
extension QuickTaskInputPatterns on QuickTaskInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickTaskInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickTaskInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickTaskInput value)  $default,){
final _that = this;
switch (_that) {
case _QuickTaskInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickTaskInput value)?  $default,){
final _that = this;
switch (_that) {
case _QuickTaskInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? projectId,  DateTime? dueDate,  CardPatch extra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickTaskInput() when $default != null:
return $default(_that.title,_that.projectId,_that.dueDate,_that.extra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? projectId,  DateTime? dueDate,  CardPatch extra)  $default,) {final _that = this;
switch (_that) {
case _QuickTaskInput():
return $default(_that.title,_that.projectId,_that.dueDate,_that.extra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? projectId,  DateTime? dueDate,  CardPatch extra)?  $default,) {final _that = this;
switch (_that) {
case _QuickTaskInput() when $default != null:
return $default(_that.title,_that.projectId,_that.dueDate,_that.extra);case _:
  return null;

}
}

}

/// @nodoc


class _QuickTaskInput implements QuickTaskInput {
  const _QuickTaskInput({required this.title, this.projectId, this.dueDate, this.extra = const CardPatch()});
  

@override final  String title;
@override final  String? projectId;
@override final  DateTime? dueDate;
@override@JsonKey() final  CardPatch extra;

/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickTaskInputCopyWith<_QuickTaskInput> get copyWith => __$QuickTaskInputCopyWithImpl<_QuickTaskInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickTaskInput&&(identical(other.title, title) || other.title == title)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.extra, extra) || other.extra == extra));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,projectId,dueDate,extra);
}

@override
String toString() {
    return 'QuickTaskInput(title: $title, projectId: $projectId, dueDate: $dueDate, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$QuickTaskInputCopyWith<$Res> implements $QuickTaskInputCopyWith<$Res> {
  factory _$QuickTaskInputCopyWith(_QuickTaskInput value, $Res Function(_QuickTaskInput) _then) = __$QuickTaskInputCopyWithImpl;
@override @useResult
$Res call({
 String title, String? projectId, DateTime? dueDate, CardPatch extra
});


@override $CardPatchCopyWith<$Res> get extra;

}
/// @nodoc
class __$QuickTaskInputCopyWithImpl<$Res>
    implements _$QuickTaskInputCopyWith<$Res> {
  __$QuickTaskInputCopyWithImpl(this._self, this._then);

  final _QuickTaskInput _self;
  final $Res Function(_QuickTaskInput) _then;

/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? projectId = freezed,Object? dueDate = freezed,Object? extra = null,}) {
  return _then(_QuickTaskInput(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as CardPatch,
  ));
}

/// Create a copy of QuickTaskInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardPatchCopyWith<$Res> get extra {
  
  return $CardPatchCopyWith<$Res>(_self.extra, (value) {
    return _then(_self.copyWith(extra: value));
  });
}
}

// dart format on
