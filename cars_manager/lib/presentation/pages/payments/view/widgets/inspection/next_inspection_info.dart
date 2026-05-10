import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/next_info_due.dart';
import 'package:flutter/material.dart';

class NextInspectionInfo extends StatelessWidget {
  final Car car;

  const NextInspectionInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nextInspectionDate = car.nextInspectionDate;
    final daysUntilNext = car.daysUntilNextInspection;

    if (nextInspectionDate == null || daysUntilNext == null) {
      return const SizedBox.shrink();
    }

    return NextInfoDue(
      title: localizations.payments_inspectionsData_nextDue,
      nextDueDate: nextInspectionDate,
      daysRemaining: daysUntilNext,
      daysLabel: localizations.days,
    );
  }
}
