import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Returns a status color based on days remaining until a deadline.
///
/// Uses the app's semantic color tokens:
/// - [AppColors.dangerLight] / [AppColors.dangerDark] for overdue (days < 0)
/// - [AppColors.warnLight] / [AppColors.warnDark] for due within 30 days
/// - [AppColors.successLight] / [AppColors.successDark] for more than 30 days
Color statusColorForDays(int? days, {bool isDark = false}) {
  if (days == null) {
    return AppColors.categoryInspection;
  }
  if (days < 0) return isDark ? AppColors.dangerDark : AppColors.dangerLight;
  if (days <= 30) return isDark ? AppColors.warnDark : AppColors.warnLight;
  return isDark ? AppColors.successDark : AppColors.successLight;
}

/// Theme-aware version that reads brightness from [BuildContext].
Color statusColorForDaysOf(BuildContext context, int? days) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return statusColorForDays(days, isDark: isDark);
}

/// Legacy alias — kept for callers using the old name.
@Deprecated('Use statusColorForDays instead')
Color dueDateColorForDays(int daysRemaining) {
  if (daysRemaining < 0) return AppColors.dangerLight;
  if (daysRemaining < 7) return AppColors.dangerLight;
  if (daysRemaining < 30) return AppColors.warnLight;
  return AppColors.successLight;
}
