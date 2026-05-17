import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);
    final (height, hPad, radius) = switch (size) {
      AppButtonSize.sm => (36.0, 14.0, 12.0),
      AppButtonSize.md => (48.0, 18.0, AppRadius.md),
      AppButtonSize.lg => (56.0, 22.0, 18.0),
    };

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

    Widget button = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        disabledBackgroundColor: colors.background.withValues(alpha: 0.4),
        disabledForegroundColor: colors.foreground.withValues(alpha: 0.5),
        minimumSize: Size(0, height),
        padding: EdgeInsets.symmetric(horizontal: hPad),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: size == AppButtonSize.sm ? 14 : 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    if (fullWidth) button = SizedBox(width: double.infinity, child: button);
    return button;
  }

  _ButtonColors _colors(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (variant) {
      AppButtonVariant.primary => _ButtonColors(
        scheme.primary,
        scheme.onPrimary,
      ),
      AppButtonVariant.secondary => _ButtonColors(
        scheme.primary.withValues(alpha: 0.12),
        scheme.primary,
      ),
      AppButtonVariant.ghost => _ButtonColors(
        Colors.transparent,
        scheme.onSurface,
      ),
      AppButtonVariant.danger => const _ButtonColors(
        AppColors.dangerLight,
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
