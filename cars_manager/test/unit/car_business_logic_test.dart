import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:flutter_test/flutter_test.dart';

Car _emptyCar() => Car(
  id: '1',
  name: 'TestCar',
  model: 'Model3',
  manufacture: 'Tesla',
  yearOfManufacture: 2022,
  insuranceExpirationDate: DateTime(2026),
);

void main() {
  group('Car.totalFuelCost', () {
    test('returns 0 when no fuel entries', () {
      expect(_emptyCar().totalFuelCost, 0.0);
    });

    test('sums totalCost of all fuel entries', () {
      final car = _emptyCar().copyWith(
        fuel: [
          FuelEntry(
            fuelType: FuelType.petrol,
            liters: 40,
            totalCost: 60.0,
            pricePerLiter: 1.5,
            date: DateTime(2024),
          ),
          FuelEntry(
            fuelType: FuelType.petrol,
            liters: 30,
            totalCost: 45.0,
            pricePerLiter: 1.5,
            date: DateTime(2024, 2),
          ),
        ],
      );
      expect(car.totalFuelCost, 105.0);
    });
  });

  group('Car.nextInspectionDate', () {
    test('returns null when no inspections', () {
      expect(_emptyCar().nextInspectionDate, isNull);
    });

    test('adds 2 years to the latest inspection date', () {
      final inspectionDate = DateTime(2023, 6);
      final car = _emptyCar().copyWith(
        inspectionDatas: [InspectionData(date: inspectionDate, isPassed: true)],
      );
      // 730 days after 2023-06-01 = 2025-05-31 (2024 is a leap year)
      expect(
        car.nextInspectionDate,
        inspectionDate.add(const Duration(days: 365 * 2)),
      );
    });

    test('uses the most recent inspection when multiple exist', () {
      final car = _emptyCar().copyWith(
        inspectionDatas: [
          InspectionData(date: DateTime(2021), isPassed: true),
          InspectionData(date: DateTime(2023), isPassed: true),
        ],
      );
      expect(
        car.nextInspectionDate,
        DateTime(2023).add(const Duration(days: 365 * 2)),
      );
    });
  });

  group('Car.totalPaidExpenses', () {
    test('sums all expense types', () {
      final car = _emptyCar().copyWith(
        insuranceDatas: [
          InsuranceData(
            insuranceCompany: 'ACME',
            policyNumber: 'P1',
            startDate: DateTime(2023),
            endDate: DateTime(2024),
            premiumAmount: 500,
          ),
        ],
        inspectionDatas: [
          InspectionData(date: DateTime(2023), isPassed: true, amount: 80),
        ],
        taxDatas: [TaxData(date: DateTime(2023), amount: 120)],
        repairDatas: [
          RepairData(date: DateTime(2023), description: 'Brakes', amount: 200),
        ],
        fineDatas: [
          FineData(date: DateTime(2023), type: FineType.speeding, amount: 150),
        ],
      );
      expect(car.totalPaidExpenses, 500 + 80 + 120 + 200 + 150);
    });

    test('returns 0 when no expenses', () {
      expect(_emptyCar().totalPaidExpenses, 0);
    });
  });

  group('Car.nextTaxDueDate', () {
    test('returns null when no taxes', () {
      expect(_emptyCar().nextTaxDueDate, isNull);
    });

    test('adds 365 days to the latest tax date', () {
      final taxDate = DateTime(2024, 1, 15);
      final car = _emptyCar().copyWith(
        taxDatas: [TaxData(date: taxDate, amount: 100)],
      );
      expect(car.nextTaxDueDate, taxDate.add(const Duration(days: 365)));
    });
  });

  group('Car.fuelCostByType', () {
    test('groups costs by fuel type', () {
      final car = _emptyCar().copyWith(
        fuel: [
          FuelEntry(
            fuelType: FuelType.petrol,
            liters: 40,
            totalCost: 60.0,
            pricePerLiter: 1.5,
            date: DateTime(2024),
          ),
          FuelEntry(
            fuelType: FuelType.diesel,
            liters: 50,
            totalCost: 70.0,
            pricePerLiter: 1.4,
            date: DateTime(2024, 2),
          ),
          FuelEntry(
            fuelType: FuelType.petrol,
            liters: 30,
            totalCost: 45.0,
            pricePerLiter: 1.5,
            date: DateTime(2024, 3),
          ),
        ],
      );
      final costs = car.fuelCostByType;
      expect(costs[FuelType.petrol], 105.0);
      expect(costs[FuelType.diesel], 70.0);
    });
  });
}
