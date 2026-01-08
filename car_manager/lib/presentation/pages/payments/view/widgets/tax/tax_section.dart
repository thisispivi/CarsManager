import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import '../common/payment_section_card.dart';
import 'next_tax_info.dart';
import 'tax_item.dart';

class TaxSection extends StatelessWidget {
  final Car car;

  const TaxSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return PaymentSectionCard(
      title: localizations.payments_taxesData_title,
      icon: Icon(
        Icons.paid_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      nextInfoDue: NextTaxInfo(car: car),
      items: car.taxDatas!
          .map((tax) => TaxItem(tax: tax, locale: locale))
          .toList(),
    );
  }
}
