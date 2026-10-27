// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetSnapshot {

 int get v; String get generatedAt; WidgetStats get stats;/// Tüm açık projelerin son tarihleri (yyyy-MM-dd). Widget, gecikmiş ve bu hafta
/// sayılarını render anında bugüne göre hesaplar (gece yarısı güncel kalır).
 List<String> get activeDueDates; List<WidgetProject> get projects; List<WidgetCard> get cards;
/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetSnapshotCopyWith<WidgetSnapshot> get copyWith => _$WidgetSnapshotCopyWithImpl<WidgetSnapshot>(this as WidgetSnapshot, _$identity);

  /// Serializes this WidgetSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WidgetSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetSnapshot&&(identical(other.v, _this.v) || other.v == _this.v)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt)&&(identical(other.stats, _this.stats) || other.stats == _this.stats)&&const DeepCollectionEquality().equals(other.activeDueDates, _this.activeDueDates)&&const DeepCollectionEquality().equals(other.projects, _this.projects)&&const DeepCollectionEquality().equals(other.cards, _this.cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WidgetSnapshot;
  return Object.hash(runtimeType,_this.v,_this.generatedAt,_this.stats,const DeepCollectionEquality().hash(_this.activeDueDates),const DeepCollectionEquality().hash(_this.projects),const DeepCollectionEquality().hash(_this.cards));
}

@override
String toString() {
  final _this = this as WidgetSnapshot;
  return 'WidgetSnapshot(v: ${_this.v}, generatedAt: ${_this.generatedAt}, stats: ${_this.stats}, activeDueDates: ${_this.activeDueDates}, projects: ${_this.projects}, cards: ${_this.cards})';
}


}

/// @nodoc
abstract mixin class $WidgetSnapshotCopyWith<$Res>  {
  factory $WidgetSnapshotCopyWith(WidgetSnapshot value, $Res Function(WidgetSnapshot) _then) = _$WidgetSnapshotCopyWithImpl;
@useResult
$Res call({
 int v, String generatedAt, WidgetStats stats, List<String> activeDueDates, List<WidgetProject> projects, List<WidgetCard> cards
});


$WidgetStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$WidgetSnapshotCopyWithImpl<$Res>
    implements $WidgetSnapshotCopyWith<$Res> {
  _$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final WidgetSnapshot _self;
  final $Res Function(WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? v = null,Object? generatedAt = null,Object? stats = null,Object? activeDueDates = null,Object? projects = null,Object? cards = null,}) {
  return _then(WidgetSnapshot(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as WidgetStats,activeDueDates: null == activeDueDates ? _self.activeDueDates : activeDueDates // ignore: cast_nullable_to_non_nullable
as List<String>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<WidgetProject>,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<WidgetCard>,
  ));
}
/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WidgetStatsCopyWith<$Res> get stats {
  
  return $WidgetStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [WidgetSnapshot].
extension WidgetSnapshotPatterns on WidgetSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int v,  String generatedAt,  WidgetStats stats,  List<String> activeDueDates,  List<WidgetProject> projects,  List<WidgetCard> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.v,_that.generatedAt,_that.stats,_that.activeDueDates,_that.projects,_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int v,  String generatedAt,  WidgetStats stats,  List<String> activeDueDates,  List<WidgetProject> projects,  List<WidgetCard> cards)  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot():
return $default(_that.v,_that.generatedAt,_that.stats,_that.activeDueDates,_that.projects,_that.cards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int v,  String generatedAt,  WidgetStats stats,  List<String> activeDueDates,  List<WidgetProject> projects,  List<WidgetCard> cards)?  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.v,_that.generatedAt,_that.stats,_that.activeDueDates,_that.projects,_that.cards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WidgetSnapshot implements WidgetSnapshot {
  const _WidgetSnapshot({this.v = kWidgetSnapshotVersion, required this.generatedAt, required this.stats,  List<String> activeDueDates = const <String>[],  List<WidgetProject> projects = const <WidgetProject>[],  List<WidgetCard> cards = const <WidgetCard>[]}): _activeDueDates = activeDueDates,_projects = projects,_cards = cards;
  factory _WidgetSnapshot.fromJson(Map<String, dynamic> json) => _$WidgetSnapshotFromJson(json);

@override@JsonKey() final  int v;
@override final  String generatedAt;
@override final  WidgetStats stats;
/// Tüm açık projelerin son tarihleri (yyyy-MM-dd). Widget, gecikmiş ve bu hafta
/// sayılarını render anında bugüne göre hesaplar (gece yarısı güncel kalır).
 final  List<String> _activeDueDates;
/// Tüm açık projelerin son tarihleri (yyyy-MM-dd). Widget, gecikmiş ve bu hafta
/// sayılarını render anında bugüne göre hesaplar (gece yarısı güncel kalır).
@override@JsonKey() List<String> get activeDueDates {
  if (_activeDueDates is EqualUnmodifiableListView) return _activeDueDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeDueDates);
}

 final  List<WidgetProject> _projects;
@override@JsonKey() List<WidgetProject> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<WidgetCard> _cards;
@override@JsonKey() List<WidgetCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetSnapshotCopyWith<_WidgetSnapshot> get copyWith => __$WidgetSnapshotCopyWithImpl<_WidgetSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WidgetSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetSnapshot&&(identical(other.v, v) || other.v == v)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.activeDueDates, _activeDueDates)&&const DeepCollectionEquality().equals(other.projects, _projects)&&const DeepCollectionEquality().equals(other.cards, _cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,v,generatedAt,stats,const DeepCollectionEquality().hash(_activeDueDates),const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_cards));
}

