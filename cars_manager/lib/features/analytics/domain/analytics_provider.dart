import 'package:cars_manager/app/state/cars_manager_provider.dart';
import 'package:cars_manager/features/analytics/data/models/active_car_analytics.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_provider.g.dart';

@riverpod
ActiveCarAnalytics activeCarAnalytics(Ref ref) {
  final state = ref.watch(carsManagerStateProvider);
  final car = state.activeCar;

  return ActiveCarAnalytics(
    totalExpenses: car?.totalPaidExpenses ?? 0,
    fuelEntryCount: car?.fuel.length ?? 0,
    vehicleName: car?.name,
  );
}
