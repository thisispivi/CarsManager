import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/stacked_bar_chart.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';

class ExpensesByYearChart extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const ExpensesByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    final expensesByYearList = StackedBarChart.generateFromCar(car);

    if (expensesByYearList.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(horizontalPadding),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.payments_expensesByYear_title ??
                    'Expenses by Year',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              StackedBarChart(
                expensesByYearList: expensesByYearList,
                locale: locale,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
