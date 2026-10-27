// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskFilter {

 TaskScope get scope; bool get showCompleted;
/// Create a copy of TaskFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFilterCopyWith<TaskFilter> get copyWith => _$TaskFilterCopyWithImpl<TaskFilter>(this as TaskFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFilter&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.showCompleted, _this.showCompleted) || other.showCompleted == _this.showCompleted));
}


@override
int get hashCode {
  final _this = this as TaskFilter;
  return Object.hash(runtimeType,_this.scope,_this.showCompleted);
}

@override
String toString() {
  final _this = this as TaskFilter;
  return 'TaskFilter(scope: ${_this.scope}, showCompleted: ${_this.showCompleted})';
}


}

/// @nodoc
abstract mixin class $TaskFilterCopyWith<$Res>  {
  factory $TaskFilterCopyWith(TaskFilter value, $Res Function(TaskFilter) _then) = _$TaskFilterCopyWithImpl;
@useResult
$Res call({
 TaskScope scope, bool showCompleted
});




}
/// @nodoc
class _$TaskFilterCopyWithImpl<$Res>
    implements $TaskFilterCopyWith<$Res> {
  _$TaskFilterCopyWithImpl(this._self, this._then);

  final TaskFilter _self;
  final $Res Function(TaskFilter) _then;

/// Create a copy of TaskFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = null,Object? showCompleted = null,}) {
  return _then(TaskFilter(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as TaskScope,showCompleted: null == showCompleted ? _self.showCompleted : showCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskFilter].
extension TaskFilterPatterns on TaskFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFilter value)  $default,){
final _that = this;
switch (_that) {
case _TaskFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TaskScope scope,  bool showCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFilter() when $default != null:
return $default(_that.scope,_that.showCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TaskScope scope,  bool showCompleted)  $default,) {final _that = this;
switch (_that) {
case _TaskFilter():
return $default(_that.scope,_that.showCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TaskScope scope,  bool showCompleted)?  $default,) {final _that = this;
switch (_that) {
case _TaskFilter() when $default != null:
return $default(_that.scope,_that.showCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _TaskFilter implements TaskFilter {
  const _TaskFilter({this.scope = TaskScope.all, this.showCompleted = false});
  

@override@JsonKey() final  TaskScope scope;
@override@JsonKey() final  bool showCompleted;

/// Create a copy of TaskFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFilterCopyWith<_TaskFilter> get copyWith => __$TaskFilterCopyWithImpl<_TaskFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFilter&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.showCompleted, showCompleted) || other.showCompleted == showCompleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,scope,showCompleted);
}

@override
String toString() {
    return 'TaskFilter(scope: $scope, showCompleted: $showCompleted)';
}


}

/// @nodoc
abstract mixin class _$TaskFilterCopyWith<$Res> implements $TaskFilterCopyWith<$Res> {
  factory _$TaskFilterCopyWith(_TaskFilter value, $Res Function(_TaskFilter) _then) = __$TaskFilterCopyWithImpl;
@override @useResult
$Res call({
 TaskScope scope, bool showCompleted
});




}
/// @nodoc
class __$TaskFilterCopyWithImpl<$Res>
    implements _$TaskFilterCopyWith<$Res> {
  __$TaskFilterCopyWithImpl(this._self, this._then);

  final _TaskFilter _self;
  final $Res Function(_TaskFilter) _then;

/// Create a copy of TaskFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = null,Object? showCompleted = null,}) {
  return _then(_TaskFilter(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as TaskScope,showCompleted: null == showCompleted ? _self.showCompleted : showCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$TasksState {

 Map<TaskGroup, List<TaskItem>> get groups; int get openCount; int get overdueCount; String? get meId;
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksStateCopyWith<TasksState> get copyWith => _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TasksState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState&&const DeepCollectionEquality().equals(other.groups, _this.groups)&&(identical(other.openCount, _this.openCount) || other.openCount == _this.openCount)&&(identical(other.overdueCount, _this.overdueCount) || other.overdueCount == _this.overdueCount)&&(identical(other.meId, _this.meId) || other.meId == _this.meId));
}


@override
int get hashCode {
  final _this = this as TasksState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.groups),_this.openCount,_this.overdueCount,_this.meId);
}

@override
String toString() {
  final _this = this as TasksState;
  return 'TasksState(groups: ${_this.groups}, openCount: ${_this.openCount}, overdueCount: ${_this.overdueCount}, meId: ${_this.meId})';
}


}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res>  {
  factory $TasksStateCopyWith(TasksState value, $Res Function(TasksState) _then) = _$TasksStateCopyWithImpl;
@useResult
$Res call({
 Map<TaskGroup, List<TaskItem>> groups, int openCount, int overdueCount, String? meId
});




}
/// @nodoc
class _$TasksStateCopyWithImpl<$Res>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groups = null,Object? openCount = null,Object? overdueCount = null,Object? meId = freezed,}) {
  return _then(TasksState(
groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<TaskGroup, List<TaskItem>>,openCount: null == openCount ? _self.openCount : openCount // ignore: cast_nullable_to_non_nullable
as int,overdueCount: null == overdueCount ? _self.overdueCount : overdueCount // ignore: cast_nullable_to_non_nullable
as int,meId: freezed == meId ? _self.meId : meId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TasksState].
extension TasksStatePatterns on TasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TasksState value)  $default,){
final _that = this;
switch (_that) {
case _TasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TasksState value)?  $default,){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<TaskGroup, List<TaskItem>> groups,  int openCount,  int overdueCount,  String? meId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.groups,_that.openCount,_that.overdueCount,_that.meId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<TaskGroup, List<TaskItem>> groups,  int openCount,  int overdueCount,  String? meId)  $default,) {final _that = this;
switch (_that) {
case _TasksState():
return $default(_that.groups,_that.openCount,_that.overdueCount,_that.meId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<TaskGroup, List<TaskItem>> groups,  int openCount,  int overdueCount,  String? meId)?  $default,) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.groups,_that.openCount,_that.overdueCount,_that.meId);case _:
  return null;

}
}

}

