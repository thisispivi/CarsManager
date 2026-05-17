import 'package:cars_manager/app/state/cars_manager_provider.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses_notifier.g.dart';

class ExpenseCollections {
  const ExpenseCollections({
    required this.insurance,
    required this.inspections,
    required this.taxes,
    required this.repairs,
    required this.fines,
  });

  final List<InsuranceData> insurance;
  final List<InspectionData> inspections;
  final List<TaxData> taxes;
  final List<RepairData> repairs;
  final List<FineData> fines;
}

@riverpod
ExpenseCollections expenses(Ref ref) {
  final car = ref.watch(carsManagerStateProvider).activeCar;
  return ExpenseCollections(
    insurance: car?.insuranceDatas ?? const <InsuranceData>[],
    inspections: car?.inspectionDatas ?? const <InspectionData>[],
    taxes: car?.taxDatas ?? const <TaxData>[],
    repairs: car?.repairDatas ?? const <RepairData>[],
    fines: car?.fineDatas ?? const <FineData>[],
  );
}

@riverpod
class ExpensesController extends _$ExpensesController {
  @override
  ExpenseCollections build() {
    return ref.watch(expensesProvider);
  }

  /// Adds an insurance payment to the active car.
  void addInsurance(InsuranceData data) {
    ref.read(carsManagerStateProvider).addInsurancePayment(data);
  }

  /// Adds an inspection payment to the active car.
  void addInspection(InspectionData data) {
    ref.read(carsManagerStateProvider).addInspectionPayment(data);
  }

  /// Adds a tax payment to the active car.
  void addTax(TaxData data) {
    ref.read(carsManagerStateProvider).addTaxPayment(data);
  }

  /// Adds a repair payment to the active car.
  void addRepair(RepairData data) {
    ref.read(carsManagerStateProvider).addRepairPayment(data);
  }

  /// Adds a fine payment to the active car.
  void addFine(FineData data) {
    ref.read(carsManagerStateProvider).addFinePayment(data);
  }

  /// Replaces an existing insurance payment with updated data.
  void updateInsurance({
    required InsuranceData oldData,
    required InsuranceData data,
  }) {
    ref
        .read(carsManagerStateProvider)
        .updateInsurancePayment(oldData: oldData, data: data);
  }

  /// Removes an insurance payment from the active car.
  void removeInsurance(InsuranceData data) {
    ref.read(carsManagerStateProvider).removeInsurancePayment(data);
  }

  /// Replaces an existing inspection payment with updated data.
  void updateInspection({
    required InspectionData oldData,
    required InspectionData data,
  }) {
    ref
        .read(carsManagerStateProvider)
        .updateInspectionPayment(oldData: oldData, data: data);
  }

  /// Removes an inspection payment from the active car.
  void removeInspection(InspectionData data) {
    ref.read(carsManagerStateProvider).removeInspectionPayment(data);
  }

  /// Replaces an existing tax payment with updated data.
  void updateTax({required TaxData oldData, required TaxData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateTaxPayment(oldData: oldData, data: data);
  }

  /// Removes a tax payment from the active car.
  void removeTax(TaxData data) {
    ref.read(carsManagerStateProvider).removeTaxPayment(data);
  }

  /// Replaces an existing repair payment with updated data.
  void updateRepair({required RepairData oldData, required RepairData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateRepairPayment(oldData: oldData, data: data);
  }

  /// Removes a repair payment from the active car.
  void removeRepair(RepairData data) {
    ref.read(carsManagerStateProvider).removeRepairPayment(data);
  }

  /// Replaces an existing fine payment with updated data.
  void updateFine({required FineData oldData, required FineData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateFinePayment(oldData: oldData, data: data);
  }

  /// Removes a fine payment from the active car.
  void removeFine(FineData data) {
    ref.read(carsManagerStateProvider).removeFinePayment(data);
  }
}
