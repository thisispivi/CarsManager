import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/shared/widgets/vehicle_visual_card.dart';
import 'package:flutter/material.dart';

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
    final cs = theme.colorScheme;
    final radius = BorderRadius.circular(AppRadius.cardLg);

    final hasImage =
        (car.imageBase64 != null && car.imageBase64!.isNotEmpty) ||
        (car.imageUrl != null && car.imageUrl!.isNotEmpty);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: radius,
        border: Border.all(
          color: isActive ? cs.primary : cs.outline,
          width: isActive ? 1.5 : 0.5,
        ),
        boxShadow: isActive
            ? AppShadows.brandGlow(cs.primary)
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
                // ── Image with gradient, name overlay and menu ──────────
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
                        VehicleVisualCard(car: car, borderRadius: 0),
                      // Gradient overlay
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xC0000000)],
                          ),
                        ),
                      ),
                      // Name + subtitle overlaid bottom-left
                      Positioned(
                        left: AppSpacing.md,
                        right: AppSpacing.xl + AppSpacing.md,
                        bottom: AppSpacing.md,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              car.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                            Text(
                              '${car.manufacture} ${car.model} · ${car.yearOfManufacture}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.80),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Three-dot menu top-right
                      Positioned(
                        top: AppSpacing.xs,
                        right: AppSpacing.xs,
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).moreButtonTooltip,
                          position: PopupMenuPosition.over,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          onSelected: (value) {
                            if (value == 'edit') onEdit();
                            if (value == 'remove') onDelete();
                          },
                          itemBuilder: (context) => [
                            _menuItem(
                              context: context,
                              value: 'edit',
                              icon: Icons.edit_outlined,
                              label: l10n.common_edit,
                              iconColor: cs.onSurface,
                              textColor: cs.onSurface,
                            ),
                            _menuItem(
                              context: context,
                              value: 'remove',
                              icon: Icons.delete_outline,
                              label: l10n.common_delete,
                              iconColor: cs.error,
                              textColor: cs.error,
                            ),
                          ],
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.more_vert,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Info section below image ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Plate + fuel type tags
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: [
                          if (car.licensePlate.isNotEmpty)
                            _InfoTag(
                              icon: Icons.confirmation_number_outlined,
                              label: car.licensePlate,
                            ),
                          if (car.fuelType != null)
                            _InfoTag(
                              icon: Icons.local_gas_station_rounded,
                              label: car.fuelType!.name,
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Status rows (insurance / inspection / tax)
                      _DueRow(
                        icon: Icons.description_outlined,
                        color: AppColors.categoryInsurance,
                        label: l10n.vehicleDetail_insurance,
                        days: car.daysUntilNextInsuranceExpiration,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _DueRow(
                        icon: Icons.fact_check_outlined,
                        color: AppColors.categoryInspection,
                        label: l10n.vehicleDetail_inspection,
                        days: car.daysUntilNextInspection,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _DueRow(
                        icon: Icons.paid_outlined,
                        color: AppColors.categoryTax,
                        label: l10n.vehicleDetail_tax,
                        days: car.daysUntilNextTaxDue,
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

  PopupMenuItem<String> _menuItem({
    required BuildContext context,
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
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Compact info tag (plate / fuel type) ─────────────────────────────────────

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: cs.outline, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: cs.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Compact status row (icon + label + days pill) ────────────────────────────

class _DueRow extends StatelessWidget {
  const _DueRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.days,
  });

  final IconData icon;
  final Color color;
  final String label;
  final int? days;

  @override
  Widget build(BuildContext context) {
    final statusColor = statusColorForDaysOf(context, days);
    final value = days == null ? '—' : '${days!}d';

    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.7),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