/// @nodoc


class _TasksState extends TasksState {
  const _TasksState({ Map<TaskGroup, List<TaskItem>> groups = const <TaskGroup, List<TaskItem>>{}, this.openCount = 0, this.overdueCount = 0, this.meId}): _groups = groups,super._();
  

 final  Map<TaskGroup, List<TaskItem>> _groups;
@override@JsonKey() Map<TaskGroup, List<TaskItem>> get groups {
  if (_groups is EqualUnmodifiableMapView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groups);
}

@override@JsonKey() final  int openCount;
@override@JsonKey() final  int overdueCount;
@override final  String? meId;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksStateCopyWith<_TasksState> get copyWith => __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksState&&const DeepCollectionEquality().equals(other.groups, _groups)&&(identical(other.openCount, openCount) || other.openCount == openCount)&&(identical(other.overdueCount, overdueCount) || other.overdueCount == overdueCount)&&(identical(other.meId, meId) || other.meId == meId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups),openCount,overdueCount,meId);
}

@override
String toString() {
    return 'TasksState(groups: $groups, openCount: $openCount, overdueCount: $overdueCount, meId: $meId)';
}


}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res> implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(_TasksState value, $Res Function(_TasksState) _then) = __$TasksStateCopyWithImpl;
@override @useResult
$Res call({
 Map<TaskGroup, List<TaskItem>> groups, int openCount, int overdueCount, String? meId
});




}
/// @nodoc
class __$TasksStateCopyWithImpl<$Res>
    implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groups = null,Object? openCount = null,Object? overdueCount = null,Object? meId = freezed,}) {
  return _then(_TasksState(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as Map<TaskGroup, List<TaskItem>>,openCount: null == openCount ? _self.openCount : openCount // ignore: cast_nullable_to_non_nullable
as int,overdueCount: null == overdueCount ? _self.overdueCount : overdueCount // ignore: cast_nullable_to_non_nullable
as int,meId: freezed == meId ? _self.meId : meId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
