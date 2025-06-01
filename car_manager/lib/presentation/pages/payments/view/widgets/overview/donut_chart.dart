import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentsOverviewDonutChart extends StatelessWidget {
  const PaymentsOverviewDonutChart({
    super.key,
    required this.hasInsuranceData,
    required this.car,
    required this.numberFormat,
    required this.hasInspectionData,
    required this.hasTaxData,
  });

  final bool hasInsuranceData;
  final Car car;
  final NumberFormat numberFormat;
  final bool hasInspectionData;
  final bool hasTaxData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.only(top: 16.0, bottom: 0),
      margin: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              AppLocalizations.of(
                    context,
                  )?.payments_expenseDistribution_title ??
                  'Expense Distribution',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DonutChart(
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
                      AppLocalizations.of(
                        context,
                      )?.payments_taxData_shortTitle ??
                      'Tax',
                ),
            ],
          ),
        ],
      ),
    );
  }
}
