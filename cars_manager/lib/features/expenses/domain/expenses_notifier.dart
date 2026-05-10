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

  void addInsurance(InsuranceData data) {
    ref.read(carsManagerStateProvider).addInsurancePayment(data);
  }

  void addInspection(InspectionData data) {
    ref.read(carsManagerStateProvider).addInspectionPayment(data);
  }

  void addTax(TaxData data) {
    ref.read(carsManagerStateProvider).addTaxPayment(data);
  }

  void addRepair(RepairData data) {
    ref.read(carsManagerStateProvider).addRepairPayment(data);
  }

  void addFine(FineData data) {
    ref.read(carsManagerStateProvider).addFinePayment(data);
  }

  void updateInsurance({
    required InsuranceData oldData,
    required InsuranceData data,
  }) {
    ref
        .read(carsManagerStateProvider)
        .updateInsurancePayment(oldData: oldData, data: data);
  }

  void removeInsurance(InsuranceData data) {
    ref.read(carsManagerStateProvider).removeInsurancePayment(data);
  }

  void updateInspection({
    required InspectionData oldData,
    required InspectionData data,
  }) {
    ref
        .read(carsManagerStateProvider)
        .updateInspectionPayment(oldData: oldData, data: data);
  }

  void removeInspection(InspectionData data) {
    ref.read(carsManagerStateProvider).removeInspectionPayment(data);
  }

  void updateTax({required TaxData oldData, required TaxData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateTaxPayment(oldData: oldData, data: data);
  }

  void removeTax(TaxData data) {
    ref.read(carsManagerStateProvider).removeTaxPayment(data);
  }

  void updateRepair({required RepairData oldData, required RepairData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateRepairPayment(oldData: oldData, data: data);
  }

  void removeRepair(RepairData data) {
    ref.read(carsManagerStateProvider).removeRepairPayment(data);
  }

  void updateFine({required FineData oldData, required FineData data}) {
    ref
        .read(carsManagerStateProvider)
        .updateFinePayment(oldData: oldData, data: data);
  }

  void removeFine(FineData data) {
    ref.read(carsManagerStateProvider).removeFinePayment(data);
  }
}
