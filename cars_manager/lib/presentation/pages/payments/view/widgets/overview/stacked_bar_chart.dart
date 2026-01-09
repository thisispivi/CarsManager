import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/stacked_bar_chart.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';

class ExpensesByYearChart extends StatelessWidget {
  final Car car;

  const ExpensesByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final expensesByYearList = StackedBarChart.generateFromCar(car);

    if (expensesByYearList.isEmpty) {
      return const SizedBox();
    }

    return PaymentSectionCard(
      title:
          AppLocalizations.of(context)?.payments_expensesByYear_title ??
          'Expenses by Year',
      nextInfoDue: null,
      items: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: StackedBarChart(
            expensesByYearList: expensesByYearList,
            locale: locale,
          ),
        ),
      ],
      verticalSpacing: 12,
    );
  }
}
