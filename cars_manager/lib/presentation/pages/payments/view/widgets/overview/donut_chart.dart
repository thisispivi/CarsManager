import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/donut_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentsOverviewDonutChart extends ConsumerWidget {
  const PaymentsOverviewDonutChart({
    super.key,
    required this.hasInsuranceData,
    required this.car,
    required this.hasInspectionData,
    required this.hasTaxData,
    required this.hasRepairData,
    required this.hasFineData,
  });

  final bool hasInsuranceData;
  final Car car;
  final bool hasInspectionData;
  final bool hasTaxData;
  final bool hasRepairData;
  final bool hasFineData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    final hasAny =
        hasInsuranceData ||
        hasInspectionData ||
        hasTaxData ||
        hasRepairData ||
        hasFineData;

    if (!hasAny) {
      return const SizedBox();
    }

    return PaymentSectionCard(
      title: l10n.payments_expenseDistribution_title,
      verticalSpacing: 12,
      items: [
        DonutChart(
          totalPrefix: '${l10n.total}: ',
          totalSuffix: '€',
          totalTextStyle: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          locale: locale,
          sections: [
            if (hasInsuranceData)
              PieChartSection(
                color: Colors.blue,
                value: car.totalPaidInsurances.toDouble(),
                title: l10n.unit_currency(
                  numberFormat.format(car.totalPaidInsurances),
                  '€',
                  '',
                ),
                textColor: Colors.white,
                label: l10n.payments_insuranceData_shortTitle,
              ),
            if (hasInspectionData)
              PieChartSection(
                color: Colors.green,
                value: car.totalPaidInspections.toDouble(),
                title: l10n.unit_currency(
                  numberFormat.format(car.totalPaidInspections),
                  '€',
                  '',
                ),
                textColor: Colors.white,
                label: l10n.payments_inspectionData_shortTitle,
              ),
            if (hasTaxData)
              PieChartSection(
                color: Colors.red,
                value: car.totalPaidTaxes.toDouble(),
                title: l10n.unit_currency(
                  numberFormat.format(car.totalPaidTaxes),
                  '€',
                  '',
                ),
                textColor: Colors.white,
                label: l10n.payments_taxData_shortTitle,
              ),
            if (hasRepairData)
              PieChartSection(
                color: Colors.purple,
                value: car.totalPaidRepairs.toDouble(),
                title: l10n.unit_currency(
                  numberFormat.format(car.totalPaidRepairs),
                  '€',
                  '',
                ),
                textColor: Colors.white,
                label: l10n.payments_repairsData_shortTitle,
              ),
            if (hasFineData)
              PieChartSection(
                color: Colors.orange,
                value: car.totalPaidFines.toDouble(),
                title: l10n.unit_currency(
                  numberFormat.format(car.totalPaidFines),
                  '€',
                  '',
                ),
                textColor: Colors.white,
                label: l10n.payments_fineData_shortTitle,
              ),
          ],
        ),
      ],
    );
  }
}
