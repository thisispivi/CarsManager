import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/fuel_stacked_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/common/widgets/chart_title.dart';
import 'package:cars_manager/presentation/common/extensions/fuel_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelExpensesByYearChart extends ConsumerWidget {
  final Car car;

  const FuelExpensesByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final data = FuelStackedBarChart.generateFromCar(car);

    if (data.isEmpty) {
      return const SizedBox();
    }

    final fuelType =
        car.fuelType ?? (car.fuel.isNotEmpty ? car.fuel.first.fuelType : null);

    return PaymentSectionCard(
      customTitle: ChartTitle(
        title:
            AppLocalizations.of(context)?.fuel_expensesByYear_title ??
            'Fuel Expenses by Year',
        unit: '€',
        subtitle: fuelType != null
            ? '${car.name} (${fuelType.localized(AppLocalizations.of(context)!)})'
            : car.name,
      ),
      verticalSpacing: 12,
      items: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FuelStackedBarChart(expensesByYearList: data, locale: locale),
        ),
      ],
    );
  }
}
