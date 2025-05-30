import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle _baseStyle(double fontSize, FontWeight weight, Color color) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
    );
  }

  // Headers
  static TextStyle h1(BuildContext context) =>
      _baseStyle(28, FontWeight.w700, Theme.of(context).colorScheme.primary);

  static TextStyle h2(BuildContext context) =>
      _baseStyle(24, FontWeight.w700, Theme.of(context).colorScheme.primary);

  static TextStyle h3(BuildContext context) =>
      _baseStyle(22, FontWeight.w700, Theme.of(context).colorScheme.primary);

  static TextStyle h4(BuildContext context) =>
      _baseStyle(20, FontWeight.w600, Theme.of(context).colorScheme.primary);

  // Body text
  static TextStyle bodyLarge(BuildContext context) =>
      _baseStyle(16, FontWeight.normal, Theme.of(context).colorScheme.primary);

  static TextStyle bodyMedium(BuildContext context) =>
      _baseStyle(14, FontWeight.normal, Theme.of(context).colorScheme.primary);

  static TextStyle bodySmall(BuildContext context) => _baseStyle(
    12,
    FontWeight.normal,
    Theme.of(context).colorScheme.secondary,
  );

  // Special styles
  static TextStyle label(BuildContext context) =>
      _baseStyle(14, FontWeight.w500, Theme.of(context).colorScheme.secondary);

  static TextStyle button(BuildContext context) =>
      _baseStyle(16, FontWeight.w600, Theme.of(context).colorScheme.primary);
}
