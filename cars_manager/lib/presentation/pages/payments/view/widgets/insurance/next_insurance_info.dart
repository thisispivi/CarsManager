import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/next_info_due.dart';
import 'package:flutter/material.dart';

class NextInsuranceInfo extends StatelessWidget {
  final Car car;

  const NextInsuranceInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextInsuranceDate = car.nextInsuranceExpirationDate;
    final daysUntilNext = car.daysUntilNextInsuranceExpiration;

    if (nextInsuranceDate == null || daysUntilNext == null) {
      return const SizedBox.shrink();
    }

    return NextInfoDue(
      title: localizations.payments_insuranceData_nextDue,
      nextDueDate: nextInsuranceDate,
      daysRemaining: daysUntilNext,
      daysLabel: localizations.days,
      calendarTitle:
          '${localizations.payments_insuranceData_shortTitle} - ${car.name}',
    );
  }
}
