import 'dart:convert';
import 'package:cars_manager/data/car_storage.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/manufacture.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/painting.dart';

Car currentCar = _getDefaultCar();

List<dynamic>? _carsJsonCache;

Future<void> loadCarData() async {
  try {
    final String jsonString = await CarStorage.loadOrCreateJson();
    final List<dynamic> jsonData = json.decode(jsonString);
    _carsJsonCache = jsonData;

    if (jsonData.isNotEmpty) {
      final Map<String, dynamic> carJson = jsonData[0];
      currentCar = _carFromJson(carJson);
    }
  } catch (e) {
    currentCar = _getDefaultCar();
  }
}

Future<void> saveCarData() async {
  final existingList = _carsJsonCache;

  if (existingList == null || existingList.isEmpty) {
    final list = [_mergeCarJson({}, currentCar)];
    _carsJsonCache = list;
    await CarStorage.saveJson(jsonEncode(list));
    return;
  }

  final first = existingList[0];
  final original = first is Map<String, dynamic> ? first : <String, dynamic>{};
  existingList[0] = _mergeCarJson(original, currentCar);
  await CarStorage.saveJson(jsonEncode(existingList));
}

Map<String, dynamic> _mergeCarJson(Map<String, dynamic> original, Car car) {
  return {...original, ..._carToJson(car)};
}

Car _carFromJson(Map<String, dynamic> json) {
  return Car(
    name: json['name'],
    model: json['model'],
    setUp: json['setUp'],
    manufacture: _getManufactureFromName(json['manufacture']),
    yearOfManufacture: json['yearOfManufacture'],
    originalPrice: json['originalPrice'],
    productionStartYear: json['productionStartYear'],
    productionEndYear: json['productionEndYear'],
    licensePlate: json['licensePlate'],
    insuranceExpirationDate: DateTime.parse(json['insuranceExpirationDate']),
    imageUrl: json['imageUrl'],
    imageAlignment: _parseAlignment(json['imageAlignment']),
    fuel: json['fuel'] != null ? _fuelEntriesFromJson(json['fuel']) : null,
    inspectionDatas: json['inspectionDatas'] != null
        ? _inspectionDataFromJson(json['inspectionDatas'])
        : null,
    insuranceDatas: json['insuranceDatas'] != null
        ? _insuranceDataFromJson(json['insuranceDatas'])
        : null,
    taxDatas: json['taxDatas'] != null
        ? _taxDataFromJson(json['taxDatas'])
        : null,
    repairDatas: json['repairDatas'] != null
        ? _repairDataFromJson(json['repairDatas'])
        : null,
    fineDatas: json['fineDatas'] != null
        ? _fineDataFromJson(json['fineDatas'])
        : null,
  );
}

Map<String, dynamic> _carToJson(Car car) {
  return {
    'name': car.name,
    'model': car.model,
    'setUp': car.setUp,
    'manufacture': car.manufacture.name,
    'yearOfManufacture': car.yearOfManufacture,
    'originalPrice': car.originalPrice,
    'productionStartYear': car.productionStartYear,
    'productionEndYear': car.productionEndYear,
    'imageUrl': car.imageUrl,
    'imageAlignment': _alignmentToString(car.imageAlignment),
    'licensePlate': car.licensePlate,
    'insuranceExpirationDate': car.insuranceExpirationDate.toIso8601String(),
    'fuel': car.fuel?.map(_fuelEntryToJson).toList(),
    'inspectionDatas': car.inspectionDatas
        ?.map(
          (e) => {
            'date': e.date.toIso8601String(),
            'isPassed': e.isPassed,
            'amount': e.amount,
            'mileage': e.mileage,
          },
        )
        .toList(),
    'insuranceDatas': car.insuranceDatas
        ?.map(
          (e) => {
            'startDate': e.startDate.toIso8601String(),
            'endDate': e.endDate.toIso8601String(),
            'insuranceCompany': e.insuranceCompany,
            'policyNumber': e.policyNumber,
            'extensionDate': e.extensionDate?.toIso8601String(),
            'premiumAmount': e.premiumAmount,
          },
        )
        .toList(),
    'taxDatas': car.taxDatas
        ?.map((e) => {'date': e.date.toIso8601String(), 'amount': e.amount})
        .toList(),
    'repairDatas': car.repairDatas
        ?.map(
          (e) => {
            'date': e.date.toIso8601String(),
            'amount': e.amount,
            'description': e.description,
          },
        )
        .toList(),
    'fineDatas': car.fineDatas
        ?.map(
          (e) => {
            'date': e.date.toIso8601String(),
            'amount': e.amount,
            'type': e.type.name,
          },
        )
        .toList(),
  };
}

