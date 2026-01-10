enum FuelType { petrol, diesel, lpg, electric, hybrid }

class FuelEntry {
  final FuelType fuelType;
  final double liters;
  final double totalCost;
  final double pricePerLiter;
  final DateTime date;

  const FuelEntry({
    required this.fuelType,
    required this.liters,
    required this.totalCost,
    required this.pricePerLiter,
    required this.date,
  });
}
