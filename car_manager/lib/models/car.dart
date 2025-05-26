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
  DateTime carInspectionDate;

  BodySpecs? bodySpecs;
  EngineSpecs? engineSpecs;
  PerformanceSpecs? performanceSpecs;
  FuelConsumption? fuelConsumption;

  Car({
    required this.name,
    required this.model,
    required this.setUp,
    required this.manufacture,
    required this.yearOfManufacture,
    this.originalPrice,
    this.productionStartYear,
    this.productionEndYear,
    required this.licensePlate,
    required this.acquisitionDate,
    required this.insuranceExpirationDate,
    required this.carInspectionDate,
    this.bodySpecs,
    this.engineSpecs,
    this.performanceSpecs,
    this.fuelConsumption,
    this.imageUrl,
    this.imageAlignment = Alignment.center,
  });
}
