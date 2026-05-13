import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/fine/fine_charts.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/fine/fine_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/inspection/inspection_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/insurance/insurance_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/overview/donut_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/overview/stacked_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/repair/repair_section.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/tax/tax_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Car? car = ref.watch(activeCarProvider);
    return SafeArea(
      child: Builder(
        builder: (context) {
          if (car == null) {
            final l10n = AppLocalizations.of(context)!;
            return Center(
              child: Text(
                l10n.payments_selectCarHint,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }

          final bool hasInspectionData = car.inspectionDatas.isNotEmpty;
          final bool hasInsuranceData = car.insuranceDatas.isNotEmpty;
          final bool hasTaxData = car.taxDatas.isNotEmpty;
          final bool hasRepairData = car.repairDatas.isNotEmpty;
          final bool hasFineData = car.fineDatas.isNotEmpty;

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
            if (hasFineData) ...[
              FinesCountByYearChart(car: car),
              FinesAmountByYearChart(car: car),
              FinesByTypeChart(car: car),
            ],
            InsuranceSection(car: car),
            InspectionSection(car: car),
            TaxSection(car: car),
            RepairSection(car: car),
            FineSection(car: car),
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
