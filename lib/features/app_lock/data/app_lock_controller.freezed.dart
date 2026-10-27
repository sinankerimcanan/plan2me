// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_lock_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppLockState implements DiagnosticableTreeMixin {

 bool get enabled; bool get locked;
/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLockStateCopyWith<AppLockState> get copyWith => _$AppLockStateCopyWithImpl<AppLockState>(this as AppLockState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as AppLockState;
  properties
    ..add(DiagnosticsProperty('type', 'AppLockState'))
    ..add(DiagnosticsProperty('enabled', _this.enabled))..add(DiagnosticsProperty('locked', _this.locked));
}

@override
bool operator ==(Object other) {
  final _this = this as AppLockState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLockState&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.locked, _this.locked) || other.locked == _this.locked));
}


@override
int get hashCode {
  final _this = this as AppLockState;
  return Object.hash(runtimeType,_this.enabled,_this.locked);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as AppLockState;
  return 'AppLockState(enabled: ${_this.enabled}, locked: ${_this.locked})';
}


}

/// @nodoc
abstract mixin class $AppLockStateCopyWith<$Res>  {
  factory $AppLockStateCopyWith(AppLockState value, $Res Function(AppLockState) _then) = _$AppLockStateCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool locked
});




}
/// @nodoc
class _$AppLockStateCopyWithImpl<$Res>
    implements $AppLockStateCopyWith<$Res> {
  _$AppLockStateCopyWithImpl(this._self, this._then);

  final AppLockState _self;
  final $Res Function(AppLockState) _then;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? locked = null,}) {
  return _then(AppLockState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLockState].
extension AppLockStatePatterns on AppLockState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppLockState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppLockState value)  $default,){
final _that = this;
switch (_that) {
case _AppLockState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppLockState value)?  $default,){
final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool locked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
return $default(_that.enabled,_that.locked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool locked)  $default,) {final _that = this;
switch (_that) {
case _AppLockState():
return $default(_that.enabled,_that.locked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool locked)?  $default,) {final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
return $default(_that.enabled,_that.locked);case _:
  return null;

}
}

}

/// @nodoc


class _AppLockState with DiagnosticableTreeMixin implements AppLockState {
  const _AppLockState({this.enabled = false, this.locked = false});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool locked;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppLockStateCopyWith<_AppLockState> get copyWith => __$AppLockStateCopyWithImpl<_AppLockState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'AppLockState'))
    ..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('locked', locked));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppLockState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.locked, locked) || other.locked == locked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,locked);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'AppLockState(enabled: $enabled, locked: $locked)';
}


}

/// @nodoc
abstract mixin class _$AppLockStateCopyWith<$Res> implements $AppLockStateCopyWith<$Res> {
  factory _$AppLockStateCopyWith(_AppLockState value, $Res Function(_AppLockState) _then) = __$AppLockStateCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool locked
});




}
/// @nodoc
class __$AppLockStateCopyWithImpl<$Res>
    implements _$AppLockStateCopyWith<$Res> {
  __$AppLockStateCopyWithImpl(this._self, this._then);

  final _AppLockState _self;
  final $Res Function(_AppLockState) _then;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? locked = null,}) {
  return _then(_AppLockState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
