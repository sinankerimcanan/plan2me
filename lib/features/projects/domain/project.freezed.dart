// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {

 String get id; String get title; String? get description; Priority get priority; ProjectStatus get status; DateTime? get startDate; DateTime? get dueDate; String? get responsiblePersonId; String? get details; double get position; bool get isInbox; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Project;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.responsiblePersonId, _this.responsiblePersonId) || other.responsiblePersonId == _this.responsiblePersonId)&&(identical(other.details, _this.details) || other.details == _this.details)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.isInbox, _this.isInbox) || other.isInbox == _this.isInbox)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Project;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.priority,_this.status,_this.startDate,_this.dueDate,_this.responsiblePersonId,_this.details,_this.position,_this.isInbox,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Project;
  return 'Project(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, priority: ${_this.priority}, status: ${_this.status}, startDate: ${_this.startDate}, dueDate: ${_this.dueDate}, responsiblePersonId: ${_this.responsiblePersonId}, details: ${_this.details}, position: ${_this.position}, isInbox: ${_this.isInbox}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, Priority priority, ProjectStatus status, DateTime? startDate, DateTime? dueDate, String? responsiblePersonId, String? details, double position, bool isInbox, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? startDate = freezed,Object? dueDate = freezed,Object? responsiblePersonId = freezed,Object? details = freezed,Object? position = null,Object? isInbox = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProjectStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsiblePersonId: freezed == responsiblePersonId ? _self.responsiblePersonId : responsiblePersonId // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,isInbox: null == isInbox ? _self.isInbox : isInbox // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  String? details,  double position,  bool isInbox,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.details,_that.position,_that.isInbox,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  String? details,  double position,  bool isInbox,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.details,_that.position,_that.isInbox,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  String? details,  double position,  bool isInbox,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.details,_that.position,_that.isInbox,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
  const _Project({required this.id, required this.title, this.description, this.priority = Priority.medium, this.status = ProjectStatus.backlog, this.startDate, this.dueDate, this.responsiblePersonId, this.details, this.position = 0, this.isInbox = false, required this.createdAt, required this.updatedAt});
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  Priority priority;
@override@JsonKey() final  ProjectStatus status;
@override final  DateTime? startDate;
@override final  DateTime? dueDate;
@override final  String? responsiblePersonId;
@override final  String? details;
@override@JsonKey() final  double position;
@override@JsonKey() final  bool isInbox;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.responsiblePersonId, responsiblePersonId) || other.responsiblePersonId == responsiblePersonId)&&(identical(other.details, details) || other.details == details)&&(identical(other.position, position) || other.position == position)&&(identical(other.isInbox, isInbox) || other.isInbox == isInbox)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,priority,status,startDate,dueDate,responsiblePersonId,details,position,isInbox,createdAt,updatedAt);
}

@override
String toString() {
    return 'Project(id: $id, title: $title, description: $description, priority: $priority, status: $status, startDate: $startDate, dueDate: $dueDate, responsiblePersonId: $responsiblePersonId, details: $details, position: $position, isInbox: $isInbox, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, Priority priority, ProjectStatus status, DateTime? startDate, DateTime? dueDate, String? responsiblePersonId, String? details, double position, bool isInbox, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? startDate = freezed,Object? dueDate = freezed,Object? responsiblePersonId = freezed,Object? details = freezed,Object? position = null,Object? isInbox = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProjectStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsiblePersonId: freezed == responsiblePersonId ? _self.responsiblePersonId : responsiblePersonId // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as double,isInbox: null == isInbox ? _self.isInbox : isInbox // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$ProjectOverview {

 Project get project; Person? get responsible; List<Person> get requesters; int get totalCards; int get doneCards;
/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectOverviewCopyWith<ProjectOverview> get copyWith => _$ProjectOverviewCopyWithImpl<ProjectOverview>(this as ProjectOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProjectOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectOverview&&(identical(other.project, _this.project) || other.project == _this.project)&&(identical(other.responsible, _this.responsible) || other.responsible == _this.responsible)&&const DeepCollectionEquality().equals(other.requesters, _this.requesters)&&(identical(other.totalCards, _this.totalCards) || other.totalCards == _this.totalCards)&&(identical(other.doneCards, _this.doneCards) || other.doneCards == _this.doneCards));
}


