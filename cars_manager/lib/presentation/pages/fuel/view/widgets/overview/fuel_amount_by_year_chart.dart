import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/common/widgets/simple_year_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/common/widgets/chart_title.dart';
import 'package:cars_manager/presentation/common/extensions/fuel_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelAmountByYearChart extends ConsumerWidget {
  final Car car;

  const FuelAmountByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final entries = car.fuel;
    final data = _amountByYear(entries);
    if (data.isEmpty) {
      return const SizedBox();
    }

    final fuelType = car.fuelType ?? entries.first.fuelType;
    final isElectric = fuelType == FuelType.electric;
    final unit = isElectric ? 'kWh' : 'L';

    return PaymentSectionCard(
      customTitle: ChartTitle(
        title:
            AppLocalizations.of(context)?.fuel_amountByYear_title ??
            'Total amount by year',
        unit: unit,
        subtitle:
            '${car.name} (${fuelType.localized(AppLocalizations.of(context)!)})',
      ),
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
