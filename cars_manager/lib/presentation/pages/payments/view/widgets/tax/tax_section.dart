import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/tax/next_tax_info.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/tax/tax_item.dart';

class TaxSection extends ConsumerWidget {
  final Car car;

  const TaxSection({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final items = car.taxDatas;

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
            ref.read(expensesControllerProvider.notifier).addTax(data);
          }
        },
        icon: Icon(
          Icons.add_circle_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          localizations.common_add,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      nextInfoDue: items.isNotEmpty ? NextTaxInfo(car: car) : null,
      items: [
        if (items.isEmpty)
          EmptyStateWidget(
            message: localizations.payments_taxesData_empty,
            actionLabel: localizations.common_add,
            icon: Icons.paid_outlined,
            onAction: () async {
              final TaxData? data = await showModalBottomSheet<TaxData>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    const AddPaymentBottomSheet(type: PaymentEntryType.tax),
              );

              if (data != null && context.mounted) {
                ref.read(expensesControllerProvider.notifier).addTax(data);
              }
            },
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
