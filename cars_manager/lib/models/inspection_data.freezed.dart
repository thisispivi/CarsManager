// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InspectionData {

 DateTime get date; bool get isPassed; double? get amount; double? get mileage;
/// Create a copy of InspectionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionDataCopyWith<InspectionData> get copyWith => _$InspectionDataCopyWithImpl<InspectionData>(this as InspectionData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionData&&(identical(other.date, date) || other.date == date)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.mileage, mileage) || other.mileage == mileage));
}


@override
int get hashCode => Object.hash(runtimeType,date,isPassed,amount,mileage);

@override
String toString() {
  return 'InspectionData(date: $date, isPassed: $isPassed, amount: $amount, mileage: $mileage)';
}


}

/// @nodoc
abstract mixin class $InspectionDataCopyWith<$Res>  {
  factory $InspectionDataCopyWith(InspectionData value, $Res Function(InspectionData) _then) = _$InspectionDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool isPassed, double? amount, double? mileage
});




}
/// @nodoc
class _$InspectionDataCopyWithImpl<$Res>
    implements $InspectionDataCopyWith<$Res> {
  _$InspectionDataCopyWithImpl(this._self, this._then);

  final InspectionData _self;
  final $Res Function(InspectionData) _then;

/// Create a copy of InspectionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? isPassed = null,Object? amount = freezed,Object? mileage = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,mileage: freezed == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionData].
extension InspectionDataPatterns on InspectionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionData value)  $default,){
final _that = this;
switch (_that) {
case _InspectionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionData value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  bool isPassed,  double? amount,  double? mileage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionData() when $default != null:
return $default(_that.date,_that.isPassed,_that.amount,_that.mileage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  bool isPassed,  double? amount,  double? mileage)  $default,) {final _that = this;
switch (_that) {
case _InspectionData():
return $default(_that.date,_that.isPassed,_that.amount,_that.mileage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  bool isPassed,  double? amount,  double? mileage)?  $default,) {final _that = this;
switch (_that) {
case _InspectionData() when $default != null:
return $default(_that.date,_that.isPassed,_that.amount,_that.mileage);case _:
  return null;

}
}

}

/// @nodoc


class _InspectionData implements InspectionData {
  const _InspectionData({required this.date, required this.isPassed, this.amount, this.mileage});
  

@override final  DateTime date;
@override final  bool isPassed;
@override final  double? amount;
@override final  double? mileage;

/// Create a copy of InspectionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionDataCopyWith<_InspectionData> get copyWith => __$InspectionDataCopyWithImpl<_InspectionData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionData&&(identical(other.date, date) || other.date == date)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.mileage, mileage) || other.mileage == mileage));
}


@override
int get hashCode => Object.hash(runtimeType,date,isPassed,amount,mileage);

@override
String toString() {
  return 'InspectionData(date: $date, isPassed: $isPassed, amount: $amount, mileage: $mileage)';
}


}

/// @nodoc
abstract mixin class _$InspectionDataCopyWith<$Res> implements $InspectionDataCopyWith<$Res> {
  factory _$InspectionDataCopyWith(_InspectionData value, $Res Function(_InspectionData) _then) = __$InspectionDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool isPassed, double? amount, double? mileage
});




}
/// @nodoc
class __$InspectionDataCopyWithImpl<$Res>
    implements _$InspectionDataCopyWith<$Res> {
  __$InspectionDataCopyWithImpl(this._self, this._then);

  final _InspectionData _self;
  final $Res Function(_InspectionData) _then;

/// Create a copy of InspectionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isPassed = null,Object? amount = freezed,Object? mileage = freezed,}) {
  return _then(_InspectionData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,mileage: freezed == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