@override
String toString() {
    return 'WidgetSnapshot(v: $v, generatedAt: $generatedAt, stats: $stats, activeDueDates: $activeDueDates, projects: $projects, cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$WidgetSnapshotCopyWith<$Res> implements $WidgetSnapshotCopyWith<$Res> {
  factory _$WidgetSnapshotCopyWith(_WidgetSnapshot value, $Res Function(_WidgetSnapshot) _then) = __$WidgetSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int v, String generatedAt, WidgetStats stats, List<String> activeDueDates, List<WidgetProject> projects, List<WidgetCard> cards
});


@override $WidgetStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$WidgetSnapshotCopyWithImpl<$Res>
    implements _$WidgetSnapshotCopyWith<$Res> {
  __$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final _WidgetSnapshot _self;
  final $Res Function(_WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? v = null,Object? generatedAt = null,Object? stats = null,Object? activeDueDates = null,Object? projects = null,Object? cards = null,}) {
  return _then(_WidgetSnapshot(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as WidgetStats,activeDueDates: null == activeDueDates ? _self._activeDueDates : activeDueDates // ignore: cast_nullable_to_non_nullable
as List<String>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<WidgetProject>,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<WidgetCard>,
  ));
}

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WidgetStatsCopyWith<$Res> get stats {
  
  return $WidgetStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// @nodoc
mixin _$WidgetStats {

 int get active; int get inProgress; int get openCards; int get doneCards;
/// Create a copy of WidgetStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetStatsCopyWith<WidgetStats> get copyWith => _$WidgetStatsCopyWithImpl<WidgetStats>(this as WidgetStats, _$identity);

  /// Serializes this WidgetStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WidgetStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetStats&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.inProgress, _this.inProgress) || other.inProgress == _this.inProgress)&&(identical(other.openCards, _this.openCards) || other.openCards == _this.openCards)&&(identical(other.doneCards, _this.doneCards) || other.doneCards == _this.doneCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WidgetStats;
  return Object.hash(runtimeType,_this.active,_this.inProgress,_this.openCards,_this.doneCards);
}

@override
String toString() {
  final _this = this as WidgetStats;
  return 'WidgetStats(active: ${_this.active}, inProgress: ${_this.inProgress}, openCards: ${_this.openCards}, doneCards: ${_this.doneCards})';
}


}

