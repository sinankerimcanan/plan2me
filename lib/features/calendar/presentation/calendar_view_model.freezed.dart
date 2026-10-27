// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarUiState {

 DateTime get focusedDay; DateTime get selectedDay; CalendarSpan get span;
/// Create a copy of CalendarUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarUiStateCopyWith<CalendarUiState> get copyWith => _$CalendarUiStateCopyWithImpl<CalendarUiState>(this as CalendarUiState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarUiState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarUiState&&(identical(other.focusedDay, _this.focusedDay) || other.focusedDay == _this.focusedDay)&&(identical(other.selectedDay, _this.selectedDay) || other.selectedDay == _this.selectedDay)&&(identical(other.span, _this.span) || other.span == _this.span));
}


@override
int get hashCode {
  final _this = this as CalendarUiState;
  return Object.hash(runtimeType,_this.focusedDay,_this.selectedDay,_this.span);
}

@override
String toString() {
  final _this = this as CalendarUiState;
  return 'CalendarUiState(focusedDay: ${_this.focusedDay}, selectedDay: ${_this.selectedDay}, span: ${_this.span})';
}


}

/// @nodoc
abstract mixin class $CalendarUiStateCopyWith<$Res>  {
  factory $CalendarUiStateCopyWith(CalendarUiState value, $Res Function(CalendarUiState) _then) = _$CalendarUiStateCopyWithImpl;
@useResult
$Res call({
 DateTime focusedDay, DateTime selectedDay, CalendarSpan span
});




}
/// @nodoc
class _$CalendarUiStateCopyWithImpl<$Res>
    implements $CalendarUiStateCopyWith<$Res> {
  _$CalendarUiStateCopyWithImpl(this._self, this._then);

  final CalendarUiState _self;
  final $Res Function(CalendarUiState) _then;

/// Create a copy of CalendarUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? focusedDay = null,Object? selectedDay = null,Object? span = null,}) {
  return _then(CalendarUiState(
focusedDay: null == focusedDay ? _self.focusedDay : focusedDay // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as CalendarSpan,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarUiState].
extension CalendarUiStatePatterns on CalendarUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarUiState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarUiState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime focusedDay,  DateTime selectedDay,  CalendarSpan span)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarUiState() when $default != null:
return $default(_that.focusedDay,_that.selectedDay,_that.span);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime focusedDay,  DateTime selectedDay,  CalendarSpan span)  $default,) {final _that = this;
switch (_that) {
case _CalendarUiState():
return $default(_that.focusedDay,_that.selectedDay,_that.span);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime focusedDay,  DateTime selectedDay,  CalendarSpan span)?  $default,) {final _that = this;
switch (_that) {
case _CalendarUiState() when $default != null:
return $default(_that.focusedDay,_that.selectedDay,_that.span);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarUiState implements CalendarUiState {
  const _CalendarUiState({required this.focusedDay, required this.selectedDay, this.span = CalendarSpan.month});
  

@override final  DateTime focusedDay;
@override final  DateTime selectedDay;
@override@JsonKey() final  CalendarSpan span;

/// Create a copy of CalendarUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarUiStateCopyWith<_CalendarUiState> get copyWith => __$CalendarUiStateCopyWithImpl<_CalendarUiState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarUiState&&(identical(other.focusedDay, focusedDay) || other.focusedDay == focusedDay)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay)&&(identical(other.span, span) || other.span == span));
}


@override
int get hashCode {
    return Object.hash(runtimeType,focusedDay,selectedDay,span);
}

@override
String toString() {
    return 'CalendarUiState(focusedDay: $focusedDay, selectedDay: $selectedDay, span: $span)';
}


}

/// @nodoc
abstract mixin class _$CalendarUiStateCopyWith<$Res> implements $CalendarUiStateCopyWith<$Res> {
  factory _$CalendarUiStateCopyWith(_CalendarUiState value, $Res Function(_CalendarUiState) _then) = __$CalendarUiStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime focusedDay, DateTime selectedDay, CalendarSpan span
});




}
/// @nodoc
class __$CalendarUiStateCopyWithImpl<$Res>
    implements _$CalendarUiStateCopyWith<$Res> {
  __$CalendarUiStateCopyWithImpl(this._self, this._then);

  final _CalendarUiState _self;
  final $Res Function(_CalendarUiState) _then;

/// Create a copy of CalendarUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? focusedDay = null,Object? selectedDay = null,Object? span = null,}) {
  return _then(_CalendarUiState(
focusedDay: null == focusedDay ? _self.focusedDay : focusedDay // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as CalendarSpan,
  ));
}


}

/// @nodoc
mixin _$DayAgenda {

 List<TaskItem> get tasks; List<ProjectOverview> get projects;/// Telefon takvimindeki (plan2me dışı) etkinlikler.
 List<DeviceEvent> get deviceEvents;
/// Create a copy of DayAgenda
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayAgendaCopyWith<DayAgenda> get copyWith => _$DayAgendaCopyWithImpl<DayAgenda>(this as DayAgenda, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DayAgenda;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayAgenda&&const DeepCollectionEquality().equals(other.tasks, _this.tasks)&&const DeepCollectionEquality().equals(other.projects, _this.projects)&&const DeepCollectionEquality().equals(other.deviceEvents, _this.deviceEvents));
}


