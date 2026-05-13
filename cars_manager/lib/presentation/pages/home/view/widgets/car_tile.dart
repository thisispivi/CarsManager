import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/due_date_pill.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(AppRadius.lg);
    final cardColor = theme.cardColor;

    final nextInsuranceDate = car.nextInsuranceExpirationDate;
    final daysUntilInsurance = car.daysUntilNextInsuranceExpiration;

    final nextInspectionDate = car.nextInspectionDate;
    final daysUntilInspection = car.daysUntilNextInspection;

    final nextTaxDate = car.nextTaxDueDate;
    final daysUntilTax = car.daysUntilNextTaxDue;

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
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final hasImage =
        (car.imageBase64 != null && car.imageBase64!.isNotEmpty) ||
        (car.imageUrl != null && car.imageUrl!.isNotEmpty);

    final dueDatePills = Wrap(
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
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: radius,
        border: Border.all(
          color: isActive ? AppColors.brandPrimary : cs.outlineVariant,
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? AppShadows.brandGlow(AppColors.brandPrimary)
            : (theme.brightness == Brightness.light ? AppShadows.xs : null),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onSelect,
          child: ClipRRect(
            borderRadius: radius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (hasImage)
                        ImageRect(
                          aspectRatio: 16 / 9,
                          imageUrl: car.imageUrl,
                          imageBase64: car.imageBase64,
                          imageAlignment: car.imageAlignment,
                          backgroundColor: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.zero,
                          primaryColor: cs.primary,
                        )
                      else
                        Container(
                          decoration: const BoxDecoration(
                            gradient: AppColors.brandGradient,
                          ),
                          child: Icon(
                            Icons.directions_car_filled_rounded,
                            color: Colors.white.withValues(alpha: 0.9),
                            size: 56,
                          ),
                        ),
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0x8C000000)],
                            ),
                          ),
                        ),
                      ),
                      Positioned(left: 10, bottom: 10, child: dueDatePills),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 10, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              car.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                                height: 1.1,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(4, -6),
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
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: cs.onSurfaceVariant,
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
                      const SizedBox(height: 4),
                      Text(
                        '${car.manufacture} • ${car.model}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface.withValues(alpha: 0.84),
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${car.yearOfManufacture} • ${car.licensePlate}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: cs.onSurfaceVariant,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
