import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import 'next_inspection_info.dart';
import 'inspection_item.dart';

class InspectionSection extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          horizontalPadding: horizontalPadding,
          title: localizations.payments_inspectionsData_title,
          icon: SvgPicture.asset(
            "assets/icons/inspection.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 16),
        NextInspectionInfo(car: car),
        const SizedBox(height: 16),
        ...car.inspectionDatas!
            .map(
              (inspection) =>
                  InspectionItem(inspection: inspection, locale: locale),
            )
            .toList(),
      ],
    );
  }
}