String? _alignmentToString(Alignment? alignment) {
  if (alignment == null) return null;
  if (alignment == Alignment.bottomCenter) return 'bottomCenter';
  if (alignment == Alignment.topCenter) return 'topCenter';
  return 'center';
}

Alignment _parseAlignment(String? alignmentStr) {
  switch (alignmentStr) {
    case 'bottomCenter':
      return Alignment.bottomCenter;
    case 'center':
      return Alignment.center;
    case 'topCenter':
      return Alignment.topCenter;
    default:
      return Alignment.center;
  }
}

Manufacture _getManufactureFromName(String name) {
  switch (name.toLowerCase()) {
    case 'fiat':
      return fiat;
    default:
      return Manufacture(name: name, logoSrc: 'assets/logos/default.svg');
  }
}

FuelType _parseFuelType(String type) {
  switch (type) {
    case 'petrol':
      return FuelType.petrol;
    case 'diesel':
      return FuelType.diesel;
    case 'lpg':
      return FuelType.lpg;
    case 'electric':
      return FuelType.electric;
    case 'hybrid':
      return FuelType.hybrid;
    default:
      return FuelType.petrol;
  }
}

List<FuelEntry> _fuelEntriesFromJson(List<dynamic> json) {
  return json.map((item) {
    return FuelEntry(
      fuelType: _parseFuelType((item['fuelType'] ?? 'petrol').toString()),
      liters: (item['liters'] ?? 0).toDouble(),
      totalCost: (item['totalCost'] ?? 0).toDouble(),
      pricePerLiter: (item['pricePerLiter'] ?? 0).toDouble(),
      date: DateTime.parse(item['date']),
    );
  }).toList();
}

Map<String, dynamic> _fuelEntryToJson(FuelEntry e) {
  return {
    'fuelType': e.fuelType.name,
    'liters': e.liters,
    'totalCost': e.totalCost,
    'pricePerLiter': e.pricePerLiter,
    'date': e.date.toIso8601String(),
  };
}

List<InspectionData> _inspectionDataFromJson(List<dynamic> json) {
  return json.map((item) {
    return InspectionData(
      date: DateTime.parse(item['date']),
      isPassed: item['isPassed'],
      amount: item['amount']?.toDouble(),
      mileage: item['mileage']?.toDouble(),
    );
  }).toList();
}

List<InsuranceData> _insuranceDataFromJson(List<dynamic> json) {
  return json.map((item) {
    return InsuranceData(
      startDate: DateTime.parse(item['startDate']),
      endDate: DateTime.parse(item['endDate']),
      insuranceCompany: item['insuranceCompany'],
      policyNumber: item['policyNumber'],
      extensionDate: item['extensionDate'] != null
          ? DateTime.parse(item['extensionDate'])
          : null,
      premiumAmount: item['premiumAmount']?.toDouble(),
    );
  }).toList();
}

List<TaxData> _taxDataFromJson(List<dynamic> json) {
  return json.map((item) {
    return TaxData(
      date: DateTime.parse(item['date']),
      amount: item['amount']?.toDouble(),
    );
  }).toList();
}

List<RepairData> _repairDataFromJson(List<dynamic> json) {
  return json.map((item) {
    return RepairData(
      date: DateTime.parse(item['date']),
      amount: (item['amount'] ?? 0).toDouble(),
      description: (item['description'] ?? '').toString(),
    );
  }).toList();
}

FineType _parseFineType(String type) {
  switch (type) {
    case 'speeding':
      return FineType.speeding;
    case 'parking':
      return FineType.parking;
    case 'redLight':
      return FineType.redLight;
    case 'other':
      return FineType.other;
    default:
      return FineType.other;
  }
}

List<FineData> _fineDataFromJson(List<dynamic> json) {
  return json.map((item) {
    return FineData(
      date: DateTime.parse(item['date']),
      amount: item['amount'].toDouble(),
      type: _parseFineType(item['type']),
    );
  }).toList();
}

Car _getDefaultCar() {
  return Car(
    name: "Demo Vehicle",
    model: "Prototype XZ",
    setUp: "Standard Edition",
    manufacture: fiat,
    yearOfManufacture: 2018,
    originalPrice: 24500,
    productionStartYear: 2016,
    productionEndYear: 2021,
    licensePlate: "XY789ZW",
    insuranceExpirationDate: DateTime(2024, 6, 15),
    imageUrl: "https://cdn.motor1.com/images/mgl/nOpO1/s3/1992-ferrari-f40.jpg",
    imageAlignment: Alignment.center,
    fuel: [],
    inspectionDatas: [],
    insuranceDatas: [],
  );
}
