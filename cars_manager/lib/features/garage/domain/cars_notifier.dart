import 'package:cars_manager/app/state/cars_manager_provider.dart';
import 'package:cars_manager/models/car.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cars_notifier.g.dart';

@riverpod
List<Car> cars(Ref ref) {
  return ref.watch(carsManagerStateProvider).cars;
}

@riverpod
Car? activeCar(Ref ref) {
  return ref.watch(carsManagerStateProvider).activeCar;
}

@riverpod
class ActiveCarController extends _$ActiveCarController {
  @override
  String? build() {
    return ref.watch(carsManagerStateProvider).activeCarId;
  }

  /// Marks the car with [id] as the active car for detail tabs.
  void select(String id) {
    ref.read(carsManagerStateProvider).setActiveCar(id);
    state = id;
  }
}

@riverpod
class CarsController extends _$CarsController {
  @override
  List<Car> build() {
    return ref.watch(carsManagerStateProvider).cars;
  }

  /// Adds [car] to the garage and optionally makes it active.
  void add(Car car, {bool setActive = true}) {
    ref.read(carsManagerStateProvider).addCar(car, setActive: setActive);
  }

  /// Replaces an existing car with the updated [car] data.
  void update(Car car) {
    ref.read(carsManagerStateProvider).updateCar(car);
  }

  /// Removes the car identified by [id].
  void remove(String id) {
    ref.read(carsManagerStateProvider).removeCar(id);
  }

  /// Clears every saved car, entry, setting, and related app state.
  Future<void> resetAllData() async {
    await ref.read(carsManagerStateProvider).resetAllData();
  }
}
