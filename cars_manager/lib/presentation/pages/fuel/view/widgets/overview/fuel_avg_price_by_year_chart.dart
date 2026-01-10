import 'dart:math' as math;

import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FuelAvgPriceByYearChart extends StatelessWidget {
  final Car car;

  const FuelAvgPriceByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final entries = car.fuel ?? const <FuelEntry>[];
    final data = _avgPriceByYear(entries);
    if (data.isEmpty) {
      return const SizedBox();
    }

    final fuelType = car.fuelType ?? entries.first.fuelType;
    final isElectric = fuelType == FuelType.electric;
    final unit = isElectric ? '€/kWh' : '€/L';

    return PaymentSectionCard(
      title:
          AppLocalizations.of(context)?.fuel_avgPriceByYear_title ??
          'Avg price per unit by year',
      nextInfoDue: null,
      verticalSpacing: 12,
      items: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: _SimpleYearBarChart(
            valuesByYear: data,
            locale: locale,
            unit: unit,
            barColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  /// Weighted average: totalCost / totalAmount
  Map<int, double> _avgPriceByYear(List<FuelEntry> entries) {
    final sums = <int, ({double cost, double amount})>{};

    for (final e in entries) {
      if (e.liters <= 0) continue;
      final year = e.date.year;
      final prev = sums[year];
      if (prev == null) {
        sums[year] = (cost: e.totalCost, amount: e.liters);
      } else {
        sums[year] = (
          cost: prev.cost + e.totalCost,
          amount: prev.amount + e.liters,
        );
      }
    }

    final out = <int, double>{};
    for (final entry in sums.entries) {
      if (entry.value.amount <= 0) continue;
      out[entry.key] = entry.value.cost / entry.value.amount;
    }

    final sortedKeys = out.keys.toList()..sort();
    return {for (final k in sortedKeys) k: out[k]!};
  }
}

class _SimpleYearBarChart extends StatelessWidget {
  final Map<int, double> valuesByYear;
  final Locale locale;
  final String unit;
  final Color barColor;

  const _SimpleYearBarChart({
    required this.valuesByYear,
    required this.locale,
    required this.unit,
    required this.barColor,
  });

  double _niceStep(double value) {
    if (value <= 0) return 1;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    final years = valuesByYear.keys.toList();
    final values = valuesByYear.values.toList();

    final maxValue = values.isEmpty ? 0.0 : values.reduce(math.max);
    final interval = _niceStep(maxValue / 4);
    final yMax = maxValue <= 0
        ? 1.0
        : ((maxValue / interval).ceil() * interval);

    String fmt(double v) => '${numberFormat.format(v)}$unit';

    return SizedBox(
      height: 280,
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
              tooltipBorder: BorderSide.none,
              tooltipBorderRadius: BorderRadius.circular(14),
              tooltipPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              tooltipMargin: 14,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final i = group.x.toInt();
                if (i < 0 || i >= years.length) return null;
                final year = years[i];
                final v = values[i];

                return BarTooltipItem(
                  '$year - ',
                  GoogleFonts.spaceGrotesk(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: fmt(v),
                      style: GoogleFonts.spaceGrotesk(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.9,
                        ),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        height: 1.2,
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
                  final i = value.toInt();
                  if (i < 0 || i >= years.length) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    space: 4,
                    child: Text(
                      years[i].toString(),
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
                interval: interval,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 4,
                    child: Text(
                      localizations.unit_currency(
                        numberFormat.format(value),
                        unit,
                        '',
                      ),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.75,
                        ),
                      ),
                    ),
                  );
                },
                reservedSize: 72,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (value) {
              final isDarkTheme = theme.brightness == Brightness.dark;
              final gridColor = isDarkTheme
                  ? theme.dividerColor.withValues(alpha: 0.3)
                  : theme.dividerColor.withValues(alpha: 0.6);
              return FlLine(color: gridColor, strokeWidth: 1);
            },
          ),
          barGroups: [
            for (var i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i],
                    color: barColor,
                    width: 18,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
