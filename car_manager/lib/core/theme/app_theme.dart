import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surfaceDark,
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
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        surface: AppColors.surfaceLight,
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
