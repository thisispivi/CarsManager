import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';

/// Displays a consistently styled floating snackbar.
///
/// Uses [colorScheme.inverseSurface] for success toasts and
/// [colorScheme.error] for error toasts so the text always contrasts
/// well in both light and dark mode.
class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final bg = isError ? cs.error : cs.inverseSurface;
    final fg = isError ? cs.onError : cs.onInverseSurface;
    final icon = isError
        ? Icons.error_outline_rounded
        : Icons.check_circle_outline_rounded;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: fg, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: bg,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
      );
  }
}