@override
int get hashCode {
  final _this = this as DayAgenda;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.tasks),const DeepCollectionEquality().hash(_this.projects),const DeepCollectionEquality().hash(_this.deviceEvents));
}

@override
String toString() {
  final _this = this as DayAgenda;
  return 'DayAgenda(tasks: ${_this.tasks}, projects: ${_this.projects}, deviceEvents: ${_this.deviceEvents})';
}


}

/// @nodoc
abstract mixin class $DayAgendaCopyWith<$Res>  {
  factory $DayAgendaCopyWith(DayAgenda value, $Res Function(DayAgenda) _then) = _$DayAgendaCopyWithImpl;
@useResult
$Res call({
 List<TaskItem> tasks, List<ProjectOverview> projects, List<DeviceEvent> deviceEvents
});




}
/// @nodoc
class _$DayAgendaCopyWithImpl<$Res>
    implements $DayAgendaCopyWith<$Res> {
  _$DayAgendaCopyWithImpl(this._self, this._then);

  final DayAgenda _self;
  final $Res Function(DayAgenda) _then;

/// Create a copy of DayAgenda
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tasks = null,Object? projects = null,Object? deviceEvents = null,}) {
  return _then(DayAgenda(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskItem>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectOverview>,deviceEvents: null == deviceEvents ? _self.deviceEvents : deviceEvents // ignore: cast_nullable_to_non_nullable
as List<DeviceEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [DayAgenda].
extension DayAgendaPatterns on DayAgenda {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayAgenda value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayAgenda() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayAgenda value)  $default,){
final _that = this;
switch (_that) {
case _DayAgenda():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayAgenda value)?  $default,){
final _that = this;
switch (_that) {
case _DayAgenda() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TaskItem> tasks,  List<ProjectOverview> projects,  List<DeviceEvent> deviceEvents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayAgenda() when $default != null:
return $default(_that.tasks,_that.projects,_that.deviceEvents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TaskItem> tasks,  List<ProjectOverview> projects,  List<DeviceEvent> deviceEvents)  $default,) {final _that = this;
switch (_that) {
case _DayAgenda():
return $default(_that.tasks,_that.projects,_that.deviceEvents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TaskItem> tasks,  List<ProjectOverview> projects,  List<DeviceEvent> deviceEvents)?  $default,) {final _that = this;
switch (_that) {
case _DayAgenda() when $default != null:
return $default(_that.tasks,_that.projects,_that.deviceEvents);case _:
  return null;

}
}

}

/// @nodoc


class _DayAgenda extends DayAgenda {
  const _DayAgenda({ List<TaskItem> tasks = const <TaskItem>[],  List<ProjectOverview> projects = const <ProjectOverview>[],  List<DeviceEvent> deviceEvents = const <DeviceEvent>[]}): _tasks = tasks,_projects = projects,_deviceEvents = deviceEvents,super._();
  

 final  List<TaskItem> _tasks;
@override@JsonKey() List<TaskItem> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<ProjectOverview> _projects;
@override@JsonKey() List<ProjectOverview> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

/// Telefon takvimindeki (plan2me dışı) etkinlikler.
 final  List<DeviceEvent> _deviceEvents;
/// Telefon takvimindeki (plan2me dışı) etkinlikler.
@override@JsonKey() List<DeviceEvent> get deviceEvents {
  if (_deviceEvents is EqualUnmodifiableListView) return _deviceEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deviceEvents);
}


/// Create a copy of DayAgenda
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayAgendaCopyWith<_DayAgenda> get copyWith => __$DayAgendaCopyWithImpl<_DayAgenda>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayAgenda&&const DeepCollectionEquality().equals(other.tasks, _tasks)&&const DeepCollectionEquality().equals(other.projects, _projects)&&const DeepCollectionEquality().equals(other.deviceEvents, _deviceEvents));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_deviceEvents));
}

@override
String toString() {
    return 'DayAgenda(tasks: $tasks, projects: $projects, deviceEvents: $deviceEvents)';
}


}

/// @nodoc
abstract mixin class _$DayAgendaCopyWith<$Res> implements $DayAgendaCopyWith<$Res> {
  factory _$DayAgendaCopyWith(_DayAgenda value, $Res Function(_DayAgenda) _then) = __$DayAgendaCopyWithImpl;
@override @useResult
$Res call({
 List<TaskItem> tasks, List<ProjectOverview> projects, List<DeviceEvent> deviceEvents
});




}
/// @nodoc
class __$DayAgendaCopyWithImpl<$Res>
    implements _$DayAgendaCopyWith<$Res> {
  __$DayAgendaCopyWithImpl(this._self, this._then);

  final _DayAgenda _self;
  final $Res Function(_DayAgenda) _then;

/// Create a copy of DayAgenda
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? projects = null,Object? deviceEvents = null,}) {
  return _then(_DayAgenda(
tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskItem>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectOverview>,deviceEvents: null == deviceEvents ? _self._deviceEvents : deviceEvents // ignore: cast_nullable_to_non_nullable
as List<DeviceEvent>,
  ));
}


}

// dart format on
