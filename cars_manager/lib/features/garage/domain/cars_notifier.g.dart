// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$carsHash() => r'109e31091da6c2f19ccbc7db04725f45b67debe2';

/// See also [cars].
@ProviderFor(cars)
final carsProvider = AutoDisposeProvider<List<Car>>.internal(
  cars,
  name: r'carsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$carsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CarsRef = AutoDisposeProviderRef<List<Car>>;
String _$activeCarHash() => r'2403abb30c385c62cd7fbbd551239a5e22d1e938';

/// See also [activeCar].
@ProviderFor(activeCar)
final activeCarProvider = AutoDisposeProvider<Car?>.internal(
  activeCar,
  name: r'activeCarProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCarHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveCarRef = AutoDisposeProviderRef<Car?>;
String _$activeCarControllerHash() =>
    r'706bdf87f6d5471cfbf36e5d75c77106c9de7a38';

/// See also [ActiveCarController].
@ProviderFor(ActiveCarController)
final activeCarControllerProvider =
    AutoDisposeNotifierProvider<ActiveCarController, String?>.internal(
      ActiveCarController.new,
      name: r'activeCarControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeCarControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveCarController = AutoDisposeNotifier<String?>;
String _$carsControllerHash() => r'bc764141bd2b482b724ec4990856f06d4d3ee66d';

/// See also [CarsController].
@ProviderFor(CarsController)
final carsControllerProvider =
    AutoDisposeNotifierProvider<CarsController, List<Car>>.internal(
      CarsController.new,
      name: r'carsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$carsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CarsController = AutoDisposeNotifier<List<Car>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
