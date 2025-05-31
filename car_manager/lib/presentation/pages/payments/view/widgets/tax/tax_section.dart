import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:car_manager/presentation/common/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import 'next_tax_info.dart';
import 'tax_item.dart';

class TaxSection extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const TaxSection({super.key, required this.car});

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
          title: localizations.payments_taxesData_title,
          icon: Icon(
            Icons.paid_outlined,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        NextTaxInfo(car: car),
        const SizedBox(height: 16),
        ...car.taxDatas!
            .map((tax) => TaxItem(tax: tax, locale: locale))
            .toList(),
      ],
    );
  }
}