/// @nodoc
abstract mixin class $WidgetStatsCopyWith<$Res>  {
  factory $WidgetStatsCopyWith(WidgetStats value, $Res Function(WidgetStats) _then) = _$WidgetStatsCopyWithImpl;
@useResult
$Res call({
 int active, int inProgress, int openCards, int doneCards
});




}
/// @nodoc
class _$WidgetStatsCopyWithImpl<$Res>
    implements $WidgetStatsCopyWith<$Res> {
  _$WidgetStatsCopyWithImpl(this._self, this._then);

  final WidgetStats _self;
  final $Res Function(WidgetStats) _then;

/// Create a copy of WidgetStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? inProgress = null,Object? openCards = null,Object? doneCards = null,}) {
  return _then(WidgetStats(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,openCards: null == openCards ? _self.openCards : openCards // ignore: cast_nullable_to_non_nullable
as int,doneCards: null == doneCards ? _self.doneCards : doneCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetStats].
extension WidgetStatsPatterns on WidgetStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetStats value)  $default,){
final _that = this;
switch (_that) {
case _WidgetStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetStats value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int active,  int inProgress,  int openCards,  int doneCards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetStats() when $default != null:
return $default(_that.active,_that.inProgress,_that.openCards,_that.doneCards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int active,  int inProgress,  int openCards,  int doneCards)  $default,) {final _that = this;
switch (_that) {
case _WidgetStats():
return $default(_that.active,_that.inProgress,_that.openCards,_that.doneCards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int active,  int inProgress,  int openCards,  int doneCards)?  $default,) {final _that = this;
switch (_that) {
case _WidgetStats() when $default != null:
return $default(_that.active,_that.inProgress,_that.openCards,_that.doneCards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WidgetStats implements WidgetStats {
  const _WidgetStats({this.active = 0, this.inProgress = 0, this.openCards = 0, this.doneCards = 0});
  factory _WidgetStats.fromJson(Map<String, dynamic> json) => _$WidgetStatsFromJson(json);

@override@JsonKey() final  int active;
@override@JsonKey() final  int inProgress;
@override@JsonKey() final  int openCards;
@override@JsonKey() final  int doneCards;

/// Create a copy of WidgetStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetStatsCopyWith<_WidgetStats> get copyWith => __$WidgetStatsCopyWithImpl<_WidgetStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WidgetStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetStats&&(identical(other.active, active) || other.active == active)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.openCards, openCards) || other.openCards == openCards)&&(identical(other.doneCards, doneCards) || other.doneCards == doneCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,active,inProgress,openCards,doneCards);
}

@override
String toString() {
    return 'WidgetStats(active: $active, inProgress: $inProgress, openCards: $openCards, doneCards: $doneCards)';
}


}

/// @nodoc
abstract mixin class _$WidgetStatsCopyWith<$Res> implements $WidgetStatsCopyWith<$Res> {
  factory _$WidgetStatsCopyWith(_WidgetStats value, $Res Function(_WidgetStats) _then) = __$WidgetStatsCopyWithImpl;
@override @useResult
$Res call({
 int active, int inProgress, int openCards, int doneCards
});




}
/// @nodoc
class __$WidgetStatsCopyWithImpl<$Res>
    implements _$WidgetStatsCopyWith<$Res> {
  __$WidgetStatsCopyWithImpl(this._self, this._then);

  final _WidgetStats _self;
  final $Res Function(_WidgetStats) _then;

/// Create a copy of WidgetStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? inProgress = null,Object? openCards = null,Object? doneCards = null,}) {
  return _then(_WidgetStats(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,openCards: null == openCards ? _self.openCards : openCards // ignore: cast_nullable_to_non_nullable
as int,doneCards: null == doneCards ? _self.doneCards : doneCards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WidgetProject {

 String get id; String get title; String get status; String get statusLabel; String get priority; String get priorityLabel; String get priorityColor; String? get due; int get done; int get total;
/// Create a copy of WidgetProject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetProjectCopyWith<WidgetProject> get copyWith => _$WidgetProjectCopyWithImpl<WidgetProject>(this as WidgetProject, _$identity);

  /// Serializes this WidgetProject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WidgetProject;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetProject&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.priorityLabel, _this.priorityLabel) || other.priorityLabel == _this.priorityLabel)&&(identical(other.priorityColor, _this.priorityColor) || other.priorityColor == _this.priorityColor)&&(identical(other.due, _this.due) || other.due == _this.due)&&(identical(other.done, _this.done) || other.done == _this.done)&&(identical(other.total, _this.total) || other.total == _this.total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WidgetProject;
  return Object.hash(runtimeType,_this.id,_this.title,_this.status,_this.statusLabel,_this.priority,_this.priorityLabel,_this.priorityColor,_this.due,_this.done,_this.total);
}

@override
String toString() {
  final _this = this as WidgetProject;
  return 'WidgetProject(id: ${_this.id}, title: ${_this.title}, status: ${_this.status}, statusLabel: ${_this.statusLabel}, priority: ${_this.priority}, priorityLabel: ${_this.priorityLabel}, priorityColor: ${_this.priorityColor}, due: ${_this.due}, done: ${_this.done}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $WidgetProjectCopyWith<$Res>  {
  factory $WidgetProjectCopyWith(WidgetProject value, $Res Function(WidgetProject) _then) = _$WidgetProjectCopyWithImpl;
@useResult
$Res call({
 String id, String title, String status, String statusLabel, String priority, String priorityLabel, String priorityColor, String? due, int done, int total
});




}
/// @nodoc
class _$WidgetProjectCopyWithImpl<$Res>
    implements $WidgetProjectCopyWith<$Res> {
  _$WidgetProjectCopyWithImpl(this._self, this._then);

  final WidgetProject _self;
  final $Res Function(WidgetProject) _then;

/// Create a copy of WidgetProject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? statusLabel = null,Object? priority = null,Object? priorityLabel = null,Object? priorityColor = null,Object? due = freezed,Object? done = null,Object? total = null,}) {
  return _then(WidgetProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,priorityLabel: null == priorityLabel ? _self.priorityLabel : priorityLabel // ignore: cast_nullable_to_non_nullable
as String,priorityColor: null == priorityColor ? _self.priorityColor : priorityColor // ignore: cast_nullable_to_non_nullable
as String,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetProject].
extension WidgetProjectPatterns on WidgetProject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetProject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetProject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetProject value)  $default,){
final _that = this;
switch (_that) {
case _WidgetProject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetProject value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetProject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String statusLabel,  String priority,  String priorityLabel,  String priorityColor,  String? due,  int done,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetProject() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.statusLabel,_that.priority,_that.priorityLabel,_that.priorityColor,_that.due,_that.done,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String statusLabel,  String priority,  String priorityLabel,  String priorityColor,  String? due,  int done,  int total)  $default,) {final _that = this;
switch (_that) {
case _WidgetProject():
return $default(_that.id,_that.title,_that.status,_that.statusLabel,_that.priority,_that.priorityLabel,_that.priorityColor,_that.due,_that.done,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String status,  String statusLabel,  String priority,  String priorityLabel,  String priorityColor,  String? due,  int done,  int total)?  $default,) {final _that = this;
switch (_that) {
case _WidgetProject() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.statusLabel,_that.priority,_that.priorityLabel,_that.priorityColor,_that.due,_that.done,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WidgetProject implements WidgetProject {
  const _WidgetProject({required this.id, required this.title, required this.status, required this.statusLabel, required this.priority, required this.priorityLabel, required this.priorityColor, this.due, this.done = 0, this.total = 0});
  factory _WidgetProject.fromJson(Map<String, dynamic> json) => _$WidgetProjectFromJson(json);

@override final  String id;
@override final  String title;
@override final  String status;
@override final  String statusLabel;
@override final  String priority;
@override final  String priorityLabel;
@override final  String priorityColor;
@override final  String? due;
@override@JsonKey() final  int done;
@override@JsonKey() final  int total;

/// Create a copy of WidgetProject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetProjectCopyWith<_WidgetProject> get copyWith => __$WidgetProjectCopyWithImpl<_WidgetProject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WidgetProjectToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetProject&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.priorityLabel, priorityLabel) || other.priorityLabel == priorityLabel)&&(identical(other.priorityColor, priorityColor) || other.priorityColor == priorityColor)&&(identical(other.due, due) || other.due == due)&&(identical(other.done, done) || other.done == done)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,status,statusLabel,priority,priorityLabel,priorityColor,due,done,total);
}

@override
String toString() {
    return 'WidgetProject(id: $id, title: $title, status: $status, statusLabel: $statusLabel, priority: $priority, priorityLabel: $priorityLabel, priorityColor: $priorityColor, due: $due, done: $done, total: $total)';
}


}

/// @nodoc
abstract mixin class _$WidgetProjectCopyWith<$Res> implements $WidgetProjectCopyWith<$Res> {
  factory _$WidgetProjectCopyWith(_WidgetProject value, $Res Function(_WidgetProject) _then) = __$WidgetProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String status, String statusLabel, String priority, String priorityLabel, String priorityColor, String? due, int done, int total
});




}
/// @nodoc
class __$WidgetProjectCopyWithImpl<$Res>
    implements _$WidgetProjectCopyWith<$Res> {
  __$WidgetProjectCopyWithImpl(this._self, this._then);

  final _WidgetProject _self;
  final $Res Function(_WidgetProject) _then;

/// Create a copy of WidgetProject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? statusLabel = null,Object? priority = null,Object? priorityLabel = null,Object? priorityColor = null,Object? due = freezed,Object? done = null,Object? total = null,}) {
  return _then(_WidgetProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,priorityLabel: null == priorityLabel ? _self.priorityLabel : priorityLabel // ignore: cast_nullable_to_non_nullable
as String,priorityColor: null == priorityColor ? _self.priorityColor : priorityColor // ignore: cast_nullable_to_non_nullable
as String,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WidgetCard {

 String get id; String get projectId; String get projectTitle; String get title; String get priority; String get priorityColor; String get due;
/// Create a copy of WidgetCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetCardCopyWith<WidgetCard> get copyWith => _$WidgetCardCopyWithImpl<WidgetCard>(this as WidgetCard, _$identity);

  /// Serializes this WidgetCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WidgetCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.projectId, _this.projectId) || other.projectId == _this.projectId)&&(identical(other.projectTitle, _this.projectTitle) || other.projectTitle == _this.projectTitle)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.priorityColor, _this.priorityColor) || other.priorityColor == _this.priorityColor)&&(identical(other.due, _this.due) || other.due == _this.due));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WidgetCard;
  return Object.hash(runtimeType,_this.id,_this.projectId,_this.projectTitle,_this.title,_this.priority,_this.priorityColor,_this.due);
}

@override
String toString() {
  final _this = this as WidgetCard;
  return 'WidgetCard(id: ${_this.id}, projectId: ${_this.projectId}, projectTitle: ${_this.projectTitle}, title: ${_this.title}, priority: ${_this.priority}, priorityColor: ${_this.priorityColor}, due: ${_this.due})';
}


}

/// @nodoc
abstract mixin class $WidgetCardCopyWith<$Res>  {
  factory $WidgetCardCopyWith(WidgetCard value, $Res Function(WidgetCard) _then) = _$WidgetCardCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String projectTitle, String title, String priority, String priorityColor, String due
});




}
/// @nodoc
class _$WidgetCardCopyWithImpl<$Res>
    implements $WidgetCardCopyWith<$Res> {
  _$WidgetCardCopyWithImpl(this._self, this._then);

  final WidgetCard _self;
  final $Res Function(WidgetCard) _then;

/// Create a copy of WidgetCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? projectTitle = null,Object? title = null,Object? priority = null,Object? priorityColor = null,Object? due = null,}) {
  return _then(WidgetCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,priorityColor: null == priorityColor ? _self.priorityColor : priorityColor // ignore: cast_nullable_to_non_nullable
as String,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetCard].
extension WidgetCardPatterns on WidgetCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetCard value)  $default,){
final _that = this;
switch (_that) {
case _WidgetCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetCard value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String projectTitle,  String title,  String priority,  String priorityColor,  String due)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetCard() when $default != null:
return $default(_that.id,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.priorityColor,_that.due);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String projectTitle,  String title,  String priority,  String priorityColor,  String due)  $default,) {final _that = this;
switch (_that) {
case _WidgetCard():
return $default(_that.id,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.priorityColor,_that.due);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String projectTitle,  String title,  String priority,  String priorityColor,  String due)?  $default,) {final _that = this;
switch (_that) {
case _WidgetCard() when $default != null:
return $default(_that.id,_that.projectId,_that.projectTitle,_that.title,_that.priority,_that.priorityColor,_that.due);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WidgetCard implements WidgetCard {
  const _WidgetCard({required this.id, required this.projectId, required this.projectTitle, required this.title, required this.priority, required this.priorityColor, required this.due});
  factory _WidgetCard.fromJson(Map<String, dynamic> json) => _$WidgetCardFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String projectTitle;
@override final  String title;
@override final  String priority;
@override final  String priorityColor;
@override final  String due;

/// Create a copy of WidgetCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetCardCopyWith<_WidgetCard> get copyWith => __$WidgetCardCopyWithImpl<_WidgetCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WidgetCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetCard&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectTitle, projectTitle) || other.projectTitle == projectTitle)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.priorityColor, priorityColor) || other.priorityColor == priorityColor)&&(identical(other.due, due) || other.due == due));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,projectId,projectTitle,title,priority,priorityColor,due);
}

@override
String toString() {
    return 'WidgetCard(id: $id, projectId: $projectId, projectTitle: $projectTitle, title: $title, priority: $priority, priorityColor: $priorityColor, due: $due)';
}


}

/// @nodoc
abstract mixin class _$WidgetCardCopyWith<$Res> implements $WidgetCardCopyWith<$Res> {
  factory _$WidgetCardCopyWith(_WidgetCard value, $Res Function(_WidgetCard) _then) = __$WidgetCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String projectTitle, String title, String priority, String priorityColor, String due
});




}
/// @nodoc
class __$WidgetCardCopyWithImpl<$Res>
    implements _$WidgetCardCopyWith<$Res> {
  __$WidgetCardCopyWithImpl(this._self, this._then);

  final _WidgetCard _self;
  final $Res Function(_WidgetCard) _then;

/// Create a copy of WidgetCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? projectTitle = null,Object? title = null,Object? priority = null,Object? priorityColor = null,Object? due = null,}) {
  return _then(_WidgetCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectTitle: null == projectTitle ? _self.projectTitle : projectTitle // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,priorityColor: null == priorityColor ? _self.priorityColor : priorityColor // ignore: cast_nullable_to_non_nullable
as String,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
