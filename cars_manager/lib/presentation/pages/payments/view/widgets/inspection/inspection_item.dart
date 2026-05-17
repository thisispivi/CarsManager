import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/presentation/common/widgets/entry_actions.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class InspectionItem extends ConsumerWidget {
  final InspectionData inspection;
  final Locale locale;
  final bool isLast;

  const InspectionItem({
    super.key,
    required this.inspection,
    required this.locale,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat('dd MMM yyyy', locale.toString());

    Future<void> editInspection() async {
      final updated = await showModalBottomSheet<InspectionData>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => AddPaymentBottomSheet(
          type: PaymentEntryType.inspection,
          initialData: inspection,
        ),
      );

      if (updated != null && context.mounted) {
        ref
            .read(expensesControllerProvider.notifier)
            .updateInspection(oldData: inspection, data: updated);
      }
    }

    void showActions() {
      showEntryActionsSheet(
        context: context,
        onEdit: editInspection,
        onDelete: () {
          ref
              .read(expensesControllerProvider.notifier)
              .removeInspection(inspection);
        },
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onLongPress: showActions,
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
                      dateFormat.format(inspection.date),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: inspection.isPassed
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          inspection.isPassed
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 14,
                          color: inspection.isPassed
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          inspection.isPassed
                              ? localizations
                                    .payments_inspectionsData_status_passed
                              : localizations
                                    .payments_inspectionsData_status_failed,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: inspection.isPassed
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: showActions,
                    icon: const Icon(Icons.more_vert_rounded),
                    tooltip: localizations.common_actions,
                  ),
                ],
              ),
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
                      icon: Icons.speed_rounded,
                      value: inspection.mileage == null
                          ? '-'
                          : localizations.unit_km(
                              numberFormat.format(inspection.mileage),
                            ),
                      colorScheme: colorScheme,
                    ),
                  ),
                  if (inspection.amount != null) ...[
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
                            numberFormat.format(inspection.amount),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
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
                ],
              ),
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
