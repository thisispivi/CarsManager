import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/inspection/next_inspection_info.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/inspection/inspection_item.dart';

class InspectionSection extends ConsumerWidget {
  final Car car;

  const InspectionSection({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final items = car.inspectionDatas;

    return PaymentSectionCard(
      title: localizations.payments_inspectionsData_title,
      icon: SvgPicture.asset(
        'assets/icons/inspection.svg',
        width: 26,
        height: 26,
        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
      ),
      trailing: TextButton.icon(
        onPressed: () async {
          final InspectionData? data =
              await showModalBottomSheet<InspectionData>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const AddPaymentBottomSheet(
                  type: PaymentEntryType.inspection,
                ),
              );

          if (data != null && context.mounted) {
            ref.read(expensesControllerProvider.notifier).addInspection(data);
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
      nextInfoDue: items.isNotEmpty ? NextInspectionInfo(car: car) : null,
      items: [
        if (items.isEmpty)
          EmptyStateWidget(
            message: localizations.payments_inspectionsData_empty,
            actionLabel: localizations.common_add,
            iconWidget: SvgPicture.asset(
              'assets/icons/inspection.svg',
              width: 48,
              height: 48,
              colorFilter: ColorFilter.mode(
                colorScheme.primary.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
            onAction: () async {
              final InspectionData? data =
                  await showModalBottomSheet<InspectionData>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddPaymentBottomSheet(
                      type: PaymentEntryType.inspection,
                    ),
                  );

              if (data != null && context.mounted) {
                ref
                    .read(expensesControllerProvider.notifier)
                    .addInspection(data);
              }
            },
          )
        else
          ...items.asMap().entries.map(
            (entry) => InspectionItem(
              inspection: entry.value,
              locale: locale,
              isLast: entry.key == items.length - 1,
            ),
          ),
      ],
    );
  }
}
