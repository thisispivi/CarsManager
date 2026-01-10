import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/fuel_stacked_bar_chart.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
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

    return PaymentSectionCard(
      title:
          AppLocalizations.of(context)?.fuel_expensesByYear_title ??
          'Fuel Expenses by Year',
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
