import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/inspection_data.dart';
import 'package:car_manager/models/insurance_data.dart';
import 'package:car_manager/models/repair_data.dart';
import 'package:car_manager/models/tax_data.dart';
import 'package:car_manager/models/fine_data.dart';
import 'package:car_manager/models/car.dart';

enum ExpenseCategory { inspections, insurances, taxes, repairs, fines }

class ExpensesByYear {
  final int year;
  final double inspections;
  final double insurances;
  final double taxes;
  final double repairs;
  final double fines;

  ExpensesByYear({
    required this.year,
    required this.inspections,
    required this.insurances,
    required this.taxes,
    required this.repairs,
    required this.fines,
  });

  double get total => inspections + insurances + taxes + repairs + fines;
}

class StackedBarChart extends StatefulWidget {
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
            repairs: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections:
              expensesByYearMap[year]!.inspections + (inspection.amount ?? 0),
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes,
          repairs: expensesByYearMap[year]!.repairs,
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
            repairs: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances:
              expensesByYearMap[year]!.insurances + insurance.premiumAmount,
          taxes: expensesByYearMap[year]!.taxes,
          repairs: expensesByYearMap[year]!.repairs,
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
            repairs: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes + tax.amount,
          repairs: expensesByYearMap[year]!.repairs,
          fines: expensesByYearMap[year]!.fines,
        );
      }
    }

    // Process repair data
    if (car.repairDatas != null) {
      for (RepairData repair in car.repairDatas!) {
        final year = repair.date.year;
        if (!expensesByYearMap.containsKey(year)) {
          expensesByYearMap[year] = ExpensesByYear(
            year: year,
            inspections: 0,
            insurances: 0,
            taxes: 0,
            repairs: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes,
          repairs: expensesByYearMap[year]!.repairs + repair.amount,
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
            repairs: 0,
            fines: 0,
          );
        }
        expensesByYearMap[year] = ExpensesByYear(
          year: year,
          inspections: expensesByYearMap[year]!.inspections,
          insurances: expensesByYearMap[year]!.insurances,
          taxes: expensesByYearMap[year]!.taxes,
          repairs: expensesByYearMap[year]!.repairs,
          fines: expensesByYearMap[year]!.fines + fine.amount,
        );
      }
    }

    // Convert map to list and sort by year
    return expensesByYearMap.values.toList()
      ..sort((a, b) => a.year.compareTo(b.year));
  }

  @override
  State<StackedBarChart> createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {
  final Set<ExpenseCategory> _enabled = {
    ExpenseCategory.inspections,
    ExpenseCategory.insurances,
    ExpenseCategory.taxes,
    ExpenseCategory.repairs,
    ExpenseCategory.fines,
  };

  double _valueFor(ExpensesByYear e, ExpenseCategory c) {
    switch (c) {
      case ExpenseCategory.inspections:
        return e.inspections;
      case ExpenseCategory.insurances:
        return e.insurances;
      case ExpenseCategory.taxes:
        return e.taxes;
      case ExpenseCategory.repairs:
        return e.repairs;
      case ExpenseCategory.fines:
        return e.fines;
    }
  }

  double _totalFor(ExpensesByYear e) {
    double sum = 0;
    for (final c in _enabled) {
      sum += _valueFor(e, c);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(widget.locale.toString());

    // Hide years that have no data at all.
    final data = widget.expensesByYearList.where((e) => e.total > 0).toList();

    final yInterval = _calculateInterval(data);
    final yMax = _calculateMaxY(data, yInterval);

    String fmt(double v) =>
        localizations.unit_currency(numberFormat.format(v), "€", " ");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 2,
            children: [
              _buildLegendItem(
                context: context,
                category: ExpenseCategory.inspections,
                color: Colors.green,
                label: localizations.payments_inspectionData_shortTitle,
              ),
              _buildLegendItem(
                context: context,
                category: ExpenseCategory.insurances,
                color: Colors.blue,
                label: localizations.payments_insuranceData_shortTitle,
              ),
              _buildLegendItem(
                context: context,
                category: ExpenseCategory.taxes,
                color: Colors.red,
                label: localizations.payments_taxData_shortTitle,
              ),
              _buildLegendItem(
                context: context,
                category: ExpenseCategory.repairs,
                color: Colors.purple,
                label: localizations.payments_repairsData_shortTitle,
              ),
              _buildLegendItem(
                context: context,
                category: ExpenseCategory.fines,
                color: Colors.orange,
                label: localizations.payments_fineData_shortTitle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              minY: 0,
              maxY: yMax,
              alignment: BarChartAlignment.spaceAround,
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: theme.dividerColor.withValues(alpha: 0.75),
                    strokeWidth: 1.5,
                  ),
                ],
              ),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) =>
                      theme.colorScheme.surface.withValues(alpha: 0.95),
                  tooltipBorder: BorderSide(
                    color: theme.dividerColor.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  tooltipBorderRadius: BorderRadius.circular(14),
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  tooltipMargin: 14,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    if (groupIndex < 0 || groupIndex >= data.length) {
                      return null;
                    }

                    final e = data[groupIndex];

                    TextSpan line({
                      required String label,
                      required double value,
                      required Color color,
                    }) {
                      return TextSpan(
                        children: [
                          TextSpan(
                            text: '● ',
                            style: GoogleFonts.spaceGrotesk(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              height: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: '$label: ${fmt(value)}\n',
                            style: GoogleFonts.spaceGrotesk(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.9,
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.5,
                              height: 1.2,
                            ),
                          ),
                        ],
                      );
                    }

                    final children = <TextSpan>[];
                    if (_enabled.contains(ExpenseCategory.inspections)) {
                      children.add(
                        line(
                          label:
                              localizations.payments_inspectionData_shortTitle,
                          value: e.inspections,
                          color: Colors.green,
                        ),
                      );
                    }
                    if (_enabled.contains(ExpenseCategory.insurances)) {
                      children.add(
                        line(
                          label:
                              localizations.payments_insuranceData_shortTitle,
                          value: e.insurances,
                          color: Colors.blue,
                        ),
                      );
                    }
                    if (_enabled.contains(ExpenseCategory.taxes)) {
                      children.add(
                        line(
                          label: localizations.payments_taxData_shortTitle,
                          value: e.taxes,
                          color: Colors.red,
                        ),
                      );
                    }
                    if (_enabled.contains(ExpenseCategory.repairs)) {
                      children.add(
                        line(
                          label: localizations.payments_repairsData_shortTitle,
                          value: e.repairs,
                          color: Colors.purple,
                        ),
                      );
                    }
                    if (_enabled.contains(ExpenseCategory.fines)) {
                      children.add(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '● ',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.orange,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.5,
                                height: 1.2,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${localizations.payments_fineData_shortTitle}: ${fmt(e.fines)}',
                              style: GoogleFonts.spaceGrotesk(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.9,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return BarTooltipItem(
                      '${e.year}\n\n${fmt(_totalFor(e))}\n\n',
                      GoogleFonts.spaceGrotesk(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      children: children,
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
                      final i = value.toInt();
                      if (i < 0 || i >= data.length) {
                        return const SizedBox.shrink();
                      }
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          data[i].year.toString(),
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
                    interval: yInterval, // y tick spacing
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          '${numberFormat.format(value)}€',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.75,
                            ),
                          ),
                        ),
                      );
                    },
                    reservedSize: 64,
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
                drawVerticalLine: false,
                horizontalInterval: yInterval,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: theme.dividerColor.withValues(alpha: 0.3),
                  strokeWidth: 1,
                ),
              ),
              barGroups: _buildBarGroups(data),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateInterval(List<ExpensesByYear> data) {
    final maxTotal = data.fold<double>(
      0,
      (prev, e) => math.max(prev, _totalFor(e)),
    );
    if (maxTotal <= 0) return 1;

    // Aim for more ticks (and grid lines) than the old coarse thresholds.
    const targetTicks = 9; // ~8–10 visible ticks depending on rounding
    final raw = maxTotal / targetTicks;

    return _niceStep(raw);
  }

  double _calculateMaxY(List<ExpensesByYear> data, double interval) {
    final maxTotal = data.fold<double>(
      0,
      (prev, e) => math.max(prev, _totalFor(e)),
    );
    if (maxTotal <= 0) return interval;

    // Keep maxY aligned to the tick interval (and avoid fractional headroom like 2125).
    final rounded = (maxTotal / interval).ceil() * interval;

    // If interval is integer-ish, force an integer maxY to avoid odd top labels.
    final isIntegerInterval =
        interval >= 1 && (interval - interval.round()).abs() < 1e-9;
    if (isIntegerInterval) {
      return rounded.roundToDouble();
    }
    return rounded;
  }

  double _niceStep(double value) {
    // 1/2/5 * 10^n rounding
    final exp = (math.log(value) / math.ln10).floor();
    final base = math.pow(10, exp).toDouble();
    final f = value / base;

    final niceF = (f <= 1)
        ? 1.0
        : (f <= 2)
        ? 2.0
        : (f <= 5)
        ? 5.0
        : 10.0;

    return niceF * base;
  }

  Widget _buildLegendItem({
    required BuildContext context,
    required ExpenseCategory category,
    required Color color,
    required String label,
  }) {
    final enabled = _enabled.contains(category);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          if (enabled) {
            _enabled.remove(category);
          } else {
            _enabled.add(category);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: enabled ? color : color.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: enabled
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.55),
                decoration: enabled ? null : TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<ExpensesByYear> data) {
    return List.generate(data.length, (index) {
      final e = data[index];

      var start = 0.0;
      final stacks = <BarChartRodStackItem>[];

      void addIfEnabled(ExpenseCategory c, Color color) {
        if (!_enabled.contains(c)) return;
        final v = _valueFor(e, c);
        if (v <= 0) return;
        final end = start + v;
        stacks.add(BarChartRodStackItem(start, end, color));
        start = end;
      }

      addIfEnabled(ExpenseCategory.inspections, Colors.green);
      addIfEnabled(ExpenseCategory.insurances, Colors.blue);
      addIfEnabled(ExpenseCategory.taxes, Colors.red);
      addIfEnabled(ExpenseCategory.repairs, Colors.purple);
      addIfEnabled(ExpenseCategory.fines, Colors.orange);

      final total = start;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: total,
            width: 22,
            borderRadius: BorderRadius.circular(4),
            rodStackItems: stacks,
          ),
        ],
        barsSpace: 0,
      );
    });
  }
}
