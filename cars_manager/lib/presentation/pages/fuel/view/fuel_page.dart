import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/fuel_entries_section.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_amount_by_year_chart.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_avg_price_by_year_chart.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/overview/fuel_by_year_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FuelConsumptionPage extends ConsumerWidget {
  const FuelConsumptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Car? car = ref.watch(activeCarProvider);
    return SafeArea(
      child: Builder(
        builder: (context) {
          if (car == null) {
            final l10n = AppLocalizations.of(context)!;
            return Center(
              child: Text(
                l10n.fuel_selectCarHint,
                style: GoogleFonts.spaceGrotesk().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }
          final hasFuelData = car.fuel.isNotEmpty;

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
