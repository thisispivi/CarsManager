import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/manufacture.dart';
import 'package:cars_manager/models/body_specs.dart';
import 'package:cars_manager/models/engine_specs.dart';
import 'package:cars_manager/models/performance_specs.dart';
import 'package:cars_manager/models/fuel_consumption.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
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

  DateTime insuranceExpirationDate;

  BodySpecs? bodySpecs;
  EngineSpecs? engineSpecs;
  PerformanceSpecs? performanceSpecs;
  FuelConsumption? fuelConsumption;

  List<InsuranceData>? insuranceDatas;
  List<InspectionData>? inspectionDatas;
  List<TaxData>? taxDatas;
  List<RepairData>? repairDatas;
  List<FineData>? fineDatas;

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

    required this.insuranceExpirationDate,

    this.bodySpecs,
    this.engineSpecs,
    this.performanceSpecs,
    this.fuelConsumption,

    this.inspectionDatas,
    this.insuranceDatas,
    this.taxDatas,
    this.repairDatas,
    this.fineDatas,
  });

  InspectionData? _getLatestInspection() {
    if (inspectionDatas == null || inspectionDatas!.isEmpty) {
      return null;
    }

    return inspectionDatas!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  }

  dynamic getNextInspectionDate() {
    if (inspectionDatas == null || inspectionDatas!.isEmpty) {
      return null;
    }

    final latestInspection = _getLatestInspection();
    if (latestInspection == null) {
      return null;
    }

    return latestInspection.date.add(Duration(days: 365 * 2));
  }

  dynamic getDaysUntilNextInspection() {
    final nextInspectionDate = getNextInspectionDate();
    if (nextInspectionDate == null) {
      return null;
    }

    final now = DateTime.now();
    return nextInspectionDate.difference(now).inDays;
  }

  int calculateTotalPaidInspections() {
    if (inspectionDatas == null || inspectionDatas!.isEmpty) {
      return 0;
    }

    return inspectionDatas!.fold(
      0,
      (sum, data) => sum + (data.amount?.toInt() ?? 0),
    );
  }

  InsuranceData? _getLatestInsurance() {
    if (insuranceDatas == null || insuranceDatas!.isEmpty) {
      return null;
    }

    return insuranceDatas!.reduce(
      (a, b) => a.endDate.isAfter(b.endDate) ? a : b,
    );
  }

  dynamic getNextInsuranceExpirationDate() {
    final latestInsurance = _getLatestInsurance();
    if (latestInsurance == null) {
      return null;
    }

    return latestInsurance.endDate;
  }

  dynamic getDaysUntilNextInsuranceExpiration() {
    final nextInsuranceDate = getNextInsuranceExpirationDate();
    if (nextInsuranceDate == null) {
      return null;
    }

    final now = DateTime.now();
    return nextInsuranceDate.difference(now).inDays;
  }

  int calculateTotalPaidInsurances() {
    if (insuranceDatas == null || insuranceDatas!.isEmpty) {
      return 0;
    }

    return insuranceDatas!.fold(
      0,
      (sum, data) => sum + (data.premiumAmount.toInt()),
    );
  }

  TaxData? _getLatestTax() {
    if (taxDatas == null || taxDatas!.isEmpty) {
      return null;
    }

    return taxDatas!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  }

  dynamic getNextTaxDueDate() {
    final latestTax = _getLatestTax();
    if (latestTax == null) {
      return null;
    }

    return latestTax.date.add(Duration(days: 365));
  }

  dynamic getDaysUntilNextTaxDue() {
    final nextTaxDueDate = getNextTaxDueDate();
    if (nextTaxDueDate == null) {
      return null;
    }

    final now = DateTime.now();
    return nextTaxDueDate.difference(now).inDays;
  }

  int calculateTotalPaidTaxes() {
    if (taxDatas == null || taxDatas!.isEmpty) {
      return 0;
    }

    return taxDatas!.fold(0, (sum, data) => sum + (data.amount.toInt()));
  }

  int calculateTotalPaidFines() {
    if (fineDatas == null || fineDatas!.isEmpty) {
      return 0;
    }

    return fineDatas!.fold(0, (sum, data) => sum + (data.amount.toInt()));
  }

  int calculateTotalPaidRepairs() {
    if (repairDatas == null || repairDatas!.isEmpty) {
      return 0;
    }

    return repairDatas!.fold(0, (sum, data) => sum + (data.amount.toInt()));
  }

  dynamic calculateTotalPaidExpenses() {
    return calculateTotalPaidInspections() +
        calculateTotalPaidInsurances() +
        calculateTotalPaidTaxes() +
        calculateTotalPaidRepairs() +
        calculateTotalPaidFines();
  }
}
