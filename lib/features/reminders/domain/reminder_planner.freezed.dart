// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_planner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannedReminder {

 DateTime get when; String get title; String? get body;/// Bildirime dokununca açılacak uygulama rotası.
 String get route;
/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedReminderCopyWith<PlannedReminder> get copyWith => _$PlannedReminderCopyWithImpl<PlannedReminder>(this as PlannedReminder, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlannedReminder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedReminder&&(identical(other.when, _this.when) || other.when == _this.when)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.route, _this.route) || other.route == _this.route));
}


@override
int get hashCode {
  final _this = this as PlannedReminder;
  return Object.hash(runtimeType,_this.when,_this.title,_this.body,_this.route);
}

@override
String toString() {
  final _this = this as PlannedReminder;
  return 'PlannedReminder(when: ${_this.when}, title: ${_this.title}, body: ${_this.body}, route: ${_this.route})';
}


}

/// @nodoc
abstract mixin class $PlannedReminderCopyWith<$Res>  {
  factory $PlannedReminderCopyWith(PlannedReminder value, $Res Function(PlannedReminder) _then) = _$PlannedReminderCopyWithImpl;
@useResult
$Res call({
 DateTime when, String title, String? body, String route
});




}
/// @nodoc
class _$PlannedReminderCopyWithImpl<$Res>
    implements $PlannedReminderCopyWith<$Res> {
  _$PlannedReminderCopyWithImpl(this._self, this._then);

  final PlannedReminder _self;
  final $Res Function(PlannedReminder) _then;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? when = null,Object? title = null,Object? body = freezed,Object? route = null,}) {
  return _then(PlannedReminder(
when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedReminder].
extension PlannedReminderPatterns on PlannedReminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedReminder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedReminder value)  $default,){
final _that = this;
switch (_that) {
case _PlannedReminder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedReminder value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime when,  String title,  String? body,  String route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
return $default(_that.when,_that.title,_that.body,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime when,  String title,  String? body,  String route)  $default,) {final _that = this;
switch (_that) {
case _PlannedReminder():
return $default(_that.when,_that.title,_that.body,_that.route);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime when,  String title,  String? body,  String route)?  $default,) {final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
return $default(_that.when,_that.title,_that.body,_that.route);case _:
  return null;

}
}

}

/// @nodoc


class _PlannedReminder implements PlannedReminder {
  const _PlannedReminder({required this.when, required this.title, this.body, required this.route});
  

@override final  DateTime when;
@override final  String title;
@override final  String? body;
/// Bildirime dokununca açılacak uygulama rotası.
@override final  String route;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedReminderCopyWith<_PlannedReminder> get copyWith => __$PlannedReminderCopyWithImpl<_PlannedReminder>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedReminder&&(identical(other.when, when) || other.when == when)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,when,title,body,route);
}

@override
String toString() {
    return 'PlannedReminder(when: $when, title: $title, body: $body, route: $route)';
}


}

/// @nodoc
abstract mixin class _$PlannedReminderCopyWith<$Res> implements $PlannedReminderCopyWith<$Res> {
  factory _$PlannedReminderCopyWith(_PlannedReminder value, $Res Function(_PlannedReminder) _then) = __$PlannedReminderCopyWithImpl;
@override @useResult
$Res call({
 DateTime when, String title, String? body, String route
});




}
/// @nodoc
class __$PlannedReminderCopyWithImpl<$Res>
    implements _$PlannedReminderCopyWith<$Res> {
  __$PlannedReminderCopyWithImpl(this._self, this._then);

  final _PlannedReminder _self;
  final $Res Function(_PlannedReminder) _then;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? when = null,Object? title = null,Object? body = freezed,Object? route = null,}) {
  return _then(_PlannedReminder(
when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
