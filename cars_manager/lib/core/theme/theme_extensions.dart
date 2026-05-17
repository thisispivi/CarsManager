import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.accent,
    required this.accentInk,
    required this.bg,
    required this.surface2,
    required this.chipBg,
    required this.surfacePrimary,
    required this.surfaceElevated,
    required this.surfaceOverlay,
    required this.borderDefault,
    required this.borderSubtle,
    required this.borderStrong,
    required this.textPrimary,
    required this.textMuted,
    required this.textFaint,
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color accent;
  final Color accentInk;
  final Color bg;
  final Color surface2;
  final Color chipBg;
  final Color surfacePrimary;
  final Color surfaceElevated;
  final Color surfaceOverlay;
  final Color borderDefault;
  final Color borderSubtle;
  final Color borderStrong;
  final Color textPrimary;
  final Color textMuted;
  final Color textFaint;
  final Color success;
  final Color warning;
  final Color danger;

  @override
  AppColorScheme copyWith({
    Color? accent,
    Color? accentInk,
    Color? bg,
    Color? surface2,
    Color? chipBg,
    Color? surfacePrimary,
    Color? surfaceElevated,
    Color? surfaceOverlay,
    Color? borderDefault,
    Color? borderSubtle,
    Color? borderStrong,
    Color? textPrimary,
    Color? textMuted,
    Color? textFaint,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return AppColorScheme(
      accent: accent ?? this.accent,
      accentInk: accentInk ?? this.accentInk,
      bg: bg ?? this.bg,
      surface2: surface2 ?? this.surface2,
      chipBg: chipBg ?? this.chipBg,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textFaint: textFaint ?? this.textFaint,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      accent: Color.lerp(accent, other.accent, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      chipBg: Color.lerp(chipBg, other.chipBg, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textFaint: Color.lerp(textFaint, other.textFaint, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
