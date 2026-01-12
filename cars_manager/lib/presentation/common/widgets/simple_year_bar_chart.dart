import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SimpleYearBarChart extends StatelessWidget {
  final Map<int, double> valuesByYear;
  final Locale locale;
  final Color barColor;
  final String Function(double value, NumberFormat numberFormat) formatValue;

  final double height;
  final double horizontalPadding;

  const SimpleYearBarChart({
    super.key,
    required this.valuesByYear,
    required this.locale,
    required this.barColor,
    required this.formatValue,
    this.height = 280,
    this.horizontalPadding = 12,
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
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    final years = valuesByYear.keys.toList();
    final values = valuesByYear.values.toList();

    final maxValue = values.isEmpty ? 0.0 : values.reduce(math.max);
    final interval = _niceStep(maxValue / 4);
    final yMax = maxValue <= 0
        ? 1.0
        : ((maxValue / interval).ceil() * interval);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: height,
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
                        text: formatValue(v, numberFormat),
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
                        formatValue(value, numberFormat),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ),
                    );
                  },
                  reservedSize: 84,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: interval,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                  strokeWidth: 1,
                );
              },
            ),
            barGroups: List.generate(years.length, (i) {
              final v = values[i];
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: v,
                    color: barColor,
                    width: 18,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
