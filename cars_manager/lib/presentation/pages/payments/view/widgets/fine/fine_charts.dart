import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/presentation/common/extensions/fine_data_extensions.dart';
import 'package:cars_manager/presentation/common/widgets/donut_chart.dart';
import 'package:cars_manager/presentation/common/widgets/simple_year_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/common/widgets/chart_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FinesCountByYearChart extends StatelessWidget {
  final Car car;

  const FinesCountByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final fines = car.fineDatas ?? const <FineData>[];
    final data = _countByYear(fines);
    if (data.isEmpty) return const SizedBox();

    return PaymentSectionCard(
      customTitle: ChartTitle(
        title: l10n.payments_fines_chart_countByYear_title,
        subtitle: car.name,
      ),
      nextInfoDue: null,
      verticalSpacing: 12,
      items: [
        SimpleYearBarChart(
          valuesByYear: data,
          locale: locale,
          barColor: Theme.of(context).colorScheme.tertiary,
          formatValue: (value, numberFormat) =>
              numberFormat.format(value.round()),
        ),
      ],
    );
  }

  Map<int, double> _countByYear(List<FineData> fines) {
    final counts = <int, double>{};
    for (final fine in fines) {
      final year = fine.date.year;
      counts[year] = (counts[year] ?? 0) + 1;
    }

    counts.removeWhere((k, v) => v <= 0);
    final sortedKeys = counts.keys.toList()..sort();
    return {for (final k in sortedKeys) k: counts[k]!};
  }
}

class FinesAmountByYearChart extends StatelessWidget {
  final Car car;

  const FinesAmountByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final fines = car.fineDatas ?? const <FineData>[];
    final data = _amountByYear(fines);
    if (data.isEmpty) return const SizedBox();

    return PaymentSectionCard(
      customTitle: ChartTitle(
        title: l10n.payments_fines_chart_amountByYear_title,
        unit: '€',
        subtitle: car.name,
      ),
      nextInfoDue: null,
      verticalSpacing: 12,
      items: [
        SimpleYearBarChart(
          valuesByYear: data,
          locale: locale,
          barColor: Theme.of(context).colorScheme.primary,
          formatValue: (value, numberFormat) =>
              '${numberFormat.format(value)} €',
        ),
      ],
    );
  }

  Map<int, double> _amountByYear(List<FineData> fines) {
    final sums = <int, double>{};
    for (final fine in fines) {
      if (fine.amount <= 0) continue;
      final year = fine.date.year;
      sums[year] = (sums[year] ?? 0) + fine.amount;
    }

    sums.removeWhere((k, v) => v <= 0);
    final sortedKeys = sums.keys.toList()..sort();
    return {for (final k in sortedKeys) k: sums[k]!};
  }
}

class FinesByTypeChart extends StatelessWidget {
  final Car car;

  const FinesByTypeChart({super.key, required this.car});

  Color _colorForType(FineType type) {
    return switch (type) {
      FineType.speeding => Colors.red,
      FineType.parking => Colors.blue,
      FineType.redLight => Colors.orange,
      FineType.other => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');
    final numberFormat = NumberFormat.decimalPattern(locale.toString());

    final fines = car.fineDatas ?? const <FineData>[];
    if (fines.isEmpty) return const SizedBox();

    final sums = <FineType, double>{};
    for (final fine in fines) {
      if (fine.amount <= 0) continue;
      sums[fine.type] = (sums[fine.type] ?? 0) + fine.amount;
    }
    sums.removeWhere((k, v) => v <= 0);
    if (sums.isEmpty) return const SizedBox();

    return PaymentSectionCard(
      customTitle: ChartTitle(
        title: l10n.payments_fines_chart_byType_title,
        unit: '€',
        subtitle: car.name,
      ),
      nextInfoDue: null,
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
            for (final entry in sums.entries)
              PieChartSection(
                color: _colorForType(entry.key),
                value: entry.value,
                title: '${numberFormat.format(entry.value)} €',
                textColor: Colors.white,
                label: entry.key.localized(l10n),
              ),
          ],
        ),
      ],
    );
  }
}
