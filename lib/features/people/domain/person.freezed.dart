// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Person {

 String get id; String get name; String? get email; String? get role; String? get colorHex; bool get isMe; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);

  /// Serializes this Person to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Person;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.isMe, _this.isMe) || other.isMe == _this.isMe)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Person;
  return Object.hash(runtimeType,_this.id,_this.name,_this.email,_this.role,_this.colorHex,_this.isMe,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Person;
  return 'Person(id: ${_this.id}, name: ${_this.name}, email: ${_this.email}, role: ${_this.role}, colorHex: ${_this.colorHex}, isMe: ${_this.isMe}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? email, String? role, String? colorHex, bool isMe, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? role = freezed,Object? colorHex = freezed,Object? isMe = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Person(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? email,  String? role,  String? colorHex,  bool isMe,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.role,_that.colorHex,_that.isMe,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? email,  String? role,  String? colorHex,  bool isMe,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Person():
return $default(_that.id,_that.name,_that.email,_that.role,_that.colorHex,_that.isMe,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? email,  String? role,  String? colorHex,  bool isMe,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.role,_that.colorHex,_that.isMe,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Person extends Person {
  const _Person({required this.id, required this.name, this.email, this.role, this.colorHex, this.isMe = false, required this.createdAt, required this.updatedAt}): super._();
  factory _Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? email;
@override final  String? role;
@override final  String? colorHex;
@override@JsonKey() final  bool isMe;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,email,role,colorHex,isMe,createdAt,updatedAt);
}

@override
String toString() {
    return 'Person(id: $id, name: $name, email: $email, role: $role, colorHex: $colorHex, isMe: $isMe, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? email, String? role, String? colorHex, bool isMe, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? role = freezed,Object? colorHex = freezed,Object? isMe = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Person(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$PersonOverview {

 Person get person; int get responsibleCount; int get requestedCount;
/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonOverviewCopyWith<PersonOverview> get copyWith => _$PersonOverviewCopyWithImpl<PersonOverview>(this as PersonOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PersonOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonOverview&&(identical(other.person, _this.person) || other.person == _this.person)&&(identical(other.responsibleCount, _this.responsibleCount) || other.responsibleCount == _this.responsibleCount)&&(identical(other.requestedCount, _this.requestedCount) || other.requestedCount == _this.requestedCount));
}


@override
int get hashCode {
  final _this = this as PersonOverview;
  return Object.hash(runtimeType,_this.person,_this.responsibleCount,_this.requestedCount);
}

@override
String toString() {
  final _this = this as PersonOverview;
  return 'PersonOverview(person: ${_this.person}, responsibleCount: ${_this.responsibleCount}, requestedCount: ${_this.requestedCount})';
}


}

