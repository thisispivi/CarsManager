import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/due_date_pill.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CarTile extends StatelessWidget {
  final Car car;
  final bool isActive;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CarTile({
    super.key,
    required this.car,
    required this.isActive,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(14);

    final baseCardColor = Theme.of(context).cardColor;
    final selectedCardColor = Theme.of(
      context,
    ).colorScheme.primary.withAlpha(40);
    final cardColor = isActive ? selectedCardColor : baseCardColor;

    final nextInsuranceDate = car.getNextInsuranceExpirationDate() as DateTime?;
    final daysUntilInsurance =
        car.getDaysUntilNextInsuranceExpiration() as int?;

    final nextInspectionDate = car.getNextInspectionDate() as DateTime?;
    final daysUntilInspection = car.getDaysUntilNextInspection() as int?;

    final nextTaxDate = car.getNextTaxDueDate() as DateTime?;
    final daysUntilTax = car.getDaysUntilNextTaxDue() as int?;

    PopupMenuItem<String> menuItem({
      required String value,
      required IconData icon,
      required String label,
      Color? iconColor,
      Color? textColor,
    }) {
      return PopupMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return AnimatedPhysicalModel(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      elevation: isActive ? 4 : 3,
      color: cardColor,
      shadowColor: Colors.black26,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      shape: BoxShape.rectangle,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onSelect,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((car.imageBase64 != null &&
                          car.imageBase64!.isNotEmpty) ||
                      (car.imageUrl != null && car.imageUrl!.isNotEmpty))
                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 170,
                          height: 170,
                          child: ImageRect(
                            aspectRatio: 1 / 1,
                            imageUrl: car.imageUrl,
                            imageBase64: car.imageBase64,
                            imageAlignment: car.imageAlignment,
                            backgroundColor: cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.zero,
                            primaryColor: cs.primary,
                          ),
                        ),
                      ),
                    ),
                  if ((car.imageBase64 != null &&
                          car.imageBase64!.isNotEmpty) ||
                      (car.imageUrl != null && car.imageUrl!.isNotEmpty))
                    const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                car.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary,
                                  height: 1.05,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(2, 0),
                              child: PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                tooltip: MaterialLocalizations.of(
                                  context,
                                ).moreButtonTooltip,
                                position: PopupMenuPosition.over,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 20,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case 'edit':
                                      onEdit();
                                      break;
                                    case 'remove':
                                      onDelete();
                                      break;
                                  }
                                },
                                itemBuilder: (context) => [
                                  menuItem(
                                    value: 'edit',
                                    icon: Icons.edit_outlined,
                                    label: l10n.common_edit,
                                    iconColor: cs.onSurface,
                                    textColor: cs.onSurface,
                                  ),
                                  menuItem(
                                    value: 'remove',
                                    icon: Icons.delete_outline,
                                    label: l10n.common_delete,
                                    iconColor: cs.error,
                                    textColor: cs.error,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${car.manufacture} • ${car.model}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withValues(alpha: 0.85),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${car.yearOfManufacture} • ${car.licensePlate}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            DueDatePill(
                              icon: Icons.description_outlined,
                              tooltip: l10n.payments_insuranceData_nextDue,
                              dueDate: nextInsuranceDate,
                              daysRemaining: daysUntilInsurance,
                              daysLabel: l10n.days,
                            ),
                            DueDatePill(
                              leading: SvgPicture.asset(
                                'assets/icons/inspection.svg',
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              tooltip: l10n.payments_inspectionsData_nextDue,
                              dueDate: nextInspectionDate,
                              daysRemaining: daysUntilInspection,
                              daysLabel: l10n.days,
                            ),
                            DueDatePill(
                              icon: Icons.paid_outlined,
                              tooltip: l10n.payments_taxesData_nextDue,
                              dueDate: nextTaxDate,
                              daysRemaining: daysUntilTax,
                              daysLabel: l10n.days,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
