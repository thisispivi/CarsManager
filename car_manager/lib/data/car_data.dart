import 'dart:convert';
import 'package:car_manager/models/fine_data.dart';
import 'package:car_manager/models/inspection_data.dart';
import 'package:car_manager/models/insurance_data.dart';
import 'package:car_manager/models/repair_data.dart';
import 'package:car_manager/models/tax_data.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/painting.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/models/body_specs.dart';
import 'package:car_manager/models/engine_specs.dart';
import 'package:car_manager/models/performance_specs.dart';
import 'package:car_manager/models/fuel_consumption.dart';
import 'package:car_manager/models/manufacture.dart';

Car currentCar = _getDefaultCar();

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
    insuranceExpirationDate: DateTime.parse(json['insuranceExpirationDate']),
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
    inspectionDatas: [
      InspectionData(
        date: DateTime(2023, 1, 15),
        isPassed: true,
        amount: 0.0,
        mileage: 15000.0,
      ),
      InspectionData(
        date: DateTime(2024, 1, 15),
        isPassed: false,
        amount: 200.0,
        mileage: 30000.0,
      ),
    ],
    insuranceDatas: [
      InsuranceData(
        startDate: DateTime(2023, 6, 1),
        endDate: DateTime(2024, 6, 1),
        insuranceCompany: "Demo Insurance Co.",
        policyNumber: "INS123456",
        extensionDate: null,
        premiumAmount: 1200.0,
      ),
    ],
  );
}
