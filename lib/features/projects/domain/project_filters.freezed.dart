// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectFilters {

 String get query; Set<ProjectStatus> get statuses; Set<Priority> get priorities; String? get responsibleId; bool get showClosed; ProjectSort get sort;
/// Create a copy of ProjectFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectFiltersCopyWith<ProjectFilters> get copyWith => _$ProjectFiltersCopyWithImpl<ProjectFilters>(this as ProjectFilters, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProjectFilters;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectFilters&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.statuses, _this.statuses)&&const DeepCollectionEquality().equals(other.priorities, _this.priorities)&&(identical(other.responsibleId, _this.responsibleId) || other.responsibleId == _this.responsibleId)&&(identical(other.showClosed, _this.showClosed) || other.showClosed == _this.showClosed)&&(identical(other.sort, _this.sort) || other.sort == _this.sort));
}


@override
int get hashCode {
  final _this = this as ProjectFilters;
  return Object.hash(runtimeType,_this.query,const DeepCollectionEquality().hash(_this.statuses),const DeepCollectionEquality().hash(_this.priorities),_this.responsibleId,_this.showClosed,_this.sort);
}

@override
String toString() {
  final _this = this as ProjectFilters;
  return 'ProjectFilters(query: ${_this.query}, statuses: ${_this.statuses}, priorities: ${_this.priorities}, responsibleId: ${_this.responsibleId}, showClosed: ${_this.showClosed}, sort: ${_this.sort})';
}


}

/// @nodoc
abstract mixin class $ProjectFiltersCopyWith<$Res>  {
  factory $ProjectFiltersCopyWith(ProjectFilters value, $Res Function(ProjectFilters) _then) = _$ProjectFiltersCopyWithImpl;
@useResult
$Res call({
 String query, Set<ProjectStatus> statuses, Set<Priority> priorities, String? responsibleId, bool showClosed, ProjectSort sort
});




}
/// @nodoc
class _$ProjectFiltersCopyWithImpl<$Res>
    implements $ProjectFiltersCopyWith<$Res> {
  _$ProjectFiltersCopyWithImpl(this._self, this._then);

  final ProjectFilters _self;
  final $Res Function(ProjectFilters) _then;

/// Create a copy of ProjectFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? statuses = null,Object? priorities = null,Object? responsibleId = freezed,Object? showClosed = null,Object? sort = null,}) {
  return _then(ProjectFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as Set<ProjectStatus>,priorities: null == priorities ? _self.priorities : priorities // ignore: cast_nullable_to_non_nullable
as Set<Priority>,responsibleId: freezed == responsibleId ? _self.responsibleId : responsibleId // ignore: cast_nullable_to_non_nullable
as String?,showClosed: null == showClosed ? _self.showClosed : showClosed // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProjectSort,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectFilters].
extension ProjectFiltersPatterns on ProjectFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectFilters value)  $default,){
final _that = this;
switch (_that) {
case _ProjectFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectFilters value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  Set<ProjectStatus> statuses,  Set<Priority> priorities,  String? responsibleId,  bool showClosed,  ProjectSort sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectFilters() when $default != null:
return $default(_that.query,_that.statuses,_that.priorities,_that.responsibleId,_that.showClosed,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  Set<ProjectStatus> statuses,  Set<Priority> priorities,  String? responsibleId,  bool showClosed,  ProjectSort sort)  $default,) {final _that = this;
switch (_that) {
case _ProjectFilters():
return $default(_that.query,_that.statuses,_that.priorities,_that.responsibleId,_that.showClosed,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  Set<ProjectStatus> statuses,  Set<Priority> priorities,  String? responsibleId,  bool showClosed,  ProjectSort sort)?  $default,) {final _that = this;
switch (_that) {
case _ProjectFilters() when $default != null:
return $default(_that.query,_that.statuses,_that.priorities,_that.responsibleId,_that.showClosed,_that.sort);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectFilters extends ProjectFilters {
  const _ProjectFilters({this.query = '',  Set<ProjectStatus> statuses = const <ProjectStatus>{},  Set<Priority> priorities = const <Priority>{}, this.responsibleId, this.showClosed = false, this.sort = ProjectSort.manual}): _statuses = statuses,_priorities = priorities,super._();
  

@override@JsonKey() final  String query;
 final  Set<ProjectStatus> _statuses;
@override@JsonKey() Set<ProjectStatus> get statuses {
  if (_statuses is EqualUnmodifiableSetView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_statuses);
}

 final  Set<Priority> _priorities;
@override@JsonKey() Set<Priority> get priorities {
  if (_priorities is EqualUnmodifiableSetView) return _priorities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_priorities);
}

@override final  String? responsibleId;
@override@JsonKey() final  bool showClosed;
@override@JsonKey() final  ProjectSort sort;

/// Create a copy of ProjectFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectFiltersCopyWith<_ProjectFilters> get copyWith => __$ProjectFiltersCopyWithImpl<_ProjectFilters>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectFilters&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.statuses, _statuses)&&const DeepCollectionEquality().equals(other.priorities, _priorities)&&(identical(other.responsibleId, responsibleId) || other.responsibleId == responsibleId)&&(identical(other.showClosed, showClosed) || other.showClosed == showClosed)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_priorities),responsibleId,showClosed,sort);
}

@override
String toString() {
    return 'ProjectFilters(query: $query, statuses: $statuses, priorities: $priorities, responsibleId: $responsibleId, showClosed: $showClosed, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$ProjectFiltersCopyWith<$Res> implements $ProjectFiltersCopyWith<$Res> {
  factory _$ProjectFiltersCopyWith(_ProjectFilters value, $Res Function(_ProjectFilters) _then) = __$ProjectFiltersCopyWithImpl;
@override @useResult
$Res call({
 String query, Set<ProjectStatus> statuses, Set<Priority> priorities, String? responsibleId, bool showClosed, ProjectSort sort
});




}
/// @nodoc
class __$ProjectFiltersCopyWithImpl<$Res>
    implements _$ProjectFiltersCopyWith<$Res> {
  __$ProjectFiltersCopyWithImpl(this._self, this._then);

  final _ProjectFilters _self;
  final $Res Function(_ProjectFilters) _then;

/// Create a copy of ProjectFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? statuses = null,Object? priorities = null,Object? responsibleId = freezed,Object? showClosed = null,Object? sort = null,}) {
  return _then(_ProjectFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as Set<ProjectStatus>,priorities: null == priorities ? _self._priorities : priorities // ignore: cast_nullable_to_non_nullable
as Set<Priority>,responsibleId: freezed == responsibleId ? _self.responsibleId : responsibleId // ignore: cast_nullable_to_non_nullable
as String?,showClosed: null == showClosed ? _self.showClosed : showClosed // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProjectSort,
  ));
}


}

// dart format on
