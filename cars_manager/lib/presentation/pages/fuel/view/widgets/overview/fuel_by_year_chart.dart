import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/fuel_stacked_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/common/widgets/chart_title.dart';
import 'package:cars_manager/presentation/common/extensions/fuel_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuelExpensesByYearChart extends StatelessWidget {
  final Car car;

  const FuelExpensesByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final data = FuelStackedBarChart.generateFromCar(car);

    if (data.isEmpty) {
      return const SizedBox();
    }

    final fuelType =
        car.fuelType ??
        (car.fuel?.isNotEmpty == true ? car.fuel!.first.fuelType : null);

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
      nextInfoDue: null,
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
