import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens and context-aware helpers for CarsManager text.
class AppTextStyles {
  /// Large display token for rare high-emphasis headings.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );

  /// Medium display token for page-level editorial headings.
  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );

  /// Large heading token for screen titles.
  static const TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Medium heading token for sections.
  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// Small heading token for cards and compact headers.
  static const TextStyle headingSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Large body token for primary content.
  static const TextStyle bodyLargeToken = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Medium body token for dense content and list rows.
  static const TextStyle bodyMediumToken = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Small body token for secondary metadata.
  static const TextStyle bodySmallToken = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Label token for field labels and compact controls.
  static const TextStyle labelToken = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Caption token for minor metadata.
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.2,
  );

  /// Button text token for command surfaces.
  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  /// Monospace token for technical data and identifiers.
  static const TextStyle monospace = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    height: 1.5,
  );

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
