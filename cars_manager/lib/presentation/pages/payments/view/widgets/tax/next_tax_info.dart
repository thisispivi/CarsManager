import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/next_info_due.dart';
import 'package:flutter/material.dart';

class NextTaxInfo extends StatelessWidget {
  final Car car;

  const NextTaxInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextTaxDate = car.nextTaxDueDate;
    final daysUntilNext = car.daysUntilNextTaxDue;

    if (nextTaxDate == null || daysUntilNext == null) {
      return const SizedBox.shrink();
    }

    return NextInfoDue(
      title: localizations.payments_taxesData_nextDue,
      nextDueDate: nextTaxDate,
      daysRemaining: daysUntilNext,
      daysLabel: localizations.days,
      calendarTitle:
          '${localizations.payments_taxData_shortTitle} - ${car.name}',
    );
  }
}
