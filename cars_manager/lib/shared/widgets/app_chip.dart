import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
    this.selected = false,
  });

  final String label;
  final Color? color;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.brandPrimary;
    final scheme = Theme.of(context).colorScheme;

    final bgColor = selected
        ? effectiveColor.withValues(alpha: 0.15)
        : scheme.surfaceContainerHighest;
    final fgColor = selected ? effectiveColor : scheme.onSurfaceVariant;
    final borderColor = selected
        ? effectiveColor.withValues(alpha: 0.4)
        : scheme.outlineVariant;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
