import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import '../entries/add_payment_bottom_sheet.dart';
import '../common/payment_section_card.dart';
import 'next_tax_info.dart';
import 'tax_item.dart';

class TaxSection extends StatelessWidget {
  final Car car;

  const TaxSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final items = car.taxDatas ?? const <TaxData>[];

    return PaymentSectionCard(
      title: localizations.payments_taxesData_title,
      icon: Icon(
        Icons.paid_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: TextButton.icon(
        onPressed: () async {
          final TaxData? data = await showModalBottomSheet<TaxData>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                const AddPaymentBottomSheet(type: PaymentEntryType.tax),
          );

          if (data != null && context.mounted) {
            Provider.of<CarsManagerState>(
              context,
              listen: false,
            ).addTaxPayment(data);
          }
        },
        icon: Icon(
          Icons.add_circle_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          localizations.common_add,
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
      ),
      nextInfoDue: items.isNotEmpty ? NextTaxInfo(car: car) : null,
      items: [
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              localizations.payments_taxesData_empty,
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
            ),
          )
        else
          ...items.asMap().entries.map(
            (entry) => TaxItem(
              tax: entry.value,
              locale: locale,
              isLast: entry.key == items.length - 1,
            ),
          ),
      ],
    );
  }
}
