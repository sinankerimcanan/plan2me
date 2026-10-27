// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_sync_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarSyncSettings implements DiagnosticableTreeMixin {

 bool get enabled; bool get showDeviceEvents; String? get calendarId;
/// Create a copy of CalendarSyncSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarSyncSettingsCopyWith<CalendarSyncSettings> get copyWith => _$CalendarSyncSettingsCopyWithImpl<CalendarSyncSettings>(this as CalendarSyncSettings, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as CalendarSyncSettings;
  properties
    ..add(DiagnosticsProperty('type', 'CalendarSyncSettings'))
    ..add(DiagnosticsProperty('enabled', _this.enabled))..add(DiagnosticsProperty('showDeviceEvents', _this.showDeviceEvents))..add(DiagnosticsProperty('calendarId', _this.calendarId));
}

@override
bool operator ==(Object other) {
  final _this = this as CalendarSyncSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarSyncSettings&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.showDeviceEvents, _this.showDeviceEvents) || other.showDeviceEvents == _this.showDeviceEvents)&&(identical(other.calendarId, _this.calendarId) || other.calendarId == _this.calendarId));
}


@override
int get hashCode {
  final _this = this as CalendarSyncSettings;
  return Object.hash(runtimeType,_this.enabled,_this.showDeviceEvents,_this.calendarId);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as CalendarSyncSettings;
  return 'CalendarSyncSettings(enabled: ${_this.enabled}, showDeviceEvents: ${_this.showDeviceEvents}, calendarId: ${_this.calendarId})';
}


}

/// @nodoc
abstract mixin class $CalendarSyncSettingsCopyWith<$Res>  {
  factory $CalendarSyncSettingsCopyWith(CalendarSyncSettings value, $Res Function(CalendarSyncSettings) _then) = _$CalendarSyncSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool showDeviceEvents, String? calendarId
});




}
/// @nodoc
class _$CalendarSyncSettingsCopyWithImpl<$Res>
    implements $CalendarSyncSettingsCopyWith<$Res> {
  _$CalendarSyncSettingsCopyWithImpl(this._self, this._then);

  final CalendarSyncSettings _self;
  final $Res Function(CalendarSyncSettings) _then;

/// Create a copy of CalendarSyncSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? showDeviceEvents = null,Object? calendarId = freezed,}) {
  return _then(CalendarSyncSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,showDeviceEvents: null == showDeviceEvents ? _self.showDeviceEvents : showDeviceEvents // ignore: cast_nullable_to_non_nullable
as bool,calendarId: freezed == calendarId ? _self.calendarId : calendarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarSyncSettings].
extension CalendarSyncSettingsPatterns on CalendarSyncSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarSyncSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarSyncSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarSyncSettings value)  $default,){
final _that = this;
switch (_that) {
case _CalendarSyncSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarSyncSettings value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarSyncSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool showDeviceEvents,  String? calendarId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarSyncSettings() when $default != null:
return $default(_that.enabled,_that.showDeviceEvents,_that.calendarId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool showDeviceEvents,  String? calendarId)  $default,) {final _that = this;
switch (_that) {
case _CalendarSyncSettings():
return $default(_that.enabled,_that.showDeviceEvents,_that.calendarId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool showDeviceEvents,  String? calendarId)?  $default,) {final _that = this;
switch (_that) {
case _CalendarSyncSettings() when $default != null:
return $default(_that.enabled,_that.showDeviceEvents,_that.calendarId);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarSyncSettings with DiagnosticableTreeMixin implements CalendarSyncSettings {
  const _CalendarSyncSettings({this.enabled = false, this.showDeviceEvents = false, this.calendarId});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool showDeviceEvents;
@override final  String? calendarId;

/// Create a copy of CalendarSyncSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarSyncSettingsCopyWith<_CalendarSyncSettings> get copyWith => __$CalendarSyncSettingsCopyWithImpl<_CalendarSyncSettings>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'CalendarSyncSettings'))
    ..add(DiagnosticsProperty('enabled', enabled))..add(DiagnosticsProperty('showDeviceEvents', showDeviceEvents))..add(DiagnosticsProperty('calendarId', calendarId));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarSyncSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.showDeviceEvents, showDeviceEvents) || other.showDeviceEvents == showDeviceEvents)&&(identical(other.calendarId, calendarId) || other.calendarId == calendarId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,showDeviceEvents,calendarId);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'CalendarSyncSettings(enabled: $enabled, showDeviceEvents: $showDeviceEvents, calendarId: $calendarId)';
}


}

/// @nodoc
abstract mixin class _$CalendarSyncSettingsCopyWith<$Res> implements $CalendarSyncSettingsCopyWith<$Res> {
  factory _$CalendarSyncSettingsCopyWith(_CalendarSyncSettings value, $Res Function(_CalendarSyncSettings) _then) = __$CalendarSyncSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool showDeviceEvents, String? calendarId
});




}
/// @nodoc
class __$CalendarSyncSettingsCopyWithImpl<$Res>
    implements _$CalendarSyncSettingsCopyWith<$Res> {
  __$CalendarSyncSettingsCopyWithImpl(this._self, this._then);

  final _CalendarSyncSettings _self;
  final $Res Function(_CalendarSyncSettings) _then;

/// Create a copy of CalendarSyncSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? showDeviceEvents = null,Object? calendarId = freezed,}) {
  return _then(_CalendarSyncSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,showDeviceEvents: null == showDeviceEvents ? _self.showDeviceEvents : showDeviceEvents // ignore: cast_nullable_to_non_nullable
as bool,calendarId: freezed == calendarId ? _self.calendarId : calendarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
