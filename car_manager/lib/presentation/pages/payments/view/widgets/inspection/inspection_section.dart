import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import 'next_inspection_info.dart';
import 'inspection_item.dart';

class InspectionSection extends StatelessWidget {
  final Car car;

  const InspectionSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return PaymentSectionCard(
      title: localizations.payments_inspectionsData_title,
      icon: SvgPicture.asset(
        "assets/icons/inspection.svg",
        width: 26,
        height: 26,
        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
      ),
      nextInfoDue: NextInspectionInfo(car: car),
      items: car.inspectionDatas!
          .map(
            (inspection) =>
                InspectionItem(inspection: inspection, locale: locale),
          )
          .toList(),
    );
  }
}
