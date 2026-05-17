import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens and context-aware helpers for CarsManager text.
class AppTextStyles {
  /// Large display token for rare high-emphasis headings.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    height: 1.1,
  );

  /// Medium display token for page-level headings.
  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    height: 1.15,
  );

  /// Large heading token for screen titles.
  static const TextStyle headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.2,
  );

  /// Medium heading token for sections.
  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.25,
  );

  /// Small heading token for cards and compact headers.
  static const TextStyle headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
  );

  /// Large body token for primary content.
  static const TextStyle bodyLargeToken = TextStyle(
    fontSize: 15,
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
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
  );

  /// Caption token for minor metadata.
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    height: 1.4,
  );

  /// Button text token for command surfaces.
  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1,
  );

  /// Monospace token for technical data and identifiers.
  static const TextStyle monospace = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    height: 1.5,
  );

  static TextStyle _baseStyle(
    double fontSize,
    FontWeight weight,
    Color color, {
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Headers
  static TextStyle h1(BuildContext context) => _baseStyle(
    28,
    FontWeight.w700,
    Theme.of(context).colorScheme.onSurface,
    letterSpacing: -0.6,
  );

  static TextStyle h2(BuildContext context) => _baseStyle(
    24,
    FontWeight.w700,
    Theme.of(context).colorScheme.onSurface,
    letterSpacing: -0.3,
  );

  static TextStyle h3(BuildContext context) => _baseStyle(
    22,
    FontWeight.w700,
    Theme.of(context).colorScheme.onSurface,
    letterSpacing: -0.3,
  );

  static TextStyle h4(BuildContext context) => _baseStyle(
    20,
    FontWeight.w600,
    Theme.of(context).colorScheme.onSurface,
    letterSpacing: -0.2,
  );

  // Body text
  static TextStyle bodyLarge(BuildContext context) => _baseStyle(
    15,
    FontWeight.normal,
    Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle bodyMedium(BuildContext context) => _baseStyle(
    14,
    FontWeight.normal,
    Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle bodySmall(BuildContext context) => _baseStyle(
    12,
    FontWeight.normal,
    Theme.of(context).colorScheme.onSurfaceVariant,
  );

  // Special styles
  static TextStyle label(BuildContext context) => _baseStyle(
    14,
    FontWeight.w500,
    Theme.of(context).colorScheme.onSurfaceVariant,
    letterSpacing: -0.1,
  );

  static TextStyle button(BuildContext context) => _baseStyle(
    15,
    FontWeight.w600,
    Theme.of(context).colorScheme.onSurface,
    letterSpacing: -0.1,
  );

  /// Overline style for section headers: 11px, uppercase, letter-spaced.
  static TextStyle overline(BuildContext context) => _baseStyle(
    11,
    FontWeight.w600,
    Theme.of(context).colorScheme.onSurfaceVariant,
    letterSpacing: 1.2,
  );

  /// Muted body for secondary text.
  static TextStyle muted(BuildContext context) => _baseStyle(
    13,
    FontWeight.w500,
    Theme.of(context).colorScheme.onSurfaceVariant,
  );

  /// Faint body for tertiary text.
  static TextStyle faint(BuildContext context) => _baseStyle(
    12,
    FontWeight.w400,
    Theme.of(context).colorScheme.onSurfaceVariant,
  );
}
