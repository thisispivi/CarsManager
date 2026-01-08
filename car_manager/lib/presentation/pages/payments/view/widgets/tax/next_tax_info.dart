import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:flutter/material.dart';
import '../common/next_info_due.dart';

class NextTaxInfo extends StatelessWidget {
  final Car car;

  const NextTaxInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextTaxDate = car.getNextTaxDueDate();
    final daysUntilNext = car.getDaysUntilNextTaxDue();

    return NextInfoDue(
      title: localizations.payments_taxesData_nextDue,
      nextDueDate: nextTaxDate,
      daysRemaining: daysUntilNext,
      daysLabel: localizations.days,
    );
  }
}
