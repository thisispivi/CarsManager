import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);
    final child = isLoading
        ? SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.foreground,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
            ],
          );

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        disabledBackgroundColor: colors.background.withValues(alpha: 0.4),
        disabledForegroundColor: colors.foreground.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
      onPressed: isLoading ? null : onPressed,
      child: child,
    );
  }

  _ButtonColors _colors(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (variant) {
      AppButtonVariant.primary => const _ButtonColors(
        AppColors.brandPrimary,
        Colors.white,
      ),
      AppButtonVariant.secondary => const _ButtonColors(
        AppColors.brandSecondary,
        Colors.white,
      ),
      AppButtonVariant.ghost => _ButtonColors(
        scheme.surfaceContainerHighest,
        scheme.onSurface,
      ),
      AppButtonVariant.danger => const _ButtonColors(
        AppColors.danger,
        Colors.white,
      ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors(this.background, this.foreground);

  final Color background;
  final Color foreground;
}
