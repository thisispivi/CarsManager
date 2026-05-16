import 'package:flutter/material.dart';

/// Central color tokens for the CarsManager design system.
class AppColors {
  /// Primary brand blue, derived from the CarsManager logo gradient.
  static const Color brandPrimary = Color(0xFF4361EE);

  /// Secondary brand purple, the right-side of the logo gradient.
  static const Color brandSecondary = Color(0xFF9333EA);

  /// Blue side of the CarsManager brand gradient (top-left of logo).
  static const Color brandGradientStart = Color(0xFF4361EE);

  /// Purple side of the CarsManager brand gradient (bottom-right of logo).
  static const Color brandGradientEnd = Color(0xFF9333EA);

  /// Mid-point purple-blue used for tonal accents and selected chips.
  static const Color brandAccent = Color(0xFF7B6EF7);

  /// Logo-aligned brand gradient for hero surfaces and highlights.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandGradientStart, brandGradientEnd],
  );

  /// Light theme surfaces, borders, and foreground neutrals.
  static const Color surfaceLight = Color.fromRGBO(255, 255, 255, 1);
  static const Color surfaceAlt = Color(0xFFF7F8FA);
  static const Color surfaceContainerLight = Color(0xFFF0F2F5);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE4E7EC);
  static const Color tertiaryLight = Color(0xFFEEEDFD);
  static const Color secondaryLight = Color(0xFF5A6370);
  static const Color onSurfaceVariantLight = Color(0xFF5A6370);
  static const Color primaryLight = Color(0xFF0D1117);
  static const Color onTertiaryVariantLight = Color(0xFF8B95A3);
  static const Color onSecondaryVariantLight = Color(0xFFCBD1D8);

  /// Dark theme surfaces, borders, and foreground neutrals.
  static const Color surfaceDark = Color(0xFF0F1114);
  static const Color surfaceAltDark = Color(0xFF161A1E);
  static const Color surfaceContainerDark = Color(0xFF1E2226);
  static const Color cardDark = Color(0xFF1C2026);
  static const Color borderDark = Color(0xFF2A2E34);
  static const Color tertiaryDark = Color.fromRGBO(45, 53, 62, 1);
  static const Color secondaryDark = Color(0xFF8B95A3);
  static const Color onSurfaceVariantDark = Color(0xFF8B95A3);
  static const Color primaryDark = Color(0xFFF0F2F5);
  static const Color onTertiaryVariantDark = Color(0xFF3A4049);
  static const Color onSecondaryVariantDark = Color(0xFF2A2E34);

  /// Semantic status colors used across validation, alerts, and due dates.
  static const Color success = Color(0xFF1EA85A);
  static const Color warning = Color(0xFFE8960C);
  static const Color danger = Color(0xFFDC3545);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF4361EE);

  /// Ordered palette for charts; index 0 mirrors the brand primary token.
  static const List<Color> chartColors = [
    brandPrimary,
    Color(0xFF1EA85A),
    Color(0xFFE8960C),
    Color(0xFFDC3545),
    brandSecondary,
    Color(0xFF06B6D4),
  ];
}
