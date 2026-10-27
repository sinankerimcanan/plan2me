// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trash_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrashItem {

 TrashKind get kind; String get id; String get title; String? get subtitle; DateTime get deletedAt;
/// Create a copy of TrashItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrashItemCopyWith<TrashItem> get copyWith => _$TrashItemCopyWithImpl<TrashItem>(this as TrashItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TrashItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrashItem&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.deletedAt, _this.deletedAt) || other.deletedAt == _this.deletedAt));
}


@override
int get hashCode {
  final _this = this as TrashItem;
  return Object.hash(runtimeType,_this.kind,_this.id,_this.title,_this.subtitle,_this.deletedAt);
}

@override
String toString() {
  final _this = this as TrashItem;
  return 'TrashItem(kind: ${_this.kind}, id: ${_this.id}, title: ${_this.title}, subtitle: ${_this.subtitle}, deletedAt: ${_this.deletedAt})';
}


}

/// @nodoc
abstract mixin class $TrashItemCopyWith<$Res>  {
  factory $TrashItemCopyWith(TrashItem value, $Res Function(TrashItem) _then) = _$TrashItemCopyWithImpl;
@useResult
$Res call({
 TrashKind kind, String id, String title, String? subtitle, DateTime deletedAt
});




}
/// @nodoc
class _$TrashItemCopyWithImpl<$Res>
    implements $TrashItemCopyWith<$Res> {
  _$TrashItemCopyWithImpl(this._self, this._then);

  final TrashItem _self;
  final $Res Function(TrashItem) _then;

/// Create a copy of TrashItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? id = null,Object? title = null,Object? subtitle = freezed,Object? deletedAt = null,}) {
  return _then(TrashItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TrashKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: null == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TrashItem].
extension TrashItemPatterns on TrashItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrashItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrashItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrashItem value)  $default,){
final _that = this;
switch (_that) {
case _TrashItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrashItem value)?  $default,){
final _that = this;
switch (_that) {
case _TrashItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrashKind kind,  String id,  String title,  String? subtitle,  DateTime deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrashItem() when $default != null:
return $default(_that.kind,_that.id,_that.title,_that.subtitle,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrashKind kind,  String id,  String title,  String? subtitle,  DateTime deletedAt)  $default,) {final _that = this;
switch (_that) {
case _TrashItem():
return $default(_that.kind,_that.id,_that.title,_that.subtitle,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrashKind kind,  String id,  String title,  String? subtitle,  DateTime deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrashItem() when $default != null:
return $default(_that.kind,_that.id,_that.title,_that.subtitle,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TrashItem implements TrashItem {
  const _TrashItem({required this.kind, required this.id, required this.title, this.subtitle, required this.deletedAt});
  

@override final  TrashKind kind;
@override final  String id;
@override final  String title;
@override final  String? subtitle;
@override final  DateTime deletedAt;

/// Create a copy of TrashItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrashItemCopyWith<_TrashItem> get copyWith => __$TrashItemCopyWithImpl<_TrashItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrashItem&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,id,title,subtitle,deletedAt);
}

@override
String toString() {
    return 'TrashItem(kind: $kind, id: $id, title: $title, subtitle: $subtitle, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TrashItemCopyWith<$Res> implements $TrashItemCopyWith<$Res> {
  factory _$TrashItemCopyWith(_TrashItem value, $Res Function(_TrashItem) _then) = __$TrashItemCopyWithImpl;
@override @useResult
$Res call({
 TrashKind kind, String id, String title, String? subtitle, DateTime deletedAt
});




}
/// @nodoc
class __$TrashItemCopyWithImpl<$Res>
    implements _$TrashItemCopyWith<$Res> {
  __$TrashItemCopyWithImpl(this._self, this._then);

  final _TrashItem _self;
  final $Res Function(_TrashItem) _then;

/// Create a copy of TrashItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? id = null,Object? title = null,Object? subtitle = freezed,Object? deletedAt = null,}) {
  return _then(_TrashItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TrashKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: null == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
