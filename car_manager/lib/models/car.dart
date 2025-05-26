import 'package:car_manager/models/inspection_data.dart';
import 'package:car_manager/models/manufacture.dart';
import 'package:car_manager/models/body_specs.dart';
import 'package:car_manager/models/engine_specs.dart';
import 'package:car_manager/models/performance_specs.dart';
import 'package:car_manager/models/fuel_consumption.dart';
import 'package:flutter/painting.dart';

class Car {
  String name;
  String model;
  String setUp;
  Manufacture manufacture;
  int yearOfManufacture;
  int? originalPrice;
  int? productionStartYear;
  int? productionEndYear;
  String? imageUrl;
  Alignment? imageAlignment;

  String licensePlate;
  DateTime acquisitionDate;
  DateTime insuranceExpirationDate;

  BodySpecs? bodySpecs;
  EngineSpecs? engineSpecs;
  PerformanceSpecs? performanceSpecs;
  FuelConsumption? fuelConsumption;

  List<InspectionData>? carInspectionsData;

  Car({
    required this.name,
    required this.model,
    required this.setUp,
    required this.manufacture,
    required this.yearOfManufacture,
    this.originalPrice,
    this.productionStartYear,
    this.productionEndYear,
    this.imageUrl,
    this.imageAlignment = Alignment.center,

    required this.licensePlate,
    required this.acquisitionDate,
    required this.insuranceExpirationDate,

    this.bodySpecs,
    this.engineSpecs,
    this.performanceSpecs,
    this.fuelConsumption,

    this.carInspectionsData,
  });

  _getLatestInspection() {
    if (carInspectionsData == null || carInspectionsData!.isEmpty) {
      return null;
    }

    return carInspectionsData!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  }

  getNextInspectionDate() {
    if (carInspectionsData == null || carInspectionsData!.isEmpty) {
      return null;
    }

    final latestInspection = _getLatestInspection();
    if (latestInspection == null) {
      return null;
    }

    return latestInspection.date.add(Duration(days: 365 * 2));
  }

  getDaysUntilNextInspection() {
    final nextInspectionDate = getNextInspectionDate();
    if (nextInspectionDate == null) {
      return null;
    }

    final now = DateTime.now();
    return nextInspectionDate.difference(now).inDays;
  }
}
