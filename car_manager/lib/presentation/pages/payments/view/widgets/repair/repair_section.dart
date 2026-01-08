import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../main.dart';
import 'repair_item.dart';

class RepairSection extends StatelessWidget {
  final Car car;

  const RepairSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return PaymentSectionCard(
      title: localizations.payments_repairsData_title,
      icon: Icon(
        Icons.handyman_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      items: car.repairDatas!
          .asMap()
          .entries
          .map(
            (entry) => RepairItem(
              repair: entry.value,
              locale: locale,
              isLast: entry.key == car.repairDatas!.length - 1,
            ),
          )
          .toList(),
    );
  }
}
