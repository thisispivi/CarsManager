import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../main.dart';
import 'repair_item.dart';

class RepairSection extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const RepairSection({super.key, required this.car});

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
          title: localizations.payments_repairsData_title,
          icon: Icon(
            Icons.handyman_outlined,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        ...car.repairDatas!
            .map((repair) => RepairItem(repair: repair, locale: locale))
            .toList(),
      ],
    );
  }
}
