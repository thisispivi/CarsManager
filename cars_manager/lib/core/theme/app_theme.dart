import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Material theme factory for CarsManager.
class AppTheme {
  /// Builds the dark theme, wiring brand colors, typography, controls, and
  /// bordered card surfaces into Material 3 defaults.
  static ThemeData getDarkTheme() {
    final textTheme = GoogleFonts.spaceGroteskTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    );

    return _buildTheme(
      brightness: Brightness.dark,
      textTheme: textTheme,
      surface: AppColors.surfaceDark,
      surfaceAlt: AppColors.surfaceAltDark,
      surfaceContainer: AppColors.surfaceContainerDark,
      card: AppColors.cardDark,
      border: AppColors.borderDark,
      primaryText: AppColors.primaryDark,
      secondaryText: AppColors.secondaryDark,
      tertiary: AppColors.tertiaryDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
      onTertiaryVariant: AppColors.onTertiaryVariantDark,
      onSecondaryVariant: AppColors.onSecondaryVariantDark,
    );
  }

  /// Builds the light theme, wiring brand colors, typography, controls, and
  /// bordered card surfaces into Material 3 defaults.
  static ThemeData getLightTheme() {
    final textTheme = GoogleFonts.spaceGroteskTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    );

    return _buildTheme(
      brightness: Brightness.light,
      textTheme: textTheme,
      surface: AppColors.surfaceLight,
      surfaceAlt: AppColors.surfaceAlt,
      surfaceContainer: AppColors.surfaceContainerLight,
      card: AppColors.cardLight,
      border: AppColors.borderLight,
      primaryText: AppColors.primaryLight,
      secondaryText: AppColors.secondaryLight,
      tertiary: AppColors.tertiaryLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
      onTertiaryVariant: AppColors.onTertiaryVariantLight,
      onSecondaryVariant: AppColors.onSecondaryVariantLight,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required TextTheme textTheme,
    required Color surface,
    required Color surfaceAlt,
    required Color surfaceContainer,
    required Color card,
    required Color border,
    required Color primaryText,
    required Color secondaryText,
    required Color tertiary,
    required Color onSurfaceVariant,
    required Color onTertiaryVariant,
    required Color onSecondaryVariant,
  }) {
    final isDark = brightness == Brightness.dark;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [
        AppColorScheme(
          brandPrimary: AppColors.brandPrimary,
          brandSecondary: isDark
              ? const Color(0xFFBB7EF9)
              : AppColors.brandSecondary,
          brandGradientStart: AppColors.brandGradientStart,
          brandGradientEnd: AppColors.brandGradientEnd,
          brandAccent: isDark ? const Color(0xFFA78BFA) : AppColors.brandAccent,
          brandSubtle: isDark
              ? const Color(0xFF1A1240)
              : AppColors.tertiaryLight,
          surfacePrimary: surface,
          surfaceSecondary: surfaceAlt,
          surfaceElevated: card,
          surfaceOverlay: card.withValues(alpha: 0.95),
          borderDefault: border,
          borderSubtle: isDark
              ? const Color(0xFF1E2226)
              : const Color(0xFFF0F2F5),
          borderStrong: isDark
              ? const Color(0xFF3A4049)
              : const Color(0xFFCBD1D8),
          textPrimary: primaryText,
          textSecondary: secondaryText,
          textTertiary: isDark
              ? const Color(0xFF5A6370)
              : const Color(0xFF8B95A3),
          textInverse: isDark
              ? const Color(0xFF0D1117)
              : const Color(0xFFFFFFFF),
          success: isDark ? const Color(0xFF4DCF82) : AppColors.success,
          warning: isDark ? const Color(0xFFFFB84C) : AppColors.warning,
          danger: isDark ? const Color(0xFFFF5858) : AppColors.danger,
          info: isDark ? const Color(0xFF7B9FFF) : AppColors.info,
        ),
      ],
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceAlt,
        floatingLabelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.brandPrimary,
        ),
        labelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: onSurfaceVariant,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: secondaryText,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.error),
        helperStyle: textTheme.bodySmall?.copyWith(color: secondaryText),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(
            color: AppColors.brandPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.brandPrimary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.brandPrimary.withValues(alpha: 0.16),
        onPrimaryContainer: AppColors.brandPrimary,
        secondary: AppColors.brandSecondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.brandSecondary.withValues(alpha: 0.16),
        onSecondaryContainer: AppColors.brandSecondary,
        tertiary: tertiary,
        onTertiary: primaryText,
        tertiaryContainer: surfaceContainer,
        onTertiaryContainer: primaryText,
        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.error.withValues(alpha: 0.16),
        onErrorContainer: AppColors.error,
        surface: surface,
        onSurface: primaryText,
        surfaceContainerHighest: surfaceContainer,
        onSurfaceVariant: onSurfaceVariant,
        outline: border,
        outlineVariant: border,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: isDark ? AppColors.surfaceLight : AppColors.surfaceDark,
        onInverseSurface: isDark
            ? AppColors.primaryLight
            : AppColors.primaryDark,
        inversePrimary: AppColors.brandAccent,
        onTertiaryFixedVariant: onTertiaryVariant,
        onSecondaryFixedVariant: onSecondaryVariant,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: card,
        indicatorColor: AppColors.brandPrimary.withValues(alpha: 0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.brandPrimary
                : secondaryText,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.brandPrimary
                : secondaryText,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: card,
        selectedIconTheme: const IconThemeData(color: AppColors.brandPrimary),
        unselectedIconTheme: IconThemeData(color: secondaryText),
        selectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: AppColors.brandPrimary,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: secondaryText,
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: AppColors.brandPrimary.withValues(alpha: 0.15),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.brandPrimary,
        foregroundColor: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: border),
        ),
      ),
      cardColor: card,
      dividerColor: border,
      scaffoldBackgroundColor: surface,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
        iconTheme: IconThemeData(color: primaryText),
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.brandPrimary,
        unselectedItemColor: secondaryText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
