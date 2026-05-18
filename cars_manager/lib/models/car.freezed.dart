// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Car {

 String get id; String get name; String get model; String get manufacture; int get yearOfManufacture; String? get imageUrl; String? get imageBase64; String? get imageOriginalBase64; Alignment get imageAlignment; String get licensePlate; FuelType? get fuelType; List<FuelEntry> get fuel; List<InsuranceData> get insuranceDatas; List<InspectionData> get inspectionDatas; List<TaxData> get taxDatas; List<RepairData> get repairDatas; List<FineData> get fineDatas;
/// Create a copy of Car
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarCopyWith<Car> get copyWith => _$CarCopyWithImpl<Car>(this as Car, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Car&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.model, model) || other.model == model)&&(identical(other.manufacture, manufacture) || other.manufacture == manufacture)&&(identical(other.yearOfManufacture, yearOfManufacture) || other.yearOfManufacture == yearOfManufacture)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.imageOriginalBase64, imageOriginalBase64) || other.imageOriginalBase64 == imageOriginalBase64)&&(identical(other.imageAlignment, imageAlignment) || other.imageAlignment == imageAlignment)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&const DeepCollectionEquality().equals(other.fuel, fuel)&&const DeepCollectionEquality().equals(other.insuranceDatas, insuranceDatas)&&const DeepCollectionEquality().equals(other.inspectionDatas, inspectionDatas)&&const DeepCollectionEquality().equals(other.taxDatas, taxDatas)&&const DeepCollectionEquality().equals(other.repairDatas, repairDatas)&&const DeepCollectionEquality().equals(other.fineDatas, fineDatas));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,model,manufacture,yearOfManufacture,imageUrl,imageBase64,imageOriginalBase64,imageAlignment,licensePlate,fuelType,const DeepCollectionEquality().hash(fuel),const DeepCollectionEquality().hash(insuranceDatas),const DeepCollectionEquality().hash(inspectionDatas),const DeepCollectionEquality().hash(taxDatas),const DeepCollectionEquality().hash(repairDatas),const DeepCollectionEquality().hash(fineDatas));

@override
String toString() {
  return 'Car(id: $id, name: $name, model: $model, manufacture: $manufacture, yearOfManufacture: $yearOfManufacture, imageUrl: $imageUrl, imageBase64: $imageBase64, imageOriginalBase64: $imageOriginalBase64, imageAlignment: $imageAlignment, licensePlate: $licensePlate, fuelType: $fuelType, fuel: $fuel, insuranceDatas: $insuranceDatas, inspectionDatas: $inspectionDatas, taxDatas: $taxDatas, repairDatas: $repairDatas, fineDatas: $fineDatas)';
}


}

