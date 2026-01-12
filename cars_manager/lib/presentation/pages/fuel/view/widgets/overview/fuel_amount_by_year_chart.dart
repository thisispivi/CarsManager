import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/common/widgets/simple_year_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuelAmountByYearChart extends StatelessWidget {
  final Car car;

  const FuelAmountByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final entries = car.fuel ?? const <FuelEntry>[];
    final data = _amountByYear(entries);
    if (data.isEmpty) {
      return const SizedBox();
    }

    final fuelType = car.fuelType ?? entries.first.fuelType;
    final isElectric = fuelType == FuelType.electric;
    final unit = isElectric ? 'kWh' : 'L';

    return PaymentSectionCard(
      title:
          AppLocalizations.of(context)?.fuel_amountByYear_title ??
          'Total amount by year',
      nextInfoDue: null,
      verticalSpacing: 12,
      items: [
        SimpleYearBarChart(
          valuesByYear: data,
          locale: locale,
          barColor: Theme.of(context).colorScheme.tertiary,
          formatValue: (value, numberFormat) =>
              '${numberFormat.format(value)} $unit',
        ),
      ],
    );
  }

  Map<int, double> _amountByYear(List<FuelEntry> entries) {
    final sums = <int, double>{};
    for (final e in entries) {
      if (e.liters <= 0) continue;
      final year = e.date.year;
      sums[year] = (sums[year] ?? 0) + e.liters;
    }
    sums.removeWhere((k, v) => v <= 0);

    final sortedKeys = sums.keys.toList()..sort();
    return {for (final k in sortedKeys) k: sums[k]!};
  }
}
