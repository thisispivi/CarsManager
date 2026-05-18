import 'dart:convert';
import 'package:cars_manager/core/storage/cars_storage.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/painting.dart';

class CarsDataSnapshot {
  final List<Car> cars;
  final String? activeCarId;
  final String? localeCode;
  final String? themeMode;
  final bool? notificationsEnabled;
  final String? units; // 'metric' or 'imperial' or similar
  final String? currency;

  const CarsDataSnapshot({
    required this.cars,
    required this.activeCarId,
    required this.localeCode,
    required this.themeMode,
    this.notificationsEnabled,
    this.units,
    this.currency,
  });
}

List<Car> loadedCars = <Car>[];
String? loadedActiveCarId;
String? loadedLocaleCode;
String? loadedThemeMode;
bool? loadedNotificationsEnabled;
String? loadedUnits;
String? loadedCurrency;

final Map<String, Map<String, dynamic>> _carJsonCacheById = {};

Future<void> loadCarData() async {
  try {
    final String jsonString = await CarsStorage.loadOrCreateJson();
    final dynamic root = json.decode(jsonString);
    final CarsDataSnapshot? snapshot = _parseCarsSnapshot(root);
    loadedCars = snapshot?.cars ?? [];
    loadedActiveCarId = snapshot?.activeCarId;
    loadedLocaleCode = snapshot?.localeCode;
    loadedThemeMode = snapshot?.themeMode;
    loadedNotificationsEnabled = snapshot?.notificationsEnabled;
    loadedUnits = snapshot?.units;
    loadedCurrency = snapshot?.currency;
  } catch (e) {
    loadedCars = [];
    loadedActiveCarId = null;
    loadedLocaleCode = null;
    loadedThemeMode = null;
    loadedNotificationsEnabled = null;
    loadedUnits = null;
    loadedCurrency = null;
  }
}

Future<void> saveCarData({
  required List<Car> cars,
  required String? activeCarId,
}) async {
  final List<Map<String, dynamic>> mergedCarsJson = cars.map((car) {
    final original = _carJsonCacheById[car.id] ?? <String, dynamic>{};
    final merged = _mergeCarJson(original, car);
    _carJsonCacheById[car.id] = merged;
    return merged;
  }).toList();

  final root = {
    'activeCarId': activeCarId,
    'cars': mergedCarsJson,
    'preferences': {
      'locale': loadedLocaleCode,
      'themeMode': loadedThemeMode,
      'notificationsEnabled': loadedNotificationsEnabled,
      'units': loadedUnits,
      'currency': loadedCurrency,
    },
  };

  await CarsStorage.saveJson(jsonEncode(root));
}

Map<String, dynamic> _mergeCarJson(Map<String, dynamic> original, Car car) {
  return {...original, ..._carToJson(car)};
}

CarsDataSnapshot? _parseCarsSnapshot(dynamic root) {
  if (root is List) {
    final carsJson = root.whereType<Map<String, dynamic>>().toList();

    final List<Car> cars = [];
    for (final entry in carsJson) {
      final car = _carFromJson(entry);
      cars.add(car);

      final cached = Map<String, dynamic>.from(entry);
      cached['id'] = car.id;
      _carJsonCacheById[car.id] = cached;
    }

    return CarsDataSnapshot(
      cars: cars,
      activeCarId: cars.isNotEmpty ? cars.first.id : null,
      localeCode: null,
      themeMode: null,
    );
  }

  if (root is Map<String, dynamic>) {
    final String? activeCarId = root['activeCarId']?.toString();
    final prefs = root['preferences'];
    final String? localeCode = (prefs is Map)
        ? prefs['locale']?.toString()
        : null;
    final String? themeMode = (prefs is Map)
        ? prefs['themeMode']?.toString()
        : null;
    final bool? notificationsEnabled = (prefs is Map)
        ? (prefs['notificationsEnabled'] as bool?)
        : null;
    final String? units = (prefs is Map) ? prefs['units']?.toString() : null;
    final String? currency = (prefs is Map)
        ? prefs['currency']?.toString()
        : null;
    final List<dynamic> carsList = (root['cars'] is List)
        ? (root['cars'] as List)
        : const [];
    final carsJson = carsList.whereType<Map<String, dynamic>>().toList();

    final List<Car> cars = [];
    for (final entry in carsJson) {
      final car = _carFromJson(entry);
      cars.add(car);

      final cached = Map<String, dynamic>.from(entry);
      cached['id'] = car.id;
      _carJsonCacheById[car.id] = cached;
    }

    final resolvedActiveId =
        (activeCarId != null && cars.any((c) => c.id == activeCarId))
        ? activeCarId
        : (cars.isNotEmpty ? cars.first.id : null);

    return CarsDataSnapshot(
      cars: cars,
      activeCarId: resolvedActiveId,
      localeCode: localeCode,
      themeMode: themeMode,
      notificationsEnabled: notificationsEnabled,
      units: units,
      currency: currency,
    );
  }
  return null;
}

