import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Immutable color + icon token for a single expense category.
///
/// Use [CategoryStyle.of] to look up a category by its string key.
/// Keys: 'fuel', 'insurance', 'inspection', 'tax', 'repair', 'fine'.
class CategoryStyle {
  const CategoryStyle({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  static const Map<String, CategoryStyle> _map = {
    'fuel': CategoryStyle(
      color: AppColors.categoryFuel,
      icon: Icons.local_gas_station_rounded,
    ),
    'insurance': CategoryStyle(
      color: AppColors.categoryInsurance,
      icon: Icons.description_outlined,
    ),
    'inspection': CategoryStyle(
      color: AppColors.categoryInspection,
      icon: Icons.fact_check_outlined,
    ),
    'tax': CategoryStyle(
      color: AppColors.categoryTax,
      icon: Icons.paid_outlined,
    ),
    'repair': CategoryStyle(
      color: AppColors.categoryRepair,
      icon: Icons.build_rounded,
    ),
    'fine': CategoryStyle(
      color: AppColors.categoryFine,
      icon: Icons.report_gmailerrorred_rounded,
    ),
  };

  /// Returns the [CategoryStyle] for the given [key], falling back to a
  /// neutral style when the key is unrecognised.
  static CategoryStyle of(String key) =>
      _map[key] ??
      const CategoryStyle(
        color: AppColors.categoryInspection,
        icon: Icons.help_outline,
      );
}
