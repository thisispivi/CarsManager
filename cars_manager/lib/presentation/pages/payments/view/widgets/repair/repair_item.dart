import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/presentation/common/widgets/entry_actions.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RepairItem extends ConsumerWidget {
  final RepairData repair;
  final Locale locale;
  final bool isLast;

  const RepairItem({
    super.key,
    required this.repair,
    required this.locale,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat('dd MMM yyyy', locale.toString());

    final description = repair.description.trim();

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onLongPress: () {
        showEntryActionsSheet(
          context: context,
          onEdit: () {
            () async {
              final updated = await showModalBottomSheet<RepairData>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => AddPaymentBottomSheet(
                  type: PaymentEntryType.repair,
                  initialData: repair,
                ),
              );

              if (updated != null && context.mounted) {
                ref
                    .read(expensesControllerProvider.notifier)
                    .updateRepair(oldData: repair, data: updated);
              }
            }();
          },
          onDelete: () {
            ref.read(expensesControllerProvider.notifier).removeRepair(repair);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dateFormat.format(repair.date),
                      style: GoogleFonts.spaceGrotesk(
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
                          numberFormat.format(repair.amount),
                          style: GoogleFonts.spaceGrotesk(
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
              if (description.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _DetailItem(
                        icon: Icons.build_rounded,
                        value: description,
                        colorScheme: colorScheme,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final ColorScheme colorScheme;

  const _DetailItem({
    required this.icon,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.primary.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
