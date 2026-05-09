import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/home/view/widgets/car_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';

class CarsHomePage extends StatelessWidget {
  const CarsHomePage({super.key});

  static Route<T> _noTransitionRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => page,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final created = await Navigator.of(
              context,
            ).push<Car>(MaterialPageRoute(builder: (_) => const CarFormPage()));
            if (created == null) return;
            if (!context.mounted) return;

            final state = context.read<CarsManagerState>();
            state.addCar(created, setActive: true);

            if (!context.mounted) return;
            Navigator.of(
              context,
            ).push(_noTransitionRoute(const CarDashboardPage()));
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<CarsManagerState>(
          builder: (context, state, child) {
            final cars = state.cars;
            if (cars.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyStateWidget(
                    message: l10n.cars_emptyState,
                    actionLabel: l10n.common_add,
                    icon: Icons.directions_car_outlined,
                    onAction: () async {
                      final created = await Navigator.of(context).push<Car>(
                        MaterialPageRoute(builder: (_) => const CarFormPage()),
                      );
                      if (created == null) return;
                      if (!context.mounted) return;

                      final state = context.read<CarsManagerState>();
                      state.addCar(created, setActive: true);

                      if (!context.mounted) return;
                      Navigator.of(
                        context,
                      ).push(_noTransitionRoute(const CarDashboardPage()));
                    },
                  ),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount = width >= 1000
                    ? 3
                    : (width >= 650 ? 2 : 1);

                Widget buildTile(Car car) {
                  final isActive = state.activeCarId == car.id;
                  return CarTile(
                    car: car,
                    isActive: isActive,
                    onSelect: () {
                      state.setActiveCar(car.id);
                      Navigator.of(
                        context,
                      ).push(_noTransitionRoute(const CarDashboardPage()));
                    },
                    onEdit: () async {
                      final updated = await Navigator.of(context).push<Car>(
                        MaterialPageRoute(
                          builder: (_) => CarFormPage(initialCar: car),
                        ),
                      );
                      if (updated == null) return;
                      state.updateCar(updated);
                    },
                    onDelete: () async {
                      final wasActive = state.activeCarId == car.id;
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(l10n.cars_removeConfirmTitle),
                            content: Text(
                              l10n.cars_removeConfirmBody(car.name),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(l10n.common_cancel),
                              ),
                              FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(l10n.common_delete),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm != true) return;

                      state.removeCar(car.id);

                      if (!context.mounted) return;
                      if (state.cars.isEmpty) {
                        await showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(l10n.cars_noCarsLeftTitle),
                            content: Text(l10n.cars_noCarsLeftBody),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(l10n.common_ok),
                              ),
                            ],
                          ),
                        );
                      } else if (wasActive) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.cars_activeRemoved)),
                        );
                      }
                    },
                  );
                }

                if (crossAxisCount == 1) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cars.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return buildTile(cars[index]);
                    },
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.12,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return buildTile(cars[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
