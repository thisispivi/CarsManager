import 'package:cars_manager/app/state/cars_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

class AppSettingsState {
  const AppSettingsState({
    required this.locale,
    required this.themeMode,
    required this.notificationsEnabled,
    required this.units,
    required this.currency,
  });

  final Locale? locale;
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final String units;
  final String currency;
}

@riverpod
AppSettingsState appSettings(Ref ref) {
  final state = ref.watch(carsManagerStateProvider);
  return AppSettingsState(
    locale: state.locale,
    themeMode: state.themeMode,
    notificationsEnabled: state.notificationsEnabled,
    units: state.units,
    currency: state.currency,
  );
}

@riverpod
class SettingsController extends _$SettingsController {
  @override
  AppSettingsState build() {
    return ref.watch(appSettingsProvider);
  }

  void setLocale(Locale locale) {
    ref.read(carsManagerStateProvider).setLocale(locale);
  }

  void toggleThemeMode() {
    ref.read(carsManagerStateProvider).toggleThemeMode();
  }

  void setThemeMode(ThemeMode mode) {
    ref.read(carsManagerStateProvider).setThemeMode(mode);
  }

  void setNotificationsEnabled(bool enabled) {
    ref.read(carsManagerStateProvider).setNotificationsEnabled(enabled);
  }

  void setUnits(String units) {
    ref.read(carsManagerStateProvider).setUnits(units);
  }

  void setCurrency(String currency) {
    ref.read(carsManagerStateProvider).setCurrency(currency);
  }
}
