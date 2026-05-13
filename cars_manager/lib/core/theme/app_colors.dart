import 'package:flutter/material.dart';

/// Central color tokens for the CarsManager design system.
class AppColors {
  /// Primary brand purple-indigo, matched to the PNG logo family.
  static const Color brandPrimary = Color(0xFF6C3FE4);

  /// Positive accent used for healthy metrics and success indicators.
  static const Color brandSecondary = Color(0xFF4DCF82);

  /// Deep indigo side of the CarsManager brand gradient.
  static const Color brandGradientStart = Color(0xFF3D2AB8);

  /// Vivid purple side of the CarsManager brand gradient.
  static const Color brandGradientEnd = Color(0xFF8B3FE8);

  /// Lighter purple used for tonal accents.
  static const Color brandAccent = Color(0xFF9B6FF5);

  /// Logo-aligned brand gradient for hero surfaces and highlights.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandGradientStart, brandGradientEnd],
  );

  /// Light theme surfaces, borders, and foreground neutrals.
  static const Color surfaceLight = Color.fromRGBO(255, 255, 255, 1);
  static const Color surfaceAlt = Color(0xFFF7F8FA);
  static const Color surfaceContainerLight = Color.fromRGBO(250, 250, 250, 1);
  static const Color cardLight = Color.fromRGBO(240, 240, 240, 1);
  static const Color borderLight = Color(0xFFE4E7EC);
  static const Color tertiaryLight = Color.fromRGBO(220, 220, 220, 1);
  static const Color secondaryLight = Color.fromRGBO(120, 120, 120, 1);
  static const Color onSurfaceVariantLight = Color.fromRGBO(60, 60, 60, 1);
  static const Color primaryLight = Color.fromRGBO(0, 0, 0, 1);
  static const Color onTertiaryVariantLight = Color.fromRGBO(220, 220, 220, 1);
  static const Color onSecondaryVariantLight = Color.fromRGBO(200, 200, 200, 1);

  /// Dark theme surfaces, borders, and foreground neutrals.
  static const Color surfaceDark = Color.fromRGBO(19, 20, 22, 1);
  static const Color surfaceAltDark = Color(0xFF181B1F);
  static const Color surfaceContainerDark = Color.fromRGBO(19, 20, 22, 0.6);
  static const Color cardDark = Color.fromRGBO(30, 33, 36, 1);
  static const Color borderDark = Color(0xFF2A2E34);
  static const Color tertiaryDark = Color.fromRGBO(45, 53, 62, 1);
  static const Color secondaryDark = Color.fromRGBO(158, 171, 184, 1);
  static const Color onSurfaceVariantDark = Color.fromRGBO(163, 171, 178, 1);
  static const Color primaryDark = Color.fromRGBO(255, 255, 255, 1);
  static const Color onTertiaryVariantDark = Color.fromRGBO(61, 68, 74, 1);
  static const Color onSecondaryVariantDark = Color.fromRGBO(43, 48, 54, 1);

  /// Semantic status colors used across validation, alerts, and due dates.
  static const Color success = Color.fromRGBO(77, 207, 130, 1);
  static const Color warning = Color.fromRGBO(255, 184, 76, 1);
  static const Color danger = Color.fromRGBO(255, 88, 88, 1);
  static const Color error = Color.fromRGBO(255, 88, 88, 1);
  static const Color info = Color.fromRGBO(85, 161, 255, 1);

  /// Ordered palette for charts; index 0 mirrors the brand primary token.
  static const List<Color> chartColors = [
    brandPrimary,
    Color.fromRGBO(77, 207, 130, 1),
    Color.fromRGBO(255, 184, 76, 1),
    Color.fromRGBO(255, 88, 88, 1),
    Color.fromRGBO(170, 130, 255, 1),
  ];
}