/// @nodoc
abstract mixin class $CarCopyWith<$Res>  {
  factory $CarCopyWith(Car value, $Res Function(Car) _then) = _$CarCopyWithImpl;
@useResult
$Res call({
 String id, String name, String model, String manufacture, int yearOfManufacture, String? imageUrl, String? imageBase64, String? imageOriginalBase64, Alignment imageAlignment, String licensePlate, FuelType? fuelType, List<FuelEntry> fuel, List<InsuranceData> insuranceDatas, List<InspectionData> inspectionDatas, List<TaxData> taxDatas, List<RepairData> repairDatas, List<FineData> fineDatas
});




}
/// @nodoc
class _$CarCopyWithImpl<$Res>
    implements $CarCopyWith<$Res> {
  _$CarCopyWithImpl(this._self, this._then);

  final Car _self;
  final $Res Function(Car) _then;

/// Create a copy of Car
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? model = null,Object? manufacture = null,Object? yearOfManufacture = null,Object? imageUrl = freezed,Object? imageBase64 = freezed,Object? imageOriginalBase64 = freezed,Object? imageAlignment = null,Object? licensePlate = null,Object? fuelType = freezed,Object? fuel = null,Object? insuranceDatas = null,Object? inspectionDatas = null,Object? taxDatas = null,Object? repairDatas = null,Object? fineDatas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,manufacture: null == manufacture ? _self.manufacture : manufacture // ignore: cast_nullable_to_non_nullable
as String,yearOfManufacture: null == yearOfManufacture ? _self.yearOfManufacture : yearOfManufacture // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageOriginalBase64: freezed == imageOriginalBase64 ? _self.imageOriginalBase64 : imageOriginalBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageAlignment: null == imageAlignment ? _self.imageAlignment : imageAlignment // ignore: cast_nullable_to_non_nullable
as Alignment,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,fuelType: freezed == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType?,fuel: null == fuel ? _self.fuel : fuel // ignore: cast_nullable_to_non_nullable
as List<FuelEntry>,insuranceDatas: null == insuranceDatas ? _self.insuranceDatas : insuranceDatas // ignore: cast_nullable_to_non_nullable
as List<InsuranceData>,inspectionDatas: null == inspectionDatas ? _self.inspectionDatas : inspectionDatas // ignore: cast_nullable_to_non_nullable
as List<InspectionData>,taxDatas: null == taxDatas ? _self.taxDatas : taxDatas // ignore: cast_nullable_to_non_nullable
as List<TaxData>,repairDatas: null == repairDatas ? _self.repairDatas : repairDatas // ignore: cast_nullable_to_non_nullable
as List<RepairData>,fineDatas: null == fineDatas ? _self.fineDatas : fineDatas // ignore: cast_nullable_to_non_nullable
as List<FineData>,
  ));
}

}


/// Adds pattern-matching-related methods to [Car].
extension CarPatterns on Car {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Car value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Car() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Car value)  $default,){
final _that = this;
switch (_that) {
case _Car():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Car value)?  $default,){
final _that = this;
switch (_that) {
case _Car() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String model,  String manufacture,  int yearOfManufacture,  String? imageUrl,  String? imageBase64,  String? imageOriginalBase64,  Alignment imageAlignment,  String licensePlate,  FuelType? fuelType,  List<FuelEntry> fuel,  List<InsuranceData> insuranceDatas,  List<InspectionData> inspectionDatas,  List<TaxData> taxDatas,  List<RepairData> repairDatas,  List<FineData> fineDatas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Car() when $default != null:
return $default(_that.id,_that.name,_that.model,_that.manufacture,_that.yearOfManufacture,_that.imageUrl,_that.imageBase64,_that.imageOriginalBase64,_that.imageAlignment,_that.licensePlate,_that.fuelType,_that.fuel,_that.insuranceDatas,_that.inspectionDatas,_that.taxDatas,_that.repairDatas,_that.fineDatas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String model,  String manufacture,  int yearOfManufacture,  String? imageUrl,  String? imageBase64,  String? imageOriginalBase64,  Alignment imageAlignment,  String licensePlate,  FuelType? fuelType,  List<FuelEntry> fuel,  List<InsuranceData> insuranceDatas,  List<InspectionData> inspectionDatas,  List<TaxData> taxDatas,  List<RepairData> repairDatas,  List<FineData> fineDatas)  $default,) {final _that = this;
switch (_that) {
case _Car():
return $default(_that.id,_that.name,_that.model,_that.manufacture,_that.yearOfManufacture,_that.imageUrl,_that.imageBase64,_that.imageOriginalBase64,_that.imageAlignment,_that.licensePlate,_that.fuelType,_that.fuel,_that.insuranceDatas,_that.inspectionDatas,_that.taxDatas,_that.repairDatas,_that.fineDatas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String model,  String manufacture,  int yearOfManufacture,  String? imageUrl,  String? imageBase64,  String? imageOriginalBase64,  Alignment imageAlignment,  String licensePlate,  FuelType? fuelType,  List<FuelEntry> fuel,  List<InsuranceData> insuranceDatas,  List<InspectionData> inspectionDatas,  List<TaxData> taxDatas,  List<RepairData> repairDatas,  List<FineData> fineDatas)?  $default,) {final _that = this;
switch (_that) {
case _Car() when $default != null:
return $default(_that.id,_that.name,_that.model,_that.manufacture,_that.yearOfManufacture,_that.imageUrl,_that.imageBase64,_that.imageOriginalBase64,_that.imageAlignment,_that.licensePlate,_that.fuelType,_that.fuel,_that.insuranceDatas,_that.inspectionDatas,_that.taxDatas,_that.repairDatas,_that.fineDatas);case _:
  return null;

}
}

}

/// @nodoc


class _Car extends Car {
  const _Car({required this.id, required this.name, required this.model, required this.manufacture, required this.yearOfManufacture, this.imageUrl, this.imageBase64, this.imageOriginalBase64, this.imageAlignment = Alignment.center, this.licensePlate = '', this.fuelType, final  List<FuelEntry> fuel = const [], final  List<InsuranceData> insuranceDatas = const [], final  List<InspectionData> inspectionDatas = const [], final  List<TaxData> taxDatas = const [], final  List<RepairData> repairDatas = const [], final  List<FineData> fineDatas = const []}): _fuel = fuel,_insuranceDatas = insuranceDatas,_inspectionDatas = inspectionDatas,_taxDatas = taxDatas,_repairDatas = repairDatas,_fineDatas = fineDatas,super._();
  

@override final  String id;
@override final  String name;
@override final  String model;
@override final  String manufacture;
@override final  int yearOfManufacture;
@override final  String? imageUrl;
@override final  String? imageBase64;
@override final  String? imageOriginalBase64;
@override@JsonKey() final  Alignment imageAlignment;
@override@JsonKey() final  String licensePlate;
@override final  FuelType? fuelType;
 final  List<FuelEntry> _fuel;
@override@JsonKey() List<FuelEntry> get fuel {
  if (_fuel is EqualUnmodifiableListView) return _fuel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fuel);
}

 final  List<InsuranceData> _insuranceDatas;
@override@JsonKey() List<InsuranceData> get insuranceDatas {
  if (_insuranceDatas is EqualUnmodifiableListView) return _insuranceDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insuranceDatas);
}

 final  List<InspectionData> _inspectionDatas;
