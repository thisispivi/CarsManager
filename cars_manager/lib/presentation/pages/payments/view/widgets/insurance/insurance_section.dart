import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/insurance/next_insurance_info.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/insurance/insurance_item.dart';

class InsuranceSection extends ConsumerWidget {
  final Car car;

  const InsuranceSection({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final items = car.insuranceDatas;

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
            ref.read(expensesControllerProvider.notifier).addInsurance(data);
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
          EmptyStateWidget(
            message: localizations.payments_insuranceData_empty,
            actionLabel: localizations.common_add,
            icon: Icons.description_outlined,
            onAction: () async {
              final InsuranceData? data =
                  await showModalBottomSheet<InsuranceData>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddPaymentBottomSheet(
                      type: PaymentEntryType.insurance,
                    ),
                  );

              if (data != null && context.mounted) {
                ref
                    .read(expensesControllerProvider.notifier)
                    .addInsurance(data);
              }
            },
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
