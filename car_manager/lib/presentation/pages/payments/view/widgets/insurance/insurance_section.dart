import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../main.dart';
import 'next_insurance_info.dart';
import 'insurance_item.dart';

class InsuranceSection extends StatelessWidget {
  final Car car;

  const InsuranceSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return PaymentSectionCard(
      title: localizations.payments_insuranceData_title,
      icon: Icon(
        Icons.description_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      nextInfoDue: NextInsuranceInfo(car: car),
      items: car.insuranceDatas!
          .asMap()
          .entries
          .map(
            (entry) => InsuranceItem(
              insurance: entry.value,
              locale: locale,
              isLast: entry.key == car.insuranceDatas!.length - 1,
            ),
          )
          .toList(),
    );
  }
}
