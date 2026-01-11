import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:cars_manager/presentation/common/widgets/next_info_due.dart';

class NextTaxInfo extends StatelessWidget {
  final Car car;

  const NextTaxInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextTaxDate = car.getNextTaxDueDate();
    final daysUntilNext = car.getDaysUntilNextTaxDue();

    if (nextTaxDate == null || daysUntilNext == null) {
      return const SizedBox.shrink();
    }

    return NextInfoDue(
      title: localizations.payments_taxesData_nextDue,
      nextDueDate: nextTaxDate as DateTime,
      daysRemaining: daysUntilNext as int,
      daysLabel: localizations.days,
    );
  }
}
