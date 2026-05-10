import 'package:cars_manager/app/state/cars_manager_provider.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fuel_notifier.g.dart';

@riverpod
List<FuelEntry> fuelEntries(Ref ref) {
  return ref.watch(carsManagerStateProvider).activeCar?.fuel ??
      const <FuelEntry>[];
}

@riverpod
class FuelController extends _$FuelController {
  @override
  List<FuelEntry> build() {
    return ref.watch(fuelEntriesProvider);
  }

  void add(FuelEntry entry) {
    ref.read(carsManagerStateProvider).addFuelEntry(entry);
  }

  void update({required FuelEntry oldEntry, required FuelEntry entry}) {
    ref
        .read(carsManagerStateProvider)
        .updateFuelEntry(oldEntry: oldEntry, entry: entry);
  }

  void remove(FuelEntry entry) {
    ref.read(carsManagerStateProvider).removeFuelEntry(entry);
  }
}
