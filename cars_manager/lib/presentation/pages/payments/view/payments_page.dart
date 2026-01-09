import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/fine/fine_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/inspection/inspection_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/insurance/insurance_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/overview/donut_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/overview/stacked_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/repair/repair_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/tax/tax_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarsManagerState>(
        builder: (context, carState, child) {
          final Car car = carState.car;

          final bool hasInspectionData =
              car.inspectionDatas != null && car.inspectionDatas!.isNotEmpty;

          final bool hasInsuranceData =
              car.insuranceDatas != null && car.insuranceDatas!.isNotEmpty;

          final bool hasTaxData =
              car.taxDatas != null && car.taxDatas!.isNotEmpty;

          final bool hasRepairData =
              car.repairDatas != null && car.repairDatas!.isNotEmpty;

          final bool hasFineData =
              car.fineDatas != null && car.fineDatas!.isNotEmpty;

          final List<Widget> sections = [
            PaymentsOverviewDonutChart(
              hasInsuranceData: hasInsuranceData,
              car: car,
              hasInspectionData: hasInspectionData,
              hasTaxData: hasTaxData,
              hasRepairData: hasRepairData,
              hasFineData: hasFineData,
            ),
            ExpensesByYearChart(car: car),
            if (hasInsuranceData) InsuranceSection(car: car),
            if (hasInspectionData) InspectionSection(car: car),
            if (hasTaxData) TaxSection(car: car),
            if (hasRepairData) RepairSection(car: car),
            if (hasFineData) FineSection(car: car),
          ];

          return ListView(
            padding: const EdgeInsets.only(bottom: 16.0),
            children: sections,
          );
        },
      ),
    );
  }
}
