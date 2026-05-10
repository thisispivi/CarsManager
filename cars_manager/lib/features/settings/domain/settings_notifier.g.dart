// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsHash() => r'64c8da09bbbff02b0d949fa42c98f8de3d761b5d';

/// See also [appSettings].
@ProviderFor(appSettings)
final appSettingsProvider = AutoDisposeProvider<AppSettingsState>.internal(
  appSettings,
  name: r'appSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppSettingsRef = AutoDisposeProviderRef<AppSettingsState>;
String _$settingsControllerHash() =>
    r'97953fd2ee6e42d5da37fae54b2c2e1aebc94ad7';

/// See also [SettingsController].
@ProviderFor(SettingsController)
final settingsControllerProvider =
    AutoDisposeNotifierProvider<SettingsController, AppSettingsState>.internal(
      SettingsController.new,
      name: r'settingsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SettingsController = AutoDisposeNotifier<AppSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
