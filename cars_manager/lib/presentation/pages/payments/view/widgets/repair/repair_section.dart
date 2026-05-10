import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/repair/repair_item.dart';

class RepairSection extends ConsumerWidget {
  final Car car;

  const RepairSection({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final items = car.repairDatas;

    return PaymentSectionCard(
      title: localizations.payments_repairsData_title,
      icon: Icon(
        Icons.handyman_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: TextButton.icon(
        onPressed: () async {
          final RepairData? data = await showModalBottomSheet<RepairData>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                const AddPaymentBottomSheet(type: PaymentEntryType.repair),
          );

          if (data != null && context.mounted) {
            ref.read(expensesControllerProvider.notifier).addRepair(data);
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
      items: [
        if (items.isEmpty)
          EmptyStateWidget(
            message: localizations.payments_repairsData_empty,
            actionLabel: localizations.common_add,
            icon: Icons.handyman_outlined,
            onAction: () async {
              final RepairData? data = await showModalBottomSheet<RepairData>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    const AddPaymentBottomSheet(type: PaymentEntryType.repair),
              );

              if (data != null && context.mounted) {
                ref.read(expensesControllerProvider.notifier).addRepair(data);
              }
            },
          )
        else
          ...items.asMap().entries.map(
            (entry) => RepairItem(
              repair: entry.value,
              locale: locale,
              isLast: entry.key == items.length - 1,
            ),
          ),
      ],
    );
  }
}