@override
int get hashCode {
  final _this = this as ProjectOverview;
  return Object.hash(runtimeType,_this.project,_this.responsible,const DeepCollectionEquality().hash(_this.requesters),_this.totalCards,_this.doneCards);
}

@override
String toString() {
  final _this = this as ProjectOverview;
  return 'ProjectOverview(project: ${_this.project}, responsible: ${_this.responsible}, requesters: ${_this.requesters}, totalCards: ${_this.totalCards}, doneCards: ${_this.doneCards})';
}


}

/// @nodoc
abstract mixin class $ProjectOverviewCopyWith<$Res>  {
  factory $ProjectOverviewCopyWith(ProjectOverview value, $Res Function(ProjectOverview) _then) = _$ProjectOverviewCopyWithImpl;
@useResult
$Res call({
 Project project, Person? responsible, List<Person> requesters, int totalCards, int doneCards
});


$ProjectCopyWith<$Res> get project;$PersonCopyWith<$Res>? get responsible;

}
/// @nodoc
class _$ProjectOverviewCopyWithImpl<$Res>
    implements $ProjectOverviewCopyWith<$Res> {
  _$ProjectOverviewCopyWithImpl(this._self, this._then);

  final ProjectOverview _self;
  final $Res Function(ProjectOverview) _then;

/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? project = null,Object? responsible = freezed,Object? requesters = null,Object? totalCards = null,Object? doneCards = null,}) {
  return _then(ProjectOverview(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,responsible: freezed == responsible ? _self.responsible : responsible // ignore: cast_nullable_to_non_nullable
as Person?,requesters: null == requesters ? _self.requesters : requesters // ignore: cast_nullable_to_non_nullable
as List<Person>,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,doneCards: null == doneCards ? _self.doneCards : doneCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get responsible {
    if (_self.responsible == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.responsible!, (value) {
    return _then(_self.copyWith(responsible: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectOverview].
extension ProjectOverviewPatterns on ProjectOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectOverview value)  $default,){
final _that = this;
switch (_that) {
case _ProjectOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectOverview value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Project project,  Person? responsible,  List<Person> requesters,  int totalCards,  int doneCards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectOverview() when $default != null:
return $default(_that.project,_that.responsible,_that.requesters,_that.totalCards,_that.doneCards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Project project,  Person? responsible,  List<Person> requesters,  int totalCards,  int doneCards)  $default,) {final _that = this;
switch (_that) {
case _ProjectOverview():
return $default(_that.project,_that.responsible,_that.requesters,_that.totalCards,_that.doneCards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Project project,  Person? responsible,  List<Person> requesters,  int totalCards,  int doneCards)?  $default,) {final _that = this;
switch (_that) {
case _ProjectOverview() when $default != null:
return $default(_that.project,_that.responsible,_that.requesters,_that.totalCards,_that.doneCards);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectOverview extends ProjectOverview {
  const _ProjectOverview({required this.project, this.responsible,  List<Person> requesters = const <Person>[], this.totalCards = 0, this.doneCards = 0}): _requesters = requesters,super._();
  

@override final  Project project;
@override final  Person? responsible;
 final  List<Person> _requesters;
@override@JsonKey() List<Person> get requesters {
  if (_requesters is EqualUnmodifiableListView) return _requesters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requesters);
}

@override@JsonKey() final  int totalCards;
@override@JsonKey() final  int doneCards;

/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectOverviewCopyWith<_ProjectOverview> get copyWith => __$ProjectOverviewCopyWithImpl<_ProjectOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectOverview&&(identical(other.project, project) || other.project == project)&&(identical(other.responsible, responsible) || other.responsible == responsible)&&const DeepCollectionEquality().equals(other.requesters, _requesters)&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.doneCards, doneCards) || other.doneCards == doneCards));
}


@override
int get hashCode {
    return Object.hash(runtimeType,project,responsible,const DeepCollectionEquality().hash(_requesters),totalCards,doneCards);
}

@override
String toString() {
    return 'ProjectOverview(project: $project, responsible: $responsible, requesters: $requesters, totalCards: $totalCards, doneCards: $doneCards)';
}


}

/// @nodoc
abstract mixin class _$ProjectOverviewCopyWith<$Res> implements $ProjectOverviewCopyWith<$Res> {
  factory _$ProjectOverviewCopyWith(_ProjectOverview value, $Res Function(_ProjectOverview) _then) = __$ProjectOverviewCopyWithImpl;
@override @useResult
$Res call({
 Project project, Person? responsible, List<Person> requesters, int totalCards, int doneCards
});


@override $ProjectCopyWith<$Res> get project;@override $PersonCopyWith<$Res>? get responsible;

}
/// @nodoc
class __$ProjectOverviewCopyWithImpl<$Res>
    implements _$ProjectOverviewCopyWith<$Res> {
  __$ProjectOverviewCopyWithImpl(this._self, this._then);

  final _ProjectOverview _self;
  final $Res Function(_ProjectOverview) _then;

/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? project = null,Object? responsible = freezed,Object? requesters = null,Object? totalCards = null,Object? doneCards = null,}) {
  return _then(_ProjectOverview(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,responsible: freezed == responsible ? _self.responsible : responsible // ignore: cast_nullable_to_non_nullable
as Person?,requesters: null == requesters ? _self._requesters : requesters // ignore: cast_nullable_to_non_nullable
as List<Person>,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,doneCards: null == doneCards ? _self.doneCards : doneCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}/// Create a copy of ProjectOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get responsible {
    if (_self.responsible == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.responsible!, (value) {
    return _then(_self.copyWith(responsible: value));
  });
}
}

/// @nodoc
mixin _$ProjectDraft {

 String get title; String? get description; Priority get priority; ProjectStatus get status; DateTime? get startDate; DateTime? get dueDate; String? get responsiblePersonId; List<String> get requesterIds; String? get details;
/// Create a copy of ProjectDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectDraftCopyWith<ProjectDraft> get copyWith => _$ProjectDraftCopyWithImpl<ProjectDraft>(this as ProjectDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProjectDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDraft&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.responsiblePersonId, _this.responsiblePersonId) || other.responsiblePersonId == _this.responsiblePersonId)&&const DeepCollectionEquality().equals(other.requesterIds, _this.requesterIds)&&(identical(other.details, _this.details) || other.details == _this.details));
}


@override
int get hashCode {
  final _this = this as ProjectDraft;
  return Object.hash(runtimeType,_this.title,_this.description,_this.priority,_this.status,_this.startDate,_this.dueDate,_this.responsiblePersonId,const DeepCollectionEquality().hash(_this.requesterIds),_this.details);
}

@override
String toString() {
  final _this = this as ProjectDraft;
  return 'ProjectDraft(title: ${_this.title}, description: ${_this.description}, priority: ${_this.priority}, status: ${_this.status}, startDate: ${_this.startDate}, dueDate: ${_this.dueDate}, responsiblePersonId: ${_this.responsiblePersonId}, requesterIds: ${_this.requesterIds}, details: ${_this.details})';
}


}

/// @nodoc
abstract mixin class $ProjectDraftCopyWith<$Res>  {
  factory $ProjectDraftCopyWith(ProjectDraft value, $Res Function(ProjectDraft) _then) = _$ProjectDraftCopyWithImpl;
@useResult
$Res call({
 String title, String? description, Priority priority, ProjectStatus status, DateTime? startDate, DateTime? dueDate, String? responsiblePersonId, List<String> requesterIds, String? details
});




}
/// @nodoc
class _$ProjectDraftCopyWithImpl<$Res>
    implements $ProjectDraftCopyWith<$Res> {
  _$ProjectDraftCopyWithImpl(this._self, this._then);

  final ProjectDraft _self;
  final $Res Function(ProjectDraft) _then;

/// Create a copy of ProjectDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? startDate = freezed,Object? dueDate = freezed,Object? responsiblePersonId = freezed,Object? requesterIds = null,Object? details = freezed,}) {
  return _then(ProjectDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProjectStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsiblePersonId: freezed == responsiblePersonId ? _self.responsiblePersonId : responsiblePersonId // ignore: cast_nullable_to_non_nullable
as String?,requesterIds: null == requesterIds ? _self.requesterIds : requesterIds // ignore: cast_nullable_to_non_nullable
as List<String>,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectDraft].
extension ProjectDraftPatterns on ProjectDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectDraft value)  $default,){
final _that = this;
switch (_that) {
case _ProjectDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  List<String> requesterIds,  String? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectDraft() when $default != null:
return $default(_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.requesterIds,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  List<String> requesterIds,  String? details)  $default,) {final _that = this;
switch (_that) {
case _ProjectDraft():
return $default(_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.requesterIds,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  Priority priority,  ProjectStatus status,  DateTime? startDate,  DateTime? dueDate,  String? responsiblePersonId,  List<String> requesterIds,  String? details)?  $default,) {final _that = this;
switch (_that) {
case _ProjectDraft() when $default != null:
return $default(_that.title,_that.description,_that.priority,_that.status,_that.startDate,_that.dueDate,_that.responsiblePersonId,_that.requesterIds,_that.details);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectDraft implements ProjectDraft {
  const _ProjectDraft({this.title = '', this.description, this.priority = Priority.medium, this.status = ProjectStatus.backlog, this.startDate, this.dueDate, this.responsiblePersonId,  List<String> requesterIds = const <String>[], this.details}): _requesterIds = requesterIds;
  

@override@JsonKey() final  String title;
@override final  String? description;
@override@JsonKey() final  Priority priority;
@override@JsonKey() final  ProjectStatus status;
@override final  DateTime? startDate;
@override final  DateTime? dueDate;
@override final  String? responsiblePersonId;
 final  List<String> _requesterIds;
@override@JsonKey() List<String> get requesterIds {
  if (_requesterIds is EqualUnmodifiableListView) return _requesterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requesterIds);
}

@override final  String? details;

/// Create a copy of ProjectDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectDraftCopyWith<_ProjectDraft> get copyWith => __$ProjectDraftCopyWithImpl<_ProjectDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.responsiblePersonId, responsiblePersonId) || other.responsiblePersonId == responsiblePersonId)&&const DeepCollectionEquality().equals(other.requesterIds, _requesterIds)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,priority,status,startDate,dueDate,responsiblePersonId,const DeepCollectionEquality().hash(_requesterIds),details);
}

@override
String toString() {
    return 'ProjectDraft(title: $title, description: $description, priority: $priority, status: $status, startDate: $startDate, dueDate: $dueDate, responsiblePersonId: $responsiblePersonId, requesterIds: $requesterIds, details: $details)';
}


}

/// @nodoc
abstract mixin class _$ProjectDraftCopyWith<$Res> implements $ProjectDraftCopyWith<$Res> {
  factory _$ProjectDraftCopyWith(_ProjectDraft value, $Res Function(_ProjectDraft) _then) = __$ProjectDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, Priority priority, ProjectStatus status, DateTime? startDate, DateTime? dueDate, String? responsiblePersonId, List<String> requesterIds, String? details
});




}
/// @nodoc
class __$ProjectDraftCopyWithImpl<$Res>
    implements _$ProjectDraftCopyWith<$Res> {
  __$ProjectDraftCopyWithImpl(this._self, this._then);

  final _ProjectDraft _self;
  final $Res Function(_ProjectDraft) _then;

/// Create a copy of ProjectDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? startDate = freezed,Object? dueDate = freezed,Object? responsiblePersonId = freezed,Object? requesterIds = null,Object? details = freezed,}) {
  return _then(_ProjectDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProjectStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsiblePersonId: freezed == responsiblePersonId ? _self.responsiblePersonId : responsiblePersonId // ignore: cast_nullable_to_non_nullable
as String?,requesterIds: null == requesterIds ? _self._requesterIds : requesterIds // ignore: cast_nullable_to_non_nullable
as List<String>,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