@override@JsonKey() List<InspectionData> get inspectionDatas {
  if (_inspectionDatas is EqualUnmodifiableListView) return _inspectionDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inspectionDatas);
}

 final  List<TaxData> _taxDatas;
@override@JsonKey() List<TaxData> get taxDatas {
  if (_taxDatas is EqualUnmodifiableListView) return _taxDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxDatas);
}

 final  List<RepairData> _repairDatas;
@override@JsonKey() List<RepairData> get repairDatas {
  if (_repairDatas is EqualUnmodifiableListView) return _repairDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repairDatas);
}

 final  List<FineData> _fineDatas;
@override@JsonKey() List<FineData> get fineDatas {
  if (_fineDatas is EqualUnmodifiableListView) return _fineDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fineDatas);
}


/// Create a copy of Car
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarCopyWith<_Car> get copyWith => __$CarCopyWithImpl<_Car>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Car&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.model, model) || other.model == model)&&(identical(other.manufacture, manufacture) || other.manufacture == manufacture)&&(identical(other.yearOfManufacture, yearOfManufacture) || other.yearOfManufacture == yearOfManufacture)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.imageOriginalBase64, imageOriginalBase64) || other.imageOriginalBase64 == imageOriginalBase64)&&(identical(other.imageAlignment, imageAlignment) || other.imageAlignment == imageAlignment)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&const DeepCollectionEquality().equals(other._fuel, _fuel)&&const DeepCollectionEquality().equals(other._insuranceDatas, _insuranceDatas)&&const DeepCollectionEquality().equals(other._inspectionDatas, _inspectionDatas)&&const DeepCollectionEquality().equals(other._taxDatas, _taxDatas)&&const DeepCollectionEquality().equals(other._repairDatas, _repairDatas)&&const DeepCollectionEquality().equals(other._fineDatas, _fineDatas));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,model,manufacture,yearOfManufacture,imageUrl,imageBase64,imageOriginalBase64,imageAlignment,licensePlate,fuelType,const DeepCollectionEquality().hash(_fuel),const DeepCollectionEquality().hash(_insuranceDatas),const DeepCollectionEquality().hash(_inspectionDatas),const DeepCollectionEquality().hash(_taxDatas),const DeepCollectionEquality().hash(_repairDatas),const DeepCollectionEquality().hash(_fineDatas));

