import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/next_info_due.dart';
import 'package:flutter/material.dart';

class NextInsuranceInfo extends StatelessWidget {
  final Car car;

  const NextInsuranceInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextInsuranceDate = car.getNextInsuranceExpirationDate();
    final daysUntilNext = car.getDaysUntilNextInsuranceExpiration();

    if (nextInsuranceDate == null || daysUntilNext == null) {
      return const SizedBox.shrink();
    }

    return NextInfoDue(
      title: localizations.payments_insuranceData_nextDue,
      nextDueDate: nextInsuranceDate as DateTime,
      daysRemaining: daysUntilNext as int,
      daysLabel: localizations.days,
    );
  }
}
