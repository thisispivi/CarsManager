import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';

class AppTheme {
  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w700,
        ),
        labelStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        hintStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500),
      ),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surfaceDark,
        surfaceContainerHighest: AppColors.surfaceContainerDark,
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        tertiary: AppColors.tertiaryDark,
        onSurfaceVariant: AppColors.onSurfaceVariantDark,
        error: AppColors.error,
        onTertiaryFixedVariant: AppColors.onTertiaryVariantDark,
        onSecondaryFixedVariant: AppColors.onSecondaryVariantDark,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.cardDark,
        indicatorColor: AppColors.cardDark,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      cardColor: AppColors.cardDark,
      dividerColor: AppColors.tertiaryDark,
      scaffoldBackgroundColor: AppColors.surfaceDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
        iconTheme: IconThemeData(color: AppColors.primaryDark),
        titleTextStyle: TextStyle(
          color: AppColors.primaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.secondaryDark,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        ThemeData(brightness: Brightness.light).textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w700,
        ),
        labelStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        hintStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500),
      ),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        surfaceContainerHighest: AppColors.surfaceContainerLight,
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        tertiary: AppColors.tertiaryLight,
        onSurfaceVariant: AppColors.onSurfaceVariantLight,
        error: AppColors.error,
        onTertiaryFixedVariant: AppColors.onTertiaryVariantLight,
        onSecondaryFixedVariant: AppColors.onSecondaryVariantLight,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.cardLight,
        indicatorColor: AppColors.cardLight,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      cardColor: AppColors.cardLight,
      dividerColor: AppColors.tertiaryLight,
      scaffoldBackgroundColor: AppColors.surfaceLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        toolbarHeight: AppDimensions.appBarHeight,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        titleTextStyle: TextStyle(
          color: AppColors.primaryLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.secondaryLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
