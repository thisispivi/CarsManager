import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.freezed.dart';

@freezed
abstract class Car with _$Car {
  const Car._();

  const factory Car({
    required String id,
    required String name,
    required String model,
    required String manufacture,
    required int yearOfManufacture,
    String? imageUrl,
    String? imageBase64,
    String? imageOriginalBase64,
    @Default(Alignment.center) Alignment imageAlignment,
    @Default('') String licensePlate,
    required DateTime insuranceExpirationDate,
    FuelType? fuelType,
    @Default([]) List<FuelEntry> fuel,
    @Default([]) List<InsuranceData> insuranceDatas,
    @Default([]) List<InspectionData> inspectionDatas,
    @Default([]) List<TaxData> taxDatas,
    @Default([]) List<RepairData> repairDatas,
    @Default([]) List<FineData> fineDatas,
  }) = _Car;

  double get totalFuelCost => fuel.fold(0.0, (sum, e) => sum + e.totalCost);

  Map<FuelType, double> get fuelCostByType {
    final Map<FuelType, double> totals = {};
    for (final entry in fuel) {
      totals[entry.fuelType] = (totals[entry.fuelType] ?? 0) + entry.totalCost;
    }
    totals.removeWhere((_, v) => v <= 0);
    return totals;
  }

  InspectionData? get _latestInspection => inspectionDatas.isEmpty
      ? null
      : inspectionDatas.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

  DateTime? get nextInspectionDate =>
      _latestInspection?.date.add(const Duration(days: 365 * 2));

  int? get daysUntilNextInspection {
    final next = nextInspectionDate;
    if (next == null) return null;
    return next.difference(DateTime.now()).inDays;
  }

  int get totalPaidInspections =>
      inspectionDatas.fold(0, (sum, d) => sum + (d.amount?.toInt() ?? 0));

  InsuranceData? get _latestInsurance => insuranceDatas.isEmpty
      ? null
      : insuranceDatas.reduce((a, b) => a.endDate.isAfter(b.endDate) ? a : b);

  DateTime? get nextInsuranceExpirationDate => _latestInsurance?.endDate;

  int? get daysUntilNextInsuranceExpiration {
    final next = nextInsuranceExpirationDate;
    if (next == null) return null;
    return next.difference(DateTime.now()).inDays;
  }

  int get totalPaidInsurances =>
      insuranceDatas.fold(0, (sum, d) => sum + d.premiumAmount.toInt());

  TaxData? get _latestTax => taxDatas.isEmpty
      ? null
      : taxDatas.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

  DateTime? get nextTaxDueDate =>
      _latestTax?.date.add(const Duration(days: 365));

  int? get daysUntilNextTaxDue {
    final next = nextTaxDueDate;
    if (next == null) return null;
    return next.difference(DateTime.now()).inDays;
  }

  int get totalPaidTaxes =>
      taxDatas.fold(0, (sum, d) => sum + d.amount.toInt());

  int get totalPaidFines =>
      fineDatas.fold(0, (sum, d) => sum + d.amount.toInt());

  int get totalPaidRepairs =>
      repairDatas.fold(0, (sum, d) => sum + d.amount.toInt());

  int get totalPaidExpenses =>
      totalPaidInspections +
      totalPaidInsurances +
      totalPaidTaxes +
      totalPaidRepairs +
      totalPaidFines;
}
