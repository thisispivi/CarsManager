import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/inspection_data.dart';
import 'package:car_manager/models/insurance_data.dart';
import 'package:car_manager/models/tax_data.dart';
import 'package:car_manager/models/fine_data.dart';
import 'package:car_manager/models/car.dart';

class ExpensesByYear {
  final int year;
  final double inspections;
  final double insurances;
  final double taxes;
  final double fines;

  ExpensesByYear({
    required this.year,
    required this.inspections,
    required this.insurances,
    required this.taxes,
    required this.fines,
  });

  double get total => inspections + insurances + taxes + fines;
}

class StackedBarChart extends StatelessWidget {
  final List<ExpensesByYear> expensesByYearList;
  final Locale locale;

  const StackedBarChart({
    super.key,
    required this.expensesByYearList,
    this.locale = const Locale('en'),
  });

  static List<ExpensesByYear> generateFromCar(Car car) {
    // Map to store aggregated data by year
    final Map<int, ExpensesByYear> expensesByYearMap = {};

    // Process inspection data
    if (car.inspectionDatas != null) {
      for (InspectionData inspection in car.inspectionDatas!) {
        final year = inspection.date.year;
        if (!expensesByYearMap.containsKey(year)) {
          expensesByYearMap[year] = ExpensesByYear(
            year: year,
            inspections: 0,
            insurances: 0,
            taxes: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections:
              expensesByYearMap[year]!.inspections + (inspection.amount ?? 0),
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes,
          fines: expensesByYearMap[year]!.fines,
        );
      }
    }

    // Process insurance data
    if (car.insuranceDatas != null) {
      for (InsuranceData insurance in car.insuranceDatas!) {
        final year = insurance.startDate.year;
        if (!expensesByYearMap.containsKey(year)) {
          expensesByYearMap[year] = ExpensesByYear(
            year: year,
            inspections: 0,
            insurances: 0,
            taxes: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances:
              expensesByYearMap[year]!.insurances + insurance.premiumAmount,
          taxes: expensesByYearMap[year]!.taxes,
          fines: expensesByYearMap[year]!.fines,
        );
      }
    }

    // Process tax data
    if (car.taxDatas != null) {
      for (TaxData tax in car.taxDatas!) {
        final year = tax.date.year;
        if (!expensesByYearMap.containsKey(year)) {
          expensesByYearMap[year] = ExpensesByYear(
            year: year,
            inspections: 0,
            insurances: 0,
            taxes: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes + tax.amount,
          fines: expensesByYearMap[year]!.fines,
        );
      }
    }

    // Process fine data
    if (car.fineDatas != null) {
      for (FineData fine in car.fineDatas!) {
        final year = fine.date.year;
        if (!expensesByYearMap.containsKey(year)) {
          expensesByYearMap[year] = ExpensesByYear(
            year: year,
            inspections: 0,
            insurances: 0,
            taxes: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes,
          fines: expensesByYearMap[year]!.fines + fine.amount,
        );
      }
    }

    // Convert map to list and sort by year
    return expensesByYearMap.values.toList()
      ..sort((a, b) => a.year.compareTo(b.year));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(
                context,
                Colors.green,
                localizations.payments_inspectionData_shortTitle,
              ),
              _buildLegendItem(
                context,
                Colors.blue,
                localizations.payments_insuranceData_shortTitle,
              ),
              _buildLegendItem(
                context,
                Colors.red,
                localizations.payments_taxData_shortTitle,
              ),
              _buildLegendItem(
                context,
                Colors.orange,
                localizations.payments_fineData_shortTitle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final expense = expensesByYearList[groupIndex];
                    String categoryName;
                    double value;

                    switch (rodIndex) {
                      case 0:
                        categoryName =
                            localizations.payments_inspectionData_shortTitle;
                        value = expense.inspections;
                        break;
                      case 1:
                        categoryName =
                            localizations.payments_insuranceData_shortTitle;
                        value = expense.insurances;
                        break;
                      case 2:
                        categoryName =
                            localizations.payments_taxData_shortTitle;
                        value = expense.taxes;
                        break;
                      case 3:
                        categoryName =
                            localizations.payments_fineData_shortTitle;
                        value = expense.fines;
                        break;
                      default:
                        return null;
                    }

                    return BarTooltipItem(
                      '$categoryName\n',
                      GoogleFonts.spaceGrotesk(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: localizations.unit_currency(
                            numberFormat.format(value),
                            "€",
                            " ",
                          ),
                          style: GoogleFonts.spaceGrotesk(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          expensesByYearList[value.toInt()].year.toString(),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          '${numberFormat.format(value)}€',
                          style: GoogleFonts.spaceGrotesk(fontSize: 10),
                        ),
                      );
                    },
                    reservedSize: 60,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                horizontalInterval: _calculateInterval(),
                getDrawingHorizontalLine: (value) => FlLine(
                  color: theme.dividerColor.withOpacity(0.3),
                  strokeWidth: 1,
                ),
              ),
              barGroups: _buildBarGroups(),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateInterval() {
    // Find the maximum total for all years to set appropriate scale
    final maxTotal = expensesByYearList.fold<double>(
      0,
      (prev, element) => element.total > prev ? element.total : prev,
    );

    if (maxTotal <= 500) return 100;
    if (maxTotal <= 1000) return 200;
    if (maxTotal <= 5000) return 1000;
    if (maxTotal <= 10000) return 2000;
    return 5000;
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12)),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(expensesByYearList.length, (index) {
      final expense = expensesByYearList[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: expense.inspections,
            color: Colors.green,
            width: 15,
          ),
          BarChartRodData(
            toY: expense.insurances,
            color: Colors.blue,
            width: 15,
          ),
          BarChartRodData(toY: expense.taxes, color: Colors.red, width: 15),
          BarChartRodData(toY: expense.fines, color: Colors.orange, width: 15),
        ],
        // Set spacing between groups
        barsSpace: 4,
      );
    });
  }
}
