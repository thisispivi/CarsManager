// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fine_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FineData {

 DateTime get date; double get amount; FineType get type;
/// Create a copy of FineData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineDataCopyWith<FineData> get copyWith => _$FineDataCopyWithImpl<FineData>(this as FineData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FineData&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,date,amount,type);

@override
String toString() {
  return 'FineData(date: $date, amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class $FineDataCopyWith<$Res>  {
  factory $FineDataCopyWith(FineData value, $Res Function(FineData) _then) = _$FineDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, double amount, FineType type
});




}
/// @nodoc
class _$FineDataCopyWithImpl<$Res>
    implements $FineDataCopyWith<$Res> {
  _$FineDataCopyWithImpl(this._self, this._then);

  final FineData _self;
  final $Res Function(FineData) _then;

/// Create a copy of FineData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? amount = null,Object? type = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FineType,
  ));
}

}


/// Adds pattern-matching-related methods to [FineData].
extension FineDataPatterns on FineData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FineData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FineData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FineData value)  $default,){
final _that = this;
switch (_that) {
case _FineData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FineData value)?  $default,){
final _that = this;
switch (_that) {
case _FineData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double amount,  FineType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FineData() when $default != null:
return $default(_that.date,_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double amount,  FineType type)  $default,) {final _that = this;
switch (_that) {
case _FineData():
return $default(_that.date,_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double amount,  FineType type)?  $default,) {final _that = this;
switch (_that) {
case _FineData() when $default != null:
return $default(_that.date,_that.amount,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _FineData implements FineData {
  const _FineData({required this.date, required this.amount, required this.type});
  

@override final  DateTime date;
@override final  double amount;
@override final  FineType type;

/// Create a copy of FineData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineDataCopyWith<_FineData> get copyWith => __$FineDataCopyWithImpl<_FineData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FineData&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,date,amount,type);

@override
String toString() {
  return 'FineData(date: $date, amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class _$FineDataCopyWith<$Res> implements $FineDataCopyWith<$Res> {
  factory _$FineDataCopyWith(_FineData value, $Res Function(_FineData) _then) = __$FineDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double amount, FineType type
});




}
/// @nodoc
class __$FineDataCopyWithImpl<$Res>
    implements _$FineDataCopyWith<$Res> {
  __$FineDataCopyWithImpl(this._self, this._then);

  final _FineData _self;
  final $Res Function(_FineData) _then;

/// Create a copy of FineData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? amount = null,Object? type = null,}) {
  return _then(_FineData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FineType,
  ));
}


}

// dart format on