@override
String toString() {
  return 'Car(id: $id, name: $name, model: $model, manufacture: $manufacture, yearOfManufacture: $yearOfManufacture, imageUrl: $imageUrl, imageBase64: $imageBase64, imageOriginalBase64: $imageOriginalBase64, imageAlignment: $imageAlignment, licensePlate: $licensePlate, fuelType: $fuelType, fuel: $fuel, insuranceDatas: $insuranceDatas, inspectionDatas: $inspectionDatas, taxDatas: $taxDatas, repairDatas: $repairDatas, fineDatas: $fineDatas)';
}


}

/// @nodoc
abstract mixin class _$CarCopyWith<$Res> implements $CarCopyWith<$Res> {
  factory _$CarCopyWith(_Car value, $Res Function(_Car) _then) = __$CarCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String model, String manufacture, int yearOfManufacture, String? imageUrl, String? imageBase64, String? imageOriginalBase64, Alignment imageAlignment, String licensePlate, FuelType? fuelType, List<FuelEntry> fuel, List<InsuranceData> insuranceDatas, List<InspectionData> inspectionDatas, List<TaxData> taxDatas, List<RepairData> repairDatas, List<FineData> fineDatas
});




}
/// @nodoc
class __$CarCopyWithImpl<$Res>
    implements _$CarCopyWith<$Res> {
  __$CarCopyWithImpl(this._self, this._then);

  final _Car _self;
  final $Res Function(_Car) _then;

/// Create a copy of Car
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? model = null,Object? manufacture = null,Object? yearOfManufacture = null,Object? imageUrl = freezed,Object? imageBase64 = freezed,Object? imageOriginalBase64 = freezed,Object? imageAlignment = null,Object? licensePlate = null,Object? fuelType = freezed,Object? fuel = null,Object? insuranceDatas = null,Object? inspectionDatas = null,Object? taxDatas = null,Object? repairDatas = null,Object? fineDatas = null,}) {
  return _then(_Car(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,manufacture: null == manufacture ? _self.manufacture : manufacture // ignore: cast_nullable_to_non_nullable
as String,yearOfManufacture: null == yearOfManufacture ? _self.yearOfManufacture : yearOfManufacture // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageOriginalBase64: freezed == imageOriginalBase64 ? _self.imageOriginalBase64 : imageOriginalBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageAlignment: null == imageAlignment ? _self.imageAlignment : imageAlignment // ignore: cast_nullable_to_non_nullable
as Alignment,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,fuelType: freezed == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType?,fuel: null == fuel ? _self._fuel : fuel // ignore: cast_nullable_to_non_nullable
as List<FuelEntry>,insuranceDatas: null == insuranceDatas ? _self._insuranceDatas : insuranceDatas // ignore: cast_nullable_to_non_nullable
as List<InsuranceData>,inspectionDatas: null == inspectionDatas ? _self._inspectionDatas : inspectionDatas // ignore: cast_nullable_to_non_nullable
as List<InspectionData>,taxDatas: null == taxDatas ? _self._taxDatas : taxDatas // ignore: cast_nullable_to_non_nullable
as List<TaxData>,repairDatas: null == repairDatas ? _self._repairDatas : repairDatas // ignore: cast_nullable_to_non_nullable
as List<RepairData>,fineDatas: null == fineDatas ? _self._fineDatas : fineDatas // ignore: cast_nullable_to_non_nullable
as List<FineData>,
  ));
}


}

// dart format on
