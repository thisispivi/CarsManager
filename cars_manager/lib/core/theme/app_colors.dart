import 'package:flutter/material.dart';

/// Central color tokens for the CarsManager design system.
class AppColors {
  /// Light theme palette: warm neutral surfaces with a coral accent.
  static const Color bgLight = Color(0xFFF6F2EC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surface2Light = Color(0xFFFAF7F2);
  static const Color borderLight = Color.fromRGBO(40, 30, 20, 0.08);
  static const Color borderStrongLight = Color.fromRGBO(40, 30, 20, 0.14);
  static const Color textLight = Color(0xFF1B1410);
  static const Color textMutedLight = Color.fromRGBO(27, 20, 16, 0.62);
  static const Color textFaintLight = Color.fromRGBO(27, 20, 16, 0.38);
  static const Color accentLight = Color(0xFFE5734F);
  static const Color accentInkLight = Color(0xFFFFFFFF);
  static const Color successLight = Color(0xFF2C8C72);
  static const Color warnLight = Color(0xFFC9A227);
  static const Color dangerLight = Color(0xFFC04949);
  static const Color chipBgLight = Color.fromRGBO(229, 115, 79, 0.10);

  /// Dark theme palette: warm dark surfaces with brighter semantic colors.
  static const Color bgDark = Color(0xFF1A1612);
  static const Color surfaceDark = Color(0xFF22201C);
  static const Color surface2Dark = Color(0xFF2A2722);
  static const Color borderDark = Color.fromRGBO(255, 245, 230, 0.08);
  static const Color borderStrongDark = Color.fromRGBO(255, 245, 230, 0.16);
  static const Color textDark = Color(0xFFFBF7F0);
  static const Color textMutedDark = Color.fromRGBO(251, 247, 240, 0.66);
  static const Color textFaintDark = Color.fromRGBO(251, 247, 240, 0.40);
  static const Color accentDark = Color(0xFFEF8B6B);
  static const Color accentInkDark = Color(0xFF1A1612);
  static const Color successDark = Color(0xFF52B597);
  static const Color warnDark = Color(0xFFE8C152);
  static const Color dangerDark = Color(0xFFE07373);
  static const Color chipBgDark = Color.fromRGBO(239, 139, 107, 0.16);

  /// Theme-invariant colors assigned to spending categories.
  static const Color categoryFuel = Color(0xFFE5734F);
  static const Color categoryInsurance = Color(0xFF2C8C72);
  static const Color categoryInspection = Color(0xFF3D6FB5);
  static const Color categoryTax = Color(0xFFC9A227);
  static const Color categoryRepair = Color(0xFF8E5BC2);
  static const Color categoryFine = Color(0xFFC04949);

  /// Ordered palette for charts — matches category order.
  static const List<Color> chartColors = [
    categoryFuel,
    categoryInsurance,
    categoryInspection,
    categoryTax,
    categoryRepair,
    categoryFine,
  ];
}
