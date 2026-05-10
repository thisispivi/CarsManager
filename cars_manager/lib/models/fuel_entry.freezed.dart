// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fuel_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FuelEntry {

 FuelType get fuelType; double get liters; double get totalCost; double get pricePerLiter; DateTime get date;
/// Create a copy of FuelEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuelEntryCopyWith<FuelEntry> get copyWith => _$FuelEntryCopyWithImpl<FuelEntry>(this as FuelEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuelEntry&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.liters, liters) || other.liters == liters)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.pricePerLiter, pricePerLiter) || other.pricePerLiter == pricePerLiter)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,fuelType,liters,totalCost,pricePerLiter,date);

@override
String toString() {
  return 'FuelEntry(fuelType: $fuelType, liters: $liters, totalCost: $totalCost, pricePerLiter: $pricePerLiter, date: $date)';
}


}

/// @nodoc
abstract mixin class $FuelEntryCopyWith<$Res>  {
  factory $FuelEntryCopyWith(FuelEntry value, $Res Function(FuelEntry) _then) = _$FuelEntryCopyWithImpl;
@useResult
$Res call({
 FuelType fuelType, double liters, double totalCost, double pricePerLiter, DateTime date
});




}
/// @nodoc
class _$FuelEntryCopyWithImpl<$Res>
    implements $FuelEntryCopyWith<$Res> {
  _$FuelEntryCopyWithImpl(this._self, this._then);

  final FuelEntry _self;
  final $Res Function(FuelEntry) _then;

/// Create a copy of FuelEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fuelType = null,Object? liters = null,Object? totalCost = null,Object? pricePerLiter = null,Object? date = null,}) {
  return _then(_self.copyWith(
fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,liters: null == liters ? _self.liters : liters // ignore: cast_nullable_to_non_nullable
as double,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,pricePerLiter: null == pricePerLiter ? _self.pricePerLiter : pricePerLiter // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FuelEntry].
extension FuelEntryPatterns on FuelEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FuelEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FuelEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FuelEntry value)  $default,){
final _that = this;
switch (_that) {
case _FuelEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FuelEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FuelEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FuelType fuelType,  double liters,  double totalCost,  double pricePerLiter,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FuelEntry() when $default != null:
return $default(_that.fuelType,_that.liters,_that.totalCost,_that.pricePerLiter,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FuelType fuelType,  double liters,  double totalCost,  double pricePerLiter,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _FuelEntry():
return $default(_that.fuelType,_that.liters,_that.totalCost,_that.pricePerLiter,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FuelType fuelType,  double liters,  double totalCost,  double pricePerLiter,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _FuelEntry() when $default != null:
return $default(_that.fuelType,_that.liters,_that.totalCost,_that.pricePerLiter,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _FuelEntry implements FuelEntry {
  const _FuelEntry({required this.fuelType, required this.liters, required this.totalCost, required this.pricePerLiter, required this.date});
  

@override final  FuelType fuelType;
@override final  double liters;
@override final  double totalCost;
@override final  double pricePerLiter;
@override final  DateTime date;

/// Create a copy of FuelEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FuelEntryCopyWith<_FuelEntry> get copyWith => __$FuelEntryCopyWithImpl<_FuelEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FuelEntry&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.liters, liters) || other.liters == liters)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.pricePerLiter, pricePerLiter) || other.pricePerLiter == pricePerLiter)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,fuelType,liters,totalCost,pricePerLiter,date);

@override
String toString() {
  return 'FuelEntry(fuelType: $fuelType, liters: $liters, totalCost: $totalCost, pricePerLiter: $pricePerLiter, date: $date)';
}


}

/// @nodoc
abstract mixin class _$FuelEntryCopyWith<$Res> implements $FuelEntryCopyWith<$Res> {
  factory _$FuelEntryCopyWith(_FuelEntry value, $Res Function(_FuelEntry) _then) = __$FuelEntryCopyWithImpl;
@override @useResult
$Res call({
 FuelType fuelType, double liters, double totalCost, double pricePerLiter, DateTime date
});




}
/// @nodoc
class __$FuelEntryCopyWithImpl<$Res>
    implements _$FuelEntryCopyWith<$Res> {
  __$FuelEntryCopyWithImpl(this._self, this._then);

  final _FuelEntry _self;
  final $Res Function(_FuelEntry) _then;

/// Create a copy of FuelEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fuelType = null,Object? liters = null,Object? totalCost = null,Object? pricePerLiter = null,Object? date = null,}) {
  return _then(_FuelEntry(
fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,liters: null == liters ? _self.liters : liters // ignore: cast_nullable_to_non_nullable
as double,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,pricePerLiter: null == pricePerLiter ? _self.pricePerLiter : pricePerLiter // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
