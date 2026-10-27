// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_sync_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarEventSpec {

/// `card:<id>` ya da `project:<id>`.
 String get key; String get title;/// Sadece-gün (UTC gece yarısı) tarih.
 DateTime get date; String? get description; String? get location;/// Etkinliğe dokununca plan2me'de kaydı açan bağlantı.
 String get url;
/// Create a copy of CalendarEventSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventSpecCopyWith<CalendarEventSpec> get copyWith => _$CalendarEventSpecCopyWithImpl<CalendarEventSpec>(this as CalendarEventSpec, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarEventSpec;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventSpec&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.url, _this.url) || other.url == _this.url));
}


@override
int get hashCode {
  final _this = this as CalendarEventSpec;
  return Object.hash(runtimeType,_this.key,_this.title,_this.date,_this.description,_this.location,_this.url);
}

@override
String toString() {
  final _this = this as CalendarEventSpec;
  return 'CalendarEventSpec(key: ${_this.key}, title: ${_this.title}, date: ${_this.date}, description: ${_this.description}, location: ${_this.location}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $CalendarEventSpecCopyWith<$Res>  {
  factory $CalendarEventSpecCopyWith(CalendarEventSpec value, $Res Function(CalendarEventSpec) _then) = _$CalendarEventSpecCopyWithImpl;
@useResult
$Res call({
 String key, String title, DateTime date, String? description, String? location, String url
});




}
/// @nodoc
class _$CalendarEventSpecCopyWithImpl<$Res>
    implements $CalendarEventSpecCopyWith<$Res> {
  _$CalendarEventSpecCopyWithImpl(this._self, this._then);

  final CalendarEventSpec _self;
  final $Res Function(CalendarEventSpec) _then;

/// Create a copy of CalendarEventSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? title = null,Object? date = null,Object? description = freezed,Object? location = freezed,Object? url = null,}) {
  return _then(CalendarEventSpec(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEventSpec].
extension CalendarEventSpecPatterns on CalendarEventSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEventSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEventSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEventSpec value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEventSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEventSpec value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEventSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String title,  DateTime date,  String? description,  String? location,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEventSpec() when $default != null:
return $default(_that.key,_that.title,_that.date,_that.description,_that.location,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String title,  DateTime date,  String? description,  String? location,  String url)  $default,) {final _that = this;
switch (_that) {
case _CalendarEventSpec():
return $default(_that.key,_that.title,_that.date,_that.description,_that.location,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String title,  DateTime date,  String? description,  String? location,  String url)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEventSpec() when $default != null:
return $default(_that.key,_that.title,_that.date,_that.description,_that.location,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarEventSpec extends CalendarEventSpec {
  const _CalendarEventSpec({required this.key, required this.title, required this.date, this.description, this.location, required this.url}): super._();
  

/// `card:<id>` ya da `project:<id>`.
@override final  String key;
@override final  String title;
/// Sadece-gün (UTC gece yarısı) tarih.
@override final  DateTime date;
@override final  String? description;
@override final  String? location;
/// Etkinliğe dokununca plan2me'de kaydı açan bağlantı.
@override final  String url;

/// Create a copy of CalendarEventSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventSpecCopyWith<_CalendarEventSpec> get copyWith => __$CalendarEventSpecCopyWithImpl<_CalendarEventSpec>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventSpec&&(identical(other.key, key) || other.key == key)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,title,date,description,location,url);
}

@override
String toString() {
    return 'CalendarEventSpec(key: $key, title: $title, date: $date, description: $description, location: $location, url: $url)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventSpecCopyWith<$Res> implements $CalendarEventSpecCopyWith<$Res> {
  factory _$CalendarEventSpecCopyWith(_CalendarEventSpec value, $Res Function(_CalendarEventSpec) _then) = __$CalendarEventSpecCopyWithImpl;
@override @useResult
$Res call({
 String key, String title, DateTime date, String? description, String? location, String url
});




}
/// @nodoc
class __$CalendarEventSpecCopyWithImpl<$Res>
    implements _$CalendarEventSpecCopyWith<$Res> {
  __$CalendarEventSpecCopyWithImpl(this._self, this._then);

  final _CalendarEventSpec _self;
  final $Res Function(_CalendarEventSpec) _then;

/// Create a copy of CalendarEventSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? title = null,Object? date = null,Object? description = freezed,Object? location = freezed,Object? url = null,}) {
  return _then(_CalendarEventSpec(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
