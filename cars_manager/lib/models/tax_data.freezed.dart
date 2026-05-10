// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaxData {

 DateTime get date; double get amount;
/// Create a copy of TaxData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxDataCopyWith<TaxData> get copyWith => _$TaxDataCopyWithImpl<TaxData>(this as TaxData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxData&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,date,amount);

@override
String toString() {
  return 'TaxData(date: $date, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $TaxDataCopyWith<$Res>  {
  factory $TaxDataCopyWith(TaxData value, $Res Function(TaxData) _then) = _$TaxDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, double amount
});




}
/// @nodoc
class _$TaxDataCopyWithImpl<$Res>
    implements $TaxDataCopyWith<$Res> {
  _$TaxDataCopyWithImpl(this._self, this._then);

  final TaxData _self;
  final $Res Function(TaxData) _then;

/// Create a copy of TaxData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? amount = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxData].
extension TaxDataPatterns on TaxData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxData value)  $default,){
final _that = this;
switch (_that) {
case _TaxData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxData value)?  $default,){
final _that = this;
switch (_that) {
case _TaxData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxData() when $default != null:
return $default(_that.date,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double amount)  $default,) {final _that = this;
switch (_that) {
case _TaxData():
return $default(_that.date,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _TaxData() when $default != null:
return $default(_that.date,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _TaxData implements TaxData {
  const _TaxData({required this.date, required this.amount});
  

@override final  DateTime date;
@override final  double amount;

/// Create a copy of TaxData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxDataCopyWith<_TaxData> get copyWith => __$TaxDataCopyWithImpl<_TaxData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxData&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,date,amount);

@override
String toString() {
  return 'TaxData(date: $date, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TaxDataCopyWith<$Res> implements $TaxDataCopyWith<$Res> {
  factory _$TaxDataCopyWith(_TaxData value, $Res Function(_TaxData) _then) = __$TaxDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double amount
});




}
/// @nodoc
class __$TaxDataCopyWithImpl<$Res>
    implements _$TaxDataCopyWith<$Res> {
  __$TaxDataCopyWithImpl(this._self, this._then);

  final _TaxData _self;
  final $Res Function(_TaxData) _then;

/// Create a copy of TaxData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? amount = null,}) {
  return _then(_TaxData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
