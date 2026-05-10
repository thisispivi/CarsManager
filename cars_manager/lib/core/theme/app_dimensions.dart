import 'package:flutter/material.dart';

class AppDimensions {
  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;

  // Padding
  static const double paddingSmall = 8.0;
  static const double paddingDefault = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border radius
  static const double radiusSmall = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Icon sizes
  static const double iconSmall = 16.0;
  static const double iconDefault = 24.0;
  static const double iconLarge = 32.0;

  // Card dimensions
  static const double cardElevation = 2.0;

  // App bar
  static const double appBarHeight = 88.0;

  // Bottom sheets / forms
  static const double bottomSheetHorizontalPadding = paddingLarge;
  static const double bottomSheetVerticalPadding = paddingDefault;
}

class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double pill = 999;
}

class AppShadows {
  static const xs = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
  ];

  static const sm = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const md = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const lg = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 32, offset: Offset(0, 8)),
  ];
}

class AppAnimations {
  static const durationFast = Duration(milliseconds: 150);
  static const durationNormal = Duration(milliseconds: 250);
  static const durationSlow = Duration(milliseconds: 400);

  static const curveDefault = Curves.easeOutCubic;
  static const curveSpring = Curves.elasticOut;
  static const curveDecelerate = Curves.decelerate;
}
