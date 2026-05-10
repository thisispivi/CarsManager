import 'package:cars_manager/app/state/cars_manager_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'cars_manager_state.dart';

final carsManagerStateProvider = ChangeNotifierProvider<CarsManagerState>(
  (ref) => CarsManagerState(),
);
