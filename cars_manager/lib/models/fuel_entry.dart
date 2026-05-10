import 'package:freezed_annotation/freezed_annotation.dart';

part 'fuel_entry.freezed.dart';

enum FuelType { petrol, diesel, lpg, electric, hybrid }

@freezed
abstract class FuelEntry with _$FuelEntry {
  const factory FuelEntry({
    required FuelType fuelType,
    required double liters,
    required double totalCost,
    required double pricePerLiter,
    required DateTime date,
  }) = _FuelEntry;
}
