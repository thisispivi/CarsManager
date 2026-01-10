import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/fuel_entries_section.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_amount_by_year_chart.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_avg_price_by_year_chart.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_by_year_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuelConsumptionPage extends StatelessWidget {
  const FuelConsumptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarsManagerState>(
        builder: (context, carState, child) {
          final Car car = carState.car;
          final hasFuelData = car.fuel?.isNotEmpty ?? false;

          final sections = <Widget>[
            if (hasFuelData) FuelAvgPriceByYearChart(car: car),
            if (hasFuelData) FuelExpensesByYearChart(car: car),
            if (hasFuelData) FuelAmountByYearChart(car: car),
            FuelEntriesSection(car: car),
          ];

          return ListView(
            padding: const EdgeInsets.only(bottom: 16.0),
            children: sections,
          );
        },
      ),
    );
  }
}