/// @nodoc
abstract mixin class $PersonOverviewCopyWith<$Res>  {
  factory $PersonOverviewCopyWith(PersonOverview value, $Res Function(PersonOverview) _then) = _$PersonOverviewCopyWithImpl;
@useResult
$Res call({
 Person person, int responsibleCount, int requestedCount
});


$PersonCopyWith<$Res> get person;

}
/// @nodoc
class _$PersonOverviewCopyWithImpl<$Res>
    implements $PersonOverviewCopyWith<$Res> {
  _$PersonOverviewCopyWithImpl(this._self, this._then);

  final PersonOverview _self;
  final $Res Function(PersonOverview) _then;

/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? person = null,Object? responsibleCount = null,Object? requestedCount = null,}) {
  return _then(PersonOverview(
person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as Person,responsibleCount: null == responsibleCount ? _self.responsibleCount : responsibleCount // ignore: cast_nullable_to_non_nullable
as int,requestedCount: null == requestedCount ? _self.requestedCount : requestedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get person {
  
  return $PersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonOverview].
extension PersonOverviewPatterns on PersonOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonOverview value)  $default,){
final _that = this;
switch (_that) {
case _PersonOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonOverview value)?  $default,){
final _that = this;
switch (_that) {
case _PersonOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Person person,  int responsibleCount,  int requestedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonOverview() when $default != null:
return $default(_that.person,_that.responsibleCount,_that.requestedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Person person,  int responsibleCount,  int requestedCount)  $default,) {final _that = this;
switch (_that) {
case _PersonOverview():
return $default(_that.person,_that.responsibleCount,_that.requestedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Person person,  int responsibleCount,  int requestedCount)?  $default,) {final _that = this;
switch (_that) {
case _PersonOverview() when $default != null:
return $default(_that.person,_that.responsibleCount,_that.requestedCount);case _:
  return null;

}
}

}

/// @nodoc


class _PersonOverview implements PersonOverview {
  const _PersonOverview({required this.person, this.responsibleCount = 0, this.requestedCount = 0});
  

@override final  Person person;
@override@JsonKey() final  int responsibleCount;
@override@JsonKey() final  int requestedCount;

/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonOverviewCopyWith<_PersonOverview> get copyWith => __$PersonOverviewCopyWithImpl<_PersonOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonOverview&&(identical(other.person, person) || other.person == person)&&(identical(other.responsibleCount, responsibleCount) || other.responsibleCount == responsibleCount)&&(identical(other.requestedCount, requestedCount) || other.requestedCount == requestedCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,person,responsibleCount,requestedCount);
}

@override
String toString() {
    return 'PersonOverview(person: $person, responsibleCount: $responsibleCount, requestedCount: $requestedCount)';
}


}

/// @nodoc
abstract mixin class _$PersonOverviewCopyWith<$Res> implements $PersonOverviewCopyWith<$Res> {
  factory _$PersonOverviewCopyWith(_PersonOverview value, $Res Function(_PersonOverview) _then) = __$PersonOverviewCopyWithImpl;
@override @useResult
$Res call({
 Person person, int responsibleCount, int requestedCount
});


@override $PersonCopyWith<$Res> get person;

}
/// @nodoc
class __$PersonOverviewCopyWithImpl<$Res>
    implements _$PersonOverviewCopyWith<$Res> {
  __$PersonOverviewCopyWithImpl(this._self, this._then);

  final _PersonOverview _self;
  final $Res Function(_PersonOverview) _then;

/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? person = null,Object? responsibleCount = null,Object? requestedCount = null,}) {
  return _then(_PersonOverview(
person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as Person,responsibleCount: null == responsibleCount ? _self.responsibleCount : responsibleCount // ignore: cast_nullable_to_non_nullable
as int,requestedCount: null == requestedCount ? _self.requestedCount : requestedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PersonOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get person {
  
  return $PersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}

/// @nodoc
mixin _$PersonInput {

 String get name; String? get email; String? get role; String? get colorHex; bool get isMe;
/// Create a copy of PersonInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonInputCopyWith<PersonInput> get copyWith => _$PersonInputCopyWithImpl<PersonInput>(this as PersonInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PersonInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonInput&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.isMe, _this.isMe) || other.isMe == _this.isMe));
}


@override
int get hashCode {
  final _this = this as PersonInput;
  return Object.hash(runtimeType,_this.name,_this.email,_this.role,_this.colorHex,_this.isMe);
}

@override
String toString() {
  final _this = this as PersonInput;
  return 'PersonInput(name: ${_this.name}, email: ${_this.email}, role: ${_this.role}, colorHex: ${_this.colorHex}, isMe: ${_this.isMe})';
}


}

/// @nodoc
abstract mixin class $PersonInputCopyWith<$Res>  {
  factory $PersonInputCopyWith(PersonInput value, $Res Function(PersonInput) _then) = _$PersonInputCopyWithImpl;
@useResult
$Res call({
 String name, String? email, String? role, String? colorHex, bool isMe
});




}
/// @nodoc
class _$PersonInputCopyWithImpl<$Res>
    implements $PersonInputCopyWith<$Res> {
  _$PersonInputCopyWithImpl(this._self, this._then);

  final PersonInput _self;
  final $Res Function(PersonInput) _then;

/// Create a copy of PersonInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = freezed,Object? role = freezed,Object? colorHex = freezed,Object? isMe = null,}) {
  return _then(PersonInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonInput].
extension PersonInputPatterns on PersonInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonInput value)  $default,){
final _that = this;
switch (_that) {
case _PersonInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonInput value)?  $default,){
final _that = this;
switch (_that) {
case _PersonInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? email,  String? role,  String? colorHex,  bool isMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonInput() when $default != null:
return $default(_that.name,_that.email,_that.role,_that.colorHex,_that.isMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? email,  String? role,  String? colorHex,  bool isMe)  $default,) {final _that = this;
switch (_that) {
case _PersonInput():
return $default(_that.name,_that.email,_that.role,_that.colorHex,_that.isMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? email,  String? role,  String? colorHex,  bool isMe)?  $default,) {final _that = this;
switch (_that) {
case _PersonInput() when $default != null:
return $default(_that.name,_that.email,_that.role,_that.colorHex,_that.isMe);case _:
  return null;

}
}

}

/// @nodoc


class _PersonInput implements PersonInput {
  const _PersonInput({required this.name, this.email, this.role, this.colorHex, this.isMe = false});
  

@override final  String name;
@override final  String? email;
@override final  String? role;
@override final  String? colorHex;
@override@JsonKey() final  bool isMe;

/// Create a copy of PersonInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonInputCopyWith<_PersonInput> get copyWith => __$PersonInputCopyWithImpl<_PersonInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonInput&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isMe, isMe) || other.isMe == isMe));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,email,role,colorHex,isMe);
}

@override
String toString() {
    return 'PersonInput(name: $name, email: $email, role: $role, colorHex: $colorHex, isMe: $isMe)';
}


}

/// @nodoc
abstract mixin class _$PersonInputCopyWith<$Res> implements $PersonInputCopyWith<$Res> {
  factory _$PersonInputCopyWith(_PersonInput value, $Res Function(_PersonInput) _then) = __$PersonInputCopyWithImpl;
@override @useResult
$Res call({
 String name, String? email, String? role, String? colorHex, bool isMe
});




}
/// @nodoc
class __$PersonInputCopyWithImpl<$Res>
    implements _$PersonInputCopyWith<$Res> {
  __$PersonInputCopyWithImpl(this._self, this._then);

  final _PersonInput _self;
  final $Res Function(_PersonInput) _then;

/// Create a copy of PersonInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = freezed,Object? role = freezed,Object? colorHex = freezed,Object? isMe = null,}) {
  return _then(_PersonInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
