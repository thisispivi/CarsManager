import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final items = car.insuranceDatas ?? const <InsuranceData>[];

    return PaymentSectionCard(
      title: localizations.payments_insuranceData_title,
      icon: Icon(
        Icons.description_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: TextButton.icon(
        onPressed: () async {
          final InsuranceData? data = await showModalBottomSheet<InsuranceData>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                const AddPaymentBottomSheet(type: PaymentEntryType.insurance),
          );

          if (data != null && context.mounted) {
            Provider.of<CarsManagerState>(
              context,
              listen: false,
            ).addInsurancePayment(data);
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
      nextInfoDue: items.isNotEmpty ? NextInsuranceInfo(car: car) : null,
      items: [
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              localizations.payments_insuranceData_empty,
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
            ),
          )
        else
          ...items.asMap().entries.map(
            (entry) => InsuranceItem(
              insurance: entry.value,
              locale: locale,
              isLast: entry.key == items.length - 1,
            ),
          ),
      ],
    );
  }
}
