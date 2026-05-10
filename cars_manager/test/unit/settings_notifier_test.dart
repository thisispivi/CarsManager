import 'dart:io';

import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // Mock path_provider so saveCarData doesn't crash in unit tests
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => Directory.systemTemp.path,
        );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          null,
        );
  });

  test('appSettings has default values', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final settings = container.read(appSettingsProvider);
    expect(settings.currency, 'EUR');
    expect(settings.units, 'metric');
    expect(settings.notificationsEnabled, isTrue);
    expect(settings.themeMode, ThemeMode.dark);
  });

  test('SettingsController.toggleThemeMode switches theme', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final initialMode = container.read(appSettingsProvider).themeMode;
    container.read(settingsControllerProvider.notifier).toggleThemeMode();
    await Future<void>.delayed(Duration.zero);

    final newMode = container.read(appSettingsProvider).themeMode;
    expect(newMode, isNot(initialMode));
  });

  test('SettingsController.setLocale updates locale', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(settingsControllerProvider.notifier)
        .setLocale(const Locale('it'));
    await Future<void>.delayed(Duration.zero);

    expect(container.read(appSettingsProvider).locale, const Locale('it'));
  });

  test('SettingsController.setCurrency updates currency', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(settingsControllerProvider.notifier).setCurrency('USD');
    await Future<void>.delayed(Duration.zero);

    expect(container.read(appSettingsProvider).currency, 'USD');
  });

  test('SettingsController.setNotificationsEnabled toggles flag', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(settingsControllerProvider.notifier)
        .setNotificationsEnabled(false);
    await Future<void>.delayed(Duration.zero);

    expect(container.read(appSettingsProvider).notificationsEnabled, isFalse);
  });
}
