import 'dart:io';

import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Car _makeCar(String id, String name) => Car(
  id: id,
  name: name,
  model: 'X',
  manufacture: 'Brand',
  yearOfManufacture: 2020,
  insuranceExpirationDate: DateTime(2026),
);

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

  test('CarsController starts empty', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(carsControllerProvider), isEmpty);
  });

  test('CarsController.add appends a car', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(carsControllerProvider.notifier).add(_makeCar('1', 'Alice'));
    await Future<void>.delayed(Duration.zero);

    expect(container.read(carsControllerProvider).length, 1);
    expect(container.read(carsControllerProvider).first.name, 'Alice');
  });

  test('CarsController.add sets active car when setActive is true', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(carsControllerProvider.notifier).add(_makeCar('42', 'Bob'));
    await Future<void>.delayed(Duration.zero);

    expect(container.read(activeCarControllerProvider), '42');
  });

  test('CarsController.update replaces the car in the list', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final original = _makeCar('1', 'Before');
    container.read(carsControllerProvider.notifier).add(original);
    await Future<void>.delayed(Duration.zero);

    final updated = original.copyWith(name: 'After');
    container.read(carsControllerProvider.notifier).update(updated);
    await Future<void>.delayed(Duration.zero);

    expect(container.read(carsControllerProvider).first.name, 'After');
  });

  test('CarsController.remove deletes a car by id', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(carsControllerProvider.notifier).add(_makeCar('1', 'Car1'));
    container
        .read(carsControllerProvider.notifier)
        .add(_makeCar('2', 'Car2'), setActive: false);
    await Future<void>.delayed(Duration.zero);

    container.read(carsControllerProvider.notifier).remove('1');
    await Future<void>.delayed(Duration.zero);

    expect(container.read(carsControllerProvider).length, 1);
    expect(container.read(carsControllerProvider).first.id, '2');
  });
}
