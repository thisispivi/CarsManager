// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insurance_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InsuranceData {

 String get insuranceCompany; String get policyNumber; DateTime get startDate; DateTime get endDate; DateTime? get extensionDate; double get premiumAmount;
/// Create a copy of InsuranceData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsuranceDataCopyWith<InsuranceData> get copyWith => _$InsuranceDataCopyWithImpl<InsuranceData>(this as InsuranceData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsuranceData&&(identical(other.insuranceCompany, insuranceCompany) || other.insuranceCompany == insuranceCompany)&&(identical(other.policyNumber, policyNumber) || other.policyNumber == policyNumber)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.extensionDate, extensionDate) || other.extensionDate == extensionDate)&&(identical(other.premiumAmount, premiumAmount) || other.premiumAmount == premiumAmount));
}


@override
int get hashCode => Object.hash(runtimeType,insuranceCompany,policyNumber,startDate,endDate,extensionDate,premiumAmount);

@override
String toString() {
  return 'InsuranceData(insuranceCompany: $insuranceCompany, policyNumber: $policyNumber, startDate: $startDate, endDate: $endDate, extensionDate: $extensionDate, premiumAmount: $premiumAmount)';
}


}

/// @nodoc
abstract mixin class $InsuranceDataCopyWith<$Res>  {
  factory $InsuranceDataCopyWith(InsuranceData value, $Res Function(InsuranceData) _then) = _$InsuranceDataCopyWithImpl;
@useResult
$Res call({
 String insuranceCompany, String policyNumber, DateTime startDate, DateTime endDate, DateTime? extensionDate, double premiumAmount
});




}
/// @nodoc
class _$InsuranceDataCopyWithImpl<$Res>
    implements $InsuranceDataCopyWith<$Res> {
  _$InsuranceDataCopyWithImpl(this._self, this._then);

  final InsuranceData _self;
  final $Res Function(InsuranceData) _then;

/// Create a copy of InsuranceData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? insuranceCompany = null,Object? policyNumber = null,Object? startDate = null,Object? endDate = null,Object? extensionDate = freezed,Object? premiumAmount = null,}) {
  return _then(_self.copyWith(
insuranceCompany: null == insuranceCompany ? _self.insuranceCompany : insuranceCompany // ignore: cast_nullable_to_non_nullable
as String,policyNumber: null == policyNumber ? _self.policyNumber : policyNumber // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,extensionDate: freezed == extensionDate ? _self.extensionDate : extensionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumAmount: null == premiumAmount ? _self.premiumAmount : premiumAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [InsuranceData].
extension InsuranceDataPatterns on InsuranceData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InsuranceData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InsuranceData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InsuranceData value)  $default,){
final _that = this;
switch (_that) {
case _InsuranceData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InsuranceData value)?  $default,){
final _that = this;
switch (_that) {
case _InsuranceData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String insuranceCompany,  String policyNumber,  DateTime startDate,  DateTime endDate,  DateTime? extensionDate,  double premiumAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InsuranceData() when $default != null:
return $default(_that.insuranceCompany,_that.policyNumber,_that.startDate,_that.endDate,_that.extensionDate,_that.premiumAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String insuranceCompany,  String policyNumber,  DateTime startDate,  DateTime endDate,  DateTime? extensionDate,  double premiumAmount)  $default,) {final _that = this;
switch (_that) {
case _InsuranceData():
return $default(_that.insuranceCompany,_that.policyNumber,_that.startDate,_that.endDate,_that.extensionDate,_that.premiumAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String insuranceCompany,  String policyNumber,  DateTime startDate,  DateTime endDate,  DateTime? extensionDate,  double premiumAmount)?  $default,) {final _that = this;
switch (_that) {
case _InsuranceData() when $default != null:
return $default(_that.insuranceCompany,_that.policyNumber,_that.startDate,_that.endDate,_that.extensionDate,_that.premiumAmount);case _:
  return null;

}
}

}

/// @nodoc


class _InsuranceData implements InsuranceData {
  const _InsuranceData({required this.insuranceCompany, required this.policyNumber, required this.startDate, required this.endDate, this.extensionDate, required this.premiumAmount});
  

@override final  String insuranceCompany;
@override final  String policyNumber;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  DateTime? extensionDate;
@override final  double premiumAmount;

/// Create a copy of InsuranceData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsuranceDataCopyWith<_InsuranceData> get copyWith => __$InsuranceDataCopyWithImpl<_InsuranceData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InsuranceData&&(identical(other.insuranceCompany, insuranceCompany) || other.insuranceCompany == insuranceCompany)&&(identical(other.policyNumber, policyNumber) || other.policyNumber == policyNumber)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.extensionDate, extensionDate) || other.extensionDate == extensionDate)&&(identical(other.premiumAmount, premiumAmount) || other.premiumAmount == premiumAmount));
}


@override
int get hashCode => Object.hash(runtimeType,insuranceCompany,policyNumber,startDate,endDate,extensionDate,premiumAmount);

@override
String toString() {
  return 'InsuranceData(insuranceCompany: $insuranceCompany, policyNumber: $policyNumber, startDate: $startDate, endDate: $endDate, extensionDate: $extensionDate, premiumAmount: $premiumAmount)';
}


}

/// @nodoc
abstract mixin class _$InsuranceDataCopyWith<$Res> implements $InsuranceDataCopyWith<$Res> {
  factory _$InsuranceDataCopyWith(_InsuranceData value, $Res Function(_InsuranceData) _then) = __$InsuranceDataCopyWithImpl;
@override @useResult
$Res call({
 String insuranceCompany, String policyNumber, DateTime startDate, DateTime endDate, DateTime? extensionDate, double premiumAmount
});




}
/// @nodoc
class __$InsuranceDataCopyWithImpl<$Res>
    implements _$InsuranceDataCopyWith<$Res> {
  __$InsuranceDataCopyWithImpl(this._self, this._then);

  final _InsuranceData _self;
  final $Res Function(_InsuranceData) _then;

/// Create a copy of InsuranceData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? insuranceCompany = null,Object? policyNumber = null,Object? startDate = null,Object? endDate = null,Object? extensionDate = freezed,Object? premiumAmount = null,}) {
  return _then(_InsuranceData(
insuranceCompany: null == insuranceCompany ? _self.insuranceCompany : insuranceCompany // ignore: cast_nullable_to_non_nullable
as String,policyNumber: null == policyNumber ? _self.policyNumber : policyNumber // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,extensionDate: freezed == extensionDate ? _self.extensionDate : extensionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumAmount: null == premiumAmount ? _self.premiumAmount : premiumAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
