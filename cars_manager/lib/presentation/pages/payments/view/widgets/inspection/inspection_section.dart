import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'next_inspection_info.dart';
import 'inspection_item.dart';

class InspectionSection extends StatelessWidget {
  final Car car;

  const InspectionSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final items = car.inspectionDatas ?? const <InspectionData>[];

    return PaymentSectionCard(
      title: localizations.payments_inspectionsData_title,
      icon: SvgPicture.asset(
        "assets/icons/inspection.svg",
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
            Provider.of<CarsManagerState>(
              context,
              listen: false,
            ).addInspectionPayment(data);
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
      nextInfoDue: items.isNotEmpty ? NextInspectionInfo(car: car) : null,
      items: [
        if (items.isEmpty)
          EmptyStateWidget(
            message: localizations.payments_inspectionsData_empty,
            actionLabel: localizations.common_add,
            iconWidget: SvgPicture.asset(
              "assets/icons/inspection.svg",
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
                Provider.of<CarsManagerState>(
                  context,
                  listen: false,
                ).addInspectionPayment(data);
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
