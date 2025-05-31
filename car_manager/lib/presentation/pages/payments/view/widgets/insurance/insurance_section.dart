import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../main.dart';
import 'next_insurance_info.dart';
import 'insurance_item.dart';

class InsuranceSection extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const InsuranceSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          horizontalPadding: horizontalPadding,
          title: localizations.payments_insuranceData_title,
          icon: ImageIcon(AssetImage("assets/icons/insurance.png"), size: 24),
        ),
        const SizedBox(height: 16),
        NextInsuranceInfo(car: car),
        const SizedBox(height: 16),
        ...car.insuranceDatas!
            .map(
              (insurance) =>
                  InsuranceItem(insurance: insurance, locale: locale),
            )
            .toList(),
      ],
    );
  }
}
