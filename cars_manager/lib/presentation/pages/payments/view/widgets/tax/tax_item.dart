import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/presentation/common/widgets/entry_actions.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TaxItem extends ConsumerWidget {
  final TaxData tax;
  final Locale locale;
  final bool isLast;

  const TaxItem({
    super.key,
    required this.tax,
    required this.locale,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat('dd MMM yyyy', locale.toString());

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onLongPress: () {
        showEntryActionsSheet(
          context: context,
          onEdit: () {
            () async {
              final updated = await showModalBottomSheet<TaxData>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => AddPaymentBottomSheet(
                  type: PaymentEntryType.tax,
                  initialData: tax,
                ),
              );

              if (updated != null && context.mounted) {
                ref
                    .read(expensesControllerProvider.notifier)
                    .updateTax(oldData: tax, data: updated);
              }
            }();
          },
          onDelete: () {
            ref.read(expensesControllerProvider.notifier).removeTax(tax);
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 8, left: 16, right: 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  dateFormat.format(tax.date),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.euro_rounded,
                      size: 14,
                      color: colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      numberFormat.format(tax.amount),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                      textScaler: MediaQuery.textScalerOf(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
