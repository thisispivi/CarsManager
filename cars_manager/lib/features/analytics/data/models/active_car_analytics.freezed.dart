// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_car_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveCarAnalytics {

 int get totalExpenses; int get fuelEntryCount; String? get vehicleName;
/// Create a copy of ActiveCarAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveCarAnalyticsCopyWith<ActiveCarAnalytics> get copyWith => _$ActiveCarAnalyticsCopyWithImpl<ActiveCarAnalytics>(this as ActiveCarAnalytics, _$identity);

  /// Serializes this ActiveCarAnalytics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveCarAnalytics&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.fuelEntryCount, fuelEntryCount) || other.fuelEntryCount == fuelEntryCount)&&(identical(other.vehicleName, vehicleName) || other.vehicleName == vehicleName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExpenses,fuelEntryCount,vehicleName);

@override
String toString() {
  return 'ActiveCarAnalytics(totalExpenses: $totalExpenses, fuelEntryCount: $fuelEntryCount, vehicleName: $vehicleName)';
}


}

/// @nodoc
abstract mixin class $ActiveCarAnalyticsCopyWith<$Res>  {
  factory $ActiveCarAnalyticsCopyWith(ActiveCarAnalytics value, $Res Function(ActiveCarAnalytics) _then) = _$ActiveCarAnalyticsCopyWithImpl;
@useResult
$Res call({
 int totalExpenses, int fuelEntryCount, String? vehicleName
});




}
/// @nodoc
class _$ActiveCarAnalyticsCopyWithImpl<$Res>
    implements $ActiveCarAnalyticsCopyWith<$Res> {
  _$ActiveCarAnalyticsCopyWithImpl(this._self, this._then);

  final ActiveCarAnalytics _self;
  final $Res Function(ActiveCarAnalytics) _then;

/// Create a copy of ActiveCarAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalExpenses = null,Object? fuelEntryCount = null,Object? vehicleName = freezed,}) {
  return _then(_self.copyWith(
totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as int,fuelEntryCount: null == fuelEntryCount ? _self.fuelEntryCount : fuelEntryCount // ignore: cast_nullable_to_non_nullable
as int,vehicleName: freezed == vehicleName ? _self.vehicleName : vehicleName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveCarAnalytics].
extension ActiveCarAnalyticsPatterns on ActiveCarAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveCarAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveCarAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveCarAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _ActiveCarAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveCarAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveCarAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalExpenses,  int fuelEntryCount,  String? vehicleName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveCarAnalytics() when $default != null:
return $default(_that.totalExpenses,_that.fuelEntryCount,_that.vehicleName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalExpenses,  int fuelEntryCount,  String? vehicleName)  $default,) {final _that = this;
switch (_that) {
case _ActiveCarAnalytics():
return $default(_that.totalExpenses,_that.fuelEntryCount,_that.vehicleName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalExpenses,  int fuelEntryCount,  String? vehicleName)?  $default,) {final _that = this;
switch (_that) {
case _ActiveCarAnalytics() when $default != null:
return $default(_that.totalExpenses,_that.fuelEntryCount,_that.vehicleName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveCarAnalytics implements ActiveCarAnalytics {
  const _ActiveCarAnalytics({required this.totalExpenses, required this.fuelEntryCount, this.vehicleName});
  factory _ActiveCarAnalytics.fromJson(Map<String, dynamic> json) => _$ActiveCarAnalyticsFromJson(json);

@override final  int totalExpenses;
@override final  int fuelEntryCount;
@override final  String? vehicleName;

/// Create a copy of ActiveCarAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveCarAnalyticsCopyWith<_ActiveCarAnalytics> get copyWith => __$ActiveCarAnalyticsCopyWithImpl<_ActiveCarAnalytics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveCarAnalyticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveCarAnalytics&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.fuelEntryCount, fuelEntryCount) || other.fuelEntryCount == fuelEntryCount)&&(identical(other.vehicleName, vehicleName) || other.vehicleName == vehicleName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExpenses,fuelEntryCount,vehicleName);

@override
String toString() {
  return 'ActiveCarAnalytics(totalExpenses: $totalExpenses, fuelEntryCount: $fuelEntryCount, vehicleName: $vehicleName)';
}


}

/// @nodoc
abstract mixin class _$ActiveCarAnalyticsCopyWith<$Res> implements $ActiveCarAnalyticsCopyWith<$Res> {
  factory _$ActiveCarAnalyticsCopyWith(_ActiveCarAnalytics value, $Res Function(_ActiveCarAnalytics) _then) = __$ActiveCarAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 int totalExpenses, int fuelEntryCount, String? vehicleName
});




}
/// @nodoc
class __$ActiveCarAnalyticsCopyWithImpl<$Res>
    implements _$ActiveCarAnalyticsCopyWith<$Res> {
  __$ActiveCarAnalyticsCopyWithImpl(this._self, this._then);

  final _ActiveCarAnalytics _self;
  final $Res Function(_ActiveCarAnalytics) _then;

/// Create a copy of ActiveCarAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalExpenses = null,Object? fuelEntryCount = null,Object? vehicleName = freezed,}) {
  return _then(_ActiveCarAnalytics(
totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as int,fuelEntryCount: null == fuelEntryCount ? _self.fuelEntryCount : fuelEntryCount // ignore: cast_nullable_to_non_nullable
as int,vehicleName: freezed == vehicleName ? _self.vehicleName : vehicleName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