void setLoadedPreferences({
  String? localeCode,
  String? themeMode,
  bool? notificationsEnabled,
  String? units,
  String? currency,
}) {
  if (localeCode != null) {
    loadedLocaleCode = localeCode;
  }
  if (themeMode != null) {
    loadedThemeMode = themeMode;
  }
  if (notificationsEnabled != null) {
    loadedNotificationsEnabled = notificationsEnabled;
  }
  if (units != null) {
    loadedUnits = units;
  }
  if (currency != null) {
    loadedCurrency = currency;
  }
}

String _generateCarId() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

Car _carFromJson(Map<String, dynamic> json) {
  final String id = (json['id']?.toString().trim().isNotEmpty ?? false)
      ? json['id'].toString()
      : _generateCarId();

  return Car(
    id: id,
    name: (json['name'] ?? 'Unnamed').toString(),
    model: (json['model'] ?? '').toString(),
    manufacture: (json['manufacture'] ?? 'Unknown').toString(),
    yearOfManufacture: (json['yearOfManufacture'] ?? 0) is int
        ? (json['yearOfManufacture'] as int)
        : int.tryParse(json['yearOfManufacture']?.toString() ?? '') ?? 0,
    licensePlate: (json['licensePlate'] ?? '').toString(),
    imageUrl: json['imageUrl'],
    imageBase64: (json['imageBase64'] ?? json['image_base64'])?.toString(),
    imageOriginalBase64:
        (json['imageOriginalBase64'] ?? json['image_original_base64'])
            ?.toString(),
    imageAlignment: _parseAlignment(json['imageAlignment']),
    fuelType:
        (json['fuelType'] == null || json['fuelType'].toString().trim().isEmpty)
        ? null
        : _parseFuelType(json['fuelType'].toString()),
    fuel: json['fuel'] != null ? _fuelEntriesFromJson(json['fuel']) : [],
    inspectionDatas: json['inspectionDatas'] != null
        ? _inspectionDataFromJson(json['inspectionDatas'])
        : [],
    insuranceDatas: json['insuranceDatas'] != null
        ? _insuranceDataFromJson(json['insuranceDatas'])
        : [],
    taxDatas: json['taxDatas'] != null
        ? _taxDataFromJson(json['taxDatas'])
        : [],
    repairDatas: json['repairDatas'] != null
        ? _repairDataFromJson(json['repairDatas'])
        : [],
    fineDatas: json['fineDatas'] != null
        ? _fineDataFromJson(json['fineDatas'])
        : [],
  );
}

Map<String, dynamic> _carToJson(Car car) {
  return {
    'id': car.id,
    'name': car.name,
    'model': car.model,
    'manufacture': car.manufacture,
    'yearOfManufacture': car.yearOfManufacture,
    'imageUrl': car.imageUrl,
    'imageBase64': car.imageBase64,
    'imageOriginalBase64': car.imageOriginalBase64,
    'imageAlignment': _alignmentToString(car.imageAlignment),
    'licensePlate': car.licensePlate,
    'fuelType': car.fuelType?.name,
    'fuel': car.fuel.map(_fuelEntryToJson).toList(),
    'inspectionDatas': car.inspectionDatas
        .map(
          (e) => {
            'date': e.date.toIso8601String(),
            'isPassed': e.isPassed,
            'amount': e.amount,
            'mileage': e.mileage,
          },
        )
        .toList(),
    'insuranceDatas': car.insuranceDatas
        .map(
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
        .map((e) => {'date': e.date.toIso8601String(), 'amount': e.amount})
        .toList(),
    'repairDatas': car.repairDatas
        .map(
          (e) => {
            'date': e.date.toIso8601String(),
            'amount': e.amount,
            'description': e.description,
          },
        )
        .toList(),
    'fineDatas': car.fineDatas
        .map(
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
