import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Material theme factory for CarsManager.
class AppTheme {
  /// Builds the dark theme using the Warm Cream dark palette.
  static ThemeData getDarkTheme() {
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    );

    return _buildTheme(
      brightness: Brightness.dark,
      textTheme: textTheme,
      bg: AppColors.bgDark,
      surface: AppColors.surfaceDark,
      surface2: AppColors.surface2Dark,
      border: AppColors.borderDark,
      borderStrong: AppColors.borderStrongDark,
      primaryText: AppColors.textDark,
      mutedText: AppColors.textMutedDark,
      faintText: AppColors.textFaintDark,
      accent: AppColors.accentDark,
      accentInk: AppColors.accentInkDark,
      success: AppColors.successDark,
      warn: AppColors.warnDark,
      danger: AppColors.dangerDark,
      chipBg: AppColors.chipBgDark,
    );
  }

  /// Builds the light theme using the Warm Cream light palette.
  static ThemeData getLightTheme() {
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    );

    return _buildTheme(
      brightness: Brightness.light,
      textTheme: textTheme,
      bg: AppColors.bgLight,
      surface: AppColors.surfaceLight,
      surface2: AppColors.surface2Light,
      border: AppColors.borderLight,
      borderStrong: AppColors.borderStrongLight,
      primaryText: AppColors.textLight,
      mutedText: AppColors.textMutedLight,
      faintText: AppColors.textFaintLight,
      accent: AppColors.accentLight,
      accentInk: AppColors.accentInkLight,
      success: AppColors.successLight,
      warn: AppColors.warnLight,
      danger: AppColors.dangerLight,
      chipBg: AppColors.chipBgLight,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required TextTheme textTheme,
    required Color bg,
    required Color surface,
    required Color surface2,
    required Color border,
    required Color borderStrong,
    required Color primaryText,
    required Color mutedText,
    required Color faintText,
    required Color accent,
    required Color accentInk,
    required Color success,
    required Color warn,
    required Color danger,
    required Color chipBg,
  }) {
    final isDark = brightness == Brightness.dark;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: border, width: 0.5),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [
        AppColorScheme(
          accent: accent,
          accentInk: accentInk,
          bg: bg,
          surface2: surface2,
          chipBg: chipBg,
          surfacePrimary: surface,
          surfaceElevated: surface,
          surfaceOverlay: surface.withValues(alpha: 0.95),
          borderDefault: border,
          borderSubtle: isDark ? AppColors.bgDark : AppColors.surface2Light,
          borderStrong: borderStrong,
          textPrimary: primaryText,
          textMuted: mutedText,
          textFaint: faintText,
          success: success,
          warning: warn,
          danger: danger,
        ),
      ],
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface2,
        floatingLabelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: accent,
        ),
        labelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: mutedText,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: mutedText,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: danger),
        helperStyle: textTheme.bodySmall?.copyWith(color: mutedText),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: danger, width: 0.5),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: danger, width: 1.5),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: accentInk,
        primaryContainer: accent.withValues(alpha: 0.12),
        onPrimaryContainer: accent,
        secondary: accent,
        onSecondary: accentInk,
        secondaryContainer: accent.withValues(alpha: 0.10),
        onSecondaryContainer: accent,
        tertiary: surface2,
        onTertiary: primaryText,
        tertiaryContainer: surface2,
        onTertiaryContainer: primaryText,
        error: danger,
        onError: accentInk,
        errorContainer: danger.withValues(alpha: 0.12),
        onErrorContainer: danger,
        surface: surface,
        onSurface: primaryText,
        surfaceContainerHighest: surface2,
        onSurfaceVariant: mutedText,
        outline: border,
        outlineVariant: border,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: isDark ? AppColors.surfaceLight : AppColors.bgDark,
        onInverseSurface: isDark ? AppColors.textLight : AppColors.textDark,
        inversePrimary: isDark ? AppColors.accentLight : AppColors.accentDark,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? accent : mutedText,
            size: 22,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
            color: states.contains(WidgetState.selected) ? accent : mutedText,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        selectedIconTheme: IconThemeData(color: accent),
        unselectedIconTheme: IconThemeData(color: mutedText),
        selectedLabelTextStyle: GoogleFonts.inter(
          color: accent,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          color: mutedText,
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: accent.withValues(alpha: 0.10),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: accentInk,
        shape: const CircleBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: accentInk,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: border, width: 0.5),
        ),
      ),
      cardColor: surface,
      dividerColor: border,
      dividerTheme: DividerThemeData(color: border, thickness: 0.5, space: 0),
      scaffoldBackgroundColor: bg,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
        iconTheme: IconThemeData(color: primaryText),
        titleTextStyle: GoogleFonts.inter(
          color: primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: accent,
        unselectedItemColor: mutedText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
