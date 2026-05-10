// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fuelEntriesHash() => r'f6ea67f8a19dd067769dc1f9cfdfb9b41d59af32';

/// See also [fuelEntries].
@ProviderFor(fuelEntries)
final fuelEntriesProvider = AutoDisposeProvider<List<FuelEntry>>.internal(
  fuelEntries,
  name: r'fuelEntriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fuelEntriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FuelEntriesRef = AutoDisposeProviderRef<List<FuelEntry>>;
String _$fuelControllerHash() => r'32fc507524fe3924b184bb44d9a4df57f19671ef';

/// See also [FuelController].
@ProviderFor(FuelController)
final fuelControllerProvider =
    AutoDisposeNotifierProvider<FuelController, List<FuelEntry>>.internal(
      FuelController.new,
      name: r'fuelControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fuelControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FuelController = AutoDisposeNotifier<List<FuelEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
