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

  void add(Car car, {bool setActive = true}) {
    ref.read(carsManagerStateProvider).addCar(car, setActive: setActive);
  }

  void update(Car car) {
    ref.read(carsManagerStateProvider).updateCar(car);
  }

  void remove(String id) {
    ref.read(carsManagerStateProvider).removeCar(id);
  }

  Future<void> resetAllData() async {
    await ref.read(carsManagerStateProvider).resetAllData();
  }
}
