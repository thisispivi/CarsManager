import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.brandPrimary,
    required this.brandSecondary,
    required this.brandGradientStart,
    required this.brandGradientEnd,
    required this.brandAccent,
    required this.brandSubtle,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceElevated,
    required this.surfaceOverlay,
    required this.borderDefault,
    required this.borderSubtle,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textInverse,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  final Color brandPrimary;
  final Color brandSecondary;
  final Color brandGradientStart;
  final Color brandGradientEnd;
  final Color brandAccent;
  final Color brandSubtle;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceElevated;
  final Color surfaceOverlay;
  final Color borderDefault;
  final Color borderSubtle;
  final Color borderStrong;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textInverse;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  LinearGradient get brandGradient =>
      LinearGradient(colors: [brandGradientStart, brandGradientEnd]);

  @override
  AppColorScheme copyWith({
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandGradientStart,
    Color? brandGradientEnd,
    Color? brandAccent,
    Color? brandSubtle,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceElevated,
    Color? surfaceOverlay,
    Color? borderDefault,
    Color? borderSubtle,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textInverse,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
  }) {
    return AppColorScheme(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandGradientStart: brandGradientStart ?? this.brandGradientStart,
      brandGradientEnd: brandGradientEnd ?? this.brandGradientEnd,
      brandAccent: brandAccent ?? this.brandAccent,
      brandSubtle: brandSubtle ?? this.brandSubtle,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textInverse: textInverse ?? this.textInverse,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandSecondary: Color.lerp(brandSecondary, other.brandSecondary, t)!,
      brandGradientStart: Color.lerp(
        brandGradientStart,
        other.brandGradientStart,
        t,
      )!,
      brandGradientEnd: Color.lerp(
        brandGradientEnd,
        other.brandGradientEnd,
        t,
      )!,
      brandAccent: Color.lerp(brandAccent, other.brandAccent, t)!,
      brandSubtle: Color.lerp(brandSubtle, other.brandSubtle, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
