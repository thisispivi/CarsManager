import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/common/widgets/simple_year_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
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
        SimpleYearBarChart(
          valuesByYear: data,
          locale: locale,
          barColor: Theme.of(context).colorScheme.primary,
          formatValue: (value, numberFormat) =>
              '${numberFormat.format(value)}$unit',
        ),
      ],
    );
  }

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

    out.removeWhere((k, v) => v <= 0);
    final sortedKeys = out.keys.toList()..sort();
    return {for (final k in sortedKeys) k: out[k]!};
  }
}
