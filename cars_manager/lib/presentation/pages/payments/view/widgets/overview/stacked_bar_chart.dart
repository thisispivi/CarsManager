import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/stacked_bar_chart.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesByYearChart extends ConsumerWidget {
  final Car car;

  const ExpensesByYearChart({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final expensesByYearList = StackedBarChart.generateFromCar(car);

    if (expensesByYearList.isEmpty) {
      return const SizedBox();
    }

    return PaymentSectionCard(
      title: l10n.payments_expensesByYear_title,
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
