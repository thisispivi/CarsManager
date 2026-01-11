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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (car.imageUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  child: ImageRect(
                    imageUrl: car.imageUrl,
                    imageAlignment: car.imageAlignment,
                    aspectRatio: 16 / 9,
                    backgroundColor: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.zero,
                    primaryColor: cs.primary,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: cs.primary,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: cs.onSurfaceVariant,
                          ),
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).moreButtonTooltip,
                          position: PopupMenuPosition.over,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${car.manufacture} • ${car.model}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface.withValues(alpha: 0.85),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${car.yearOfManufacture} • ${car.licensePlate}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
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
    );
  }
}
