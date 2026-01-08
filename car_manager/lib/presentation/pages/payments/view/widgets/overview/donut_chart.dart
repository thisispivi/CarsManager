import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/main.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/donut_chart.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentsOverviewDonutChart extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    return PaymentSectionCard(
      title:
          AppLocalizations.of(context)?.payments_expenseDistribution_title ??
          'Expense Distribution',
      nextInfoDue: null,
      verticalSpacing: 12,
      items: [
        DonutChart(
          totalPrefix: "${AppLocalizations.of(context)?.total ?? 'Total'}: ",
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
                value: car.calculateTotalPaidInsurances().toDouble(),
                title: AppLocalizations.of(context)!.unit_currency(
                  numberFormat.format(car.calculateTotalPaidInsurances()),
                  "€",
                  "",
                ),
                textColor: Colors.white,
                label:
                    AppLocalizations.of(
                      context,
                    )?.payments_insuranceData_shortTitle ??
                    'Insurance',
              ),
            if (hasInspectionData)
              PieChartSection(
                color: Colors.green,
                value: car.calculateTotalPaidInspections().toDouble(),
                title: AppLocalizations.of(context)!.unit_currency(
                  numberFormat.format(car.calculateTotalPaidInspections()),
                  "€",
                  "",
                ),
                textColor: Colors.white,
                label:
                    AppLocalizations.of(
                      context,
                    )?.payments_inspectionData_shortTitle ??
                    'Inspection',
              ),
            if (hasTaxData)
              PieChartSection(
                color: Colors.red,
                value: car.calculateTotalPaidTaxes().toDouble(),
                title: AppLocalizations.of(context)!.unit_currency(
                  numberFormat.format(car.calculateTotalPaidTaxes()),
                  "€",
                  "",
                ),
                textColor: Colors.white,
                label:
                    AppLocalizations.of(context)?.payments_taxData_shortTitle ??
                    'Tax',
              ),
            if (hasRepairData)
              PieChartSection(
                color: Colors.purple,
                value: car.calculateTotalPaidRepairs().toDouble(),
                title: AppLocalizations.of(context)!.unit_currency(
                  numberFormat.format(car.calculateTotalPaidRepairs()),
                  "€",
                  "",
                ),
                textColor: Colors.white,
                label:
                    AppLocalizations.of(
                      context,
                    )?.payments_repairsData_shortTitle ??
                    'Repair',
              ),
            if (hasFineData)
              PieChartSection(
                color: Colors.orange,
                value: car.calculateTotalPaidFines().toDouble(),
                title: AppLocalizations.of(context)!.unit_currency(
                  numberFormat.format(car.calculateTotalPaidFines()),
                  "€",
                  "",
                ),
                textColor: Colors.white,
                label:
                    AppLocalizations.of(
                      context,
                    )?.payments_fineData_shortTitle ??
                    'Fine',
              ),
          ],
        ),
      ],
    );
  }
}
