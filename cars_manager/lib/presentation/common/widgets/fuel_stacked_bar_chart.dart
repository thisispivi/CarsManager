import 'dart:math' as math;

import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FuelExpensesByYear {
  final int year;
  final Map<FuelType, double> byFuelType;

  FuelExpensesByYear({required this.year, required this.byFuelType});

  double get total => byFuelType.values.fold(0, (sum, v) => sum + v);
}

class FuelStackedBarChart extends StatefulWidget {
  final List<FuelExpensesByYear> expensesByYearList;
  final Locale locale;

  const FuelStackedBarChart({
    super.key,
    required this.expensesByYearList,
    this.locale = const Locale('en'),
  });

  static List<FuelExpensesByYear> generateFromCar(Car car) {
    final Map<int, Map<FuelType, double>> map = {};

    final entries = car.fuel;
    for (final FuelEntry entry in entries) {
      final year = entry.date.year;
      final type = entry.fuelType;

      map.putIfAbsent(year, () => {});
      map[year]![type] = (map[year]![type] ?? 0) + entry.totalCost;
    }

    final list =
        map.entries
            .map((e) => FuelExpensesByYear(year: e.key, byFuelType: e.value))
            .toList()
          ..sort((a, b) => a.year.compareTo(b.year));

    return list.where((e) => e.total > 0).toList();
  }

  @override
  State<FuelStackedBarChart> createState() => _FuelStackedBarChartState();
}

class _FuelStackedBarChartState extends State<FuelStackedBarChart> {
  late Set<FuelType> _allTypes;
  late Set<FuelType> _enabled;

  @override
  void initState() {
    super.initState();
    _recomputeTypes();
  }

  @override
  void didUpdateWidget(covariant FuelStackedBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expensesByYearList != widget.expensesByYearList) {
      _recomputeTypes(preserveEnabled: true);
    }
  }

  void _recomputeTypes({bool preserveEnabled = false}) {
    final nextAll = widget.expensesByYearList
        .expand((e) => e.byFuelType.keys)
        .toSet();

    if (!preserveEnabled) {
      _allTypes = nextAll;
      _enabled = {..._allTypes};
      return;
    }

    final prevEnabled = _enabled;
    _allTypes = nextAll;
    _enabled = {..._allTypes};
    _enabled.retainAll(prevEnabled);
    if (_enabled.isEmpty) {
      _enabled = {..._allTypes};
    }
  }

  Color _colorForFuelType(FuelType fuelType) {
    switch (fuelType) {
      case FuelType.diesel:
        return Colors.blue;
      case FuelType.petrol:
        return Colors.orange;
      case FuelType.lpg:
        return Colors.teal;
      case FuelType.hybrid:
        return Colors.green;
      case FuelType.electric:
        return Colors.purple;
    }
  }

  String _labelForFuelType(FuelType fuelType) {
    final localizations = AppLocalizations.of(context)!;
    switch (fuelType) {
      case FuelType.petrol:
        return localizations.fuelType_petrol;
      case FuelType.diesel:
        return localizations.fuelType_diesel;
      case FuelType.lpg:
        return localizations.fuelType_lpg;
      case FuelType.electric:
        return localizations.fuelType_electric;
      case FuelType.hybrid:
        return localizations.fuelType_hybrid;
    }
  }

  double _calculateInterval(List<FuelExpensesByYear> data) {
    final maxTotal = data.fold<double>(
      0,
      (prev, e) => math.max(prev, _totalFor(e)),
    );
    if (maxTotal <= 0) return 1;

    const targetTicks = 9;
    final raw = maxTotal / targetTicks;

    return _niceStep(raw);
  }

  double _totalFor(FuelExpensesByYear e) {
    double sum = 0;
    for (final t in _enabled) {
      sum += e.byFuelType[t] ?? 0;
    }
    return sum;
  }

  double _calculateMaxY(List<FuelExpensesByYear> data, double interval) {
    final maxTotal = data.fold<double>(
      0,
      (prev, e) => math.max(prev, _totalFor(e)),
    );
    if (maxTotal <= 0) return interval;

    final rounded = (maxTotal / interval).ceil() * interval;

    final isIntegerInterval =
        interval >= 1 && (interval - interval.round()).abs() < 1e-9;
    if (isIntegerInterval) {
      return rounded.roundToDouble();
    }
    return rounded;
  }

  double _niceStep(double value) {
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
    final numberFormat = NumberFormat.decimalPattern(widget.locale.toString());

    final data = widget.expensesByYearList;
    if (data.isEmpty) {
      return const SizedBox();
    }

    final yInterval = _calculateInterval(data);
    final yMax = _calculateMaxY(data, yInterval);

    String fmt(double v) =>
        localizations.unit_currency(numberFormat.format(v), '€', ' ');

    final sortedTypes = _allTypes.toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              for (final t in sortedTypes)
                _buildLegendItem(
                  context: context,
                  fuelType: t,
                  color: _colorForFuelType(t),
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
                  tooltipBorder: BorderSide.none,
                  tooltipBorderRadius: BorderRadius.circular(14),
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  tooltipMargin: 14,
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

                    final sortedEnabled = _enabled.toList()
                      ..sort((a, b) => a.name.compareTo(b.name));
                    for (final t in sortedEnabled) {
                      final v = e.byFuelType[t] ?? 0;
                      if (v <= 0) continue;
                      children.add(
                        line(
                          label: _labelForFuelType(t),
                          value: v,
                          color: _colorForFuelType(t),
                        ),
                      );
                    }

                    final totalSpan = TextSpan(
                      text: '  ${fmt(_totalFor(e))}',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.limeAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    );

                    return BarTooltipItem(
                      '${e.year} - ',
                      GoogleFonts.spaceGrotesk(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      children: [
                        totalSpan,
                        const TextSpan(text: '\n\n'),
                        ...children,
                      ],
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
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
                    interval: yInterval,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          '${numberFormat.format(value)}€',
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
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: yInterval,
                getDrawingHorizontalLine: (value) {
                  final isDarkTheme = theme.brightness == Brightness.dark;
                  final gridColor = isDarkTheme
                      ? theme.dividerColor.withValues(alpha: 0.3)
                      : theme.dividerColor.withValues(alpha: 0.6);
                  return FlLine(color: gridColor, strokeWidth: 1);
                },
              ),
              barGroups: [
                for (int i = 0; i < data.length; i++) _barGroup(i, data[i]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _barGroup(int x, FuelExpensesByYear e) {
    double running = 0;
    final items = <BarChartRodStackItem>[];

    final sortedEnabled = _enabled.toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    for (final t in sortedEnabled) {
      final v = e.byFuelType[t] ?? 0;
      if (v <= 0) continue;
      final from = running;
      running += v;
      items.add(BarChartRodStackItem(from, running, _colorForFuelType(t)));
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: running,
          rodStackItems: items,
          borderRadius: BorderRadius.circular(4),
          width: 28,
        ),
      ],
      barsSpace: 0,
    );
  }

  Widget _buildLegendItem({
    required BuildContext context,
    required FuelType fuelType,
    required Color color,
  }) {
    final enabled = _enabled.contains(fuelType);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        setState(() {
          if (enabled) {
            _enabled.remove(fuelType);
          } else {
            _enabled.add(fuelType);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: enabled
              ? color.withValues(alpha: 0.18)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: enabled ? color : Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              _labelForFuelType(fuelType),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
