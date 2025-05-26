import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/painting.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/models/body_specs.dart';
import 'package:car_manager/models/engine_specs.dart';
import 'package:car_manager/models/performance_specs.dart';
import 'package:car_manager/models/fuel_consumption.dart';
import 'package:car_manager/models/manufacture.dart';

late Car currentCar;

Future<void> loadCarData() async {
  try {
    final String jsonString = await rootBundle.loadString(
      'assets/data/cars.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);

    if (jsonData.isNotEmpty) {
      final Map<String, dynamic> carJson = jsonData[0];
      currentCar = _carFromJson(carJson);
    }
  } catch (e) {
    print('Error loading car data: $e');
    currentCar = _getDefaultCar();
  }
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
    acquisitionDate: DateTime.parse(json['acquisitionDate']),
    insuranceExpirationDate: DateTime.parse(json['insuranceExpirationDate']),
    carInspectionDate: DateTime.parse(json['carInspectionDate']),
    imageUrl: json['imageUrl'],
    imageAlignment: _parseAlignment(json['imageAlignment']),
    bodySpecs: json['bodySpecs'] != null
        ? _bodySpecsFromJson(json['bodySpecs'])
        : null,
    engineSpecs: json['engineSpecs'] != null
        ? _engineSpecsFromJson(json['engineSpecs'])
        : null,
    performanceSpecs: json['performanceSpecs'] != null
        ? _performanceSpecsFromJson(json['performanceSpecs'])
        : null,
    fuelConsumption: json['fuelConsumption'] != null
        ? _fuelConsumptionFromJson(json['fuelConsumption'])
        : null,
  );
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

BodySpecs _bodySpecsFromJson(Map<String, dynamic> json) {
  return BodySpecs(
    type: json['type'],
    doors: json['doors'],
    seats: json['seats'],
    trunkCapacity: json['trunkCapacity'],
    fuelTankCapacity: json['fuelTankCapacity'],
    weight: json['weight'],
    maxTowingWeight: json['maxTowingWeight'],
    length: json['length']?.toDouble(),
    width: json['width']?.toDouble(),
    height: json['height']?.toDouble(),
    wheelbase: json['wheelbase']?.toDouble(),
  );
}

EngineSpecs _engineSpecsFromJson(Map<String, dynamic> json) {
  return EngineSpecs(
    type: _parseEngineType(json['type']),
    displacement: json['displacement'],
    fuelType: _parseFuelType(json['fuelType']),
    maxPower: json['maxPower'],
    horsePower: json['horsePower'],
    engineSpeed: json['engineSpeed'],
    maxTorque: json['maxTorque'],
    driveType: _parseDriveType(json['driveType']),
    transmissionType: _parseTransmissionType(json['transmissionType']),
    gears: json['gears'],
  );
}

EngineType _parseEngineType(String type) {
  switch (type) {
    case 'fourCylinderInline':
      return EngineType.fourCylinderInline;
    case 'sixCylinderInline':
      return EngineType.sixCylinderInline;
    case 'v6':
      return EngineType.v6;
    case 'v8':
      return EngineType.v8;
    case 'v12':
      return EngineType.v12;
    default:
      return EngineType.fourCylinderInline;
  }
}

FuelType _parseFuelType(String type) {
  switch (type) {
    case 'petrol':
      return FuelType.petrol;
    case 'diesel':
      return FuelType.diesel;
    case 'electric':
      return FuelType.electric;
    case 'hybrid':
      return FuelType.hybrid;
    default:
      return FuelType.petrol;
  }
}

DriveType _parseDriveType(String type) {
  switch (type) {
    case 'fwd':
      return DriveType.fwd;
    case 'rwd':
      return DriveType.rwd;
    case 'awd':
      return DriveType.awd;
    case 'fourWheelDrive':
      return DriveType.fourWheelDrive;
    default:
      return DriveType.fwd;
  }
}

TransmissionType _parseTransmissionType(String type) {
  switch (type) {
    case 'manual':
      return TransmissionType.manual;
    case 'automatic':
      return TransmissionType.automatic;
    case 'semiAutomatic':
      return TransmissionType.semiAutomatic;
    default:
      return TransmissionType.manual;
  }
}

PerformanceSpecs _performanceSpecsFromJson(Map<String, dynamic> json) {
  return PerformanceSpecs(
    maxSpeed: json['maxSpeed'],
    zeroToHundred: json['zeroToHundred']?.toDouble(),
    co2Emissions: json['co2Emissions'],
    emissionStandard: json['emissionStandard'],
  );
}

FuelConsumption _fuelConsumptionFromJson(Map<String, dynamic> json) {
  return FuelConsumption(
    urban: json['urban']?.toDouble(),
    extraUrban: json['extraUrban']?.toDouble(),
    combined: json['combined']?.toDouble(),
  );
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
    acquisitionDate: DateTime(2022, 5, 12),
    insuranceExpirationDate: DateTime(2024, 6, 15),
    carInspectionDate: DateTime(2024, 8, 23),
    imageUrl: "https://cdn.motor1.com/images/mgl/nOpO1/s3/1992-ferrari-f40.jpg",
    imageAlignment: Alignment.center,
    bodySpecs: BodySpecs(
      type: "Crossover SUV",
      doors: 5,
      seats: 7,
      trunkCapacity: "650 - 1,780",
      fuelTankCapacity: 62,
      weight: 1685,
      maxTowingWeight: 1700,
      length: 4.67,
      width: 1.85,
      height: 1.68,
      wheelbase: 2.73,
    ),
    engineSpecs: EngineSpecs(
      type: EngineType.v6,
      displacement: 2450,
      fuelType: FuelType.hybrid,
      maxPower: 157,
      horsePower: 213,
      engineSpeed: 5500,
      maxTorque: 278,
      driveType: DriveType.awd,
      transmissionType: TransmissionType.automatic,
      gears: 8,
    ),
    performanceSpecs: PerformanceSpecs(
      maxSpeed: 230,
      zeroToHundred: 7.4,
      co2Emissions: 118,
      emissionStandard: "Euro 6d",
    ),
    fuelConsumption: FuelConsumption(
      urban: 6.2,
      extraUrban: 4.9,
      combined: 5.4,
    ),
  );
}
