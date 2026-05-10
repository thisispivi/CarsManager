import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/home/view/widgets/car_tile.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarsHomePage extends ConsumerWidget {
  const CarsHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cars = ref.watch(carsControllerProvider);
    final activeCarId = ref.watch(activeCarControllerProvider);

    Future<void> openAddForm() async {
      final created = await Navigator.of(
        context,
      ).push<Car>(MaterialPageRoute(builder: (_) => const CarFormPage()));
      if (created == null) return;
      if (!context.mounted) return;
      ref.read(carsControllerProvider.notifier).add(created);
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openAddForm,
          child: const Icon(Icons.add),
        ),
        body: cars.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyStateWidget(
                    message: l10n.cars_emptyState,
                    actionLabel: l10n.common_add,
                    icon: Icons.directions_car_outlined,
                    onAction: openAddForm,
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final crossAxisCount = width >= 1000
                      ? 3
                      : (width >= 650 ? 2 : 1);

                  Widget buildTile(Car car) {
                    final isActive = activeCarId == car.id;
                    return CarTile(
                      car: car,
                      isActive: isActive,
                      onSelect: () {
                        ref
                            .read(activeCarControllerProvider.notifier)
                            .select(car.id);
                      },
                      onEdit: () async {
                        final updated = await Navigator.of(context).push<Car>(
                          MaterialPageRoute(
                            builder: (_) => CarFormPage(initialCar: car),
                          ),
                        );
                        if (updated == null) return;
                        ref
                            .read(carsControllerProvider.notifier)
                            .update(updated);
                      },
                      onDelete: () async {
                        final wasActive = activeCarId == car.id;
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

                        ref
                            .read(carsControllerProvider.notifier)
                            .remove(car.id);

                        if (!context.mounted) return;
                        final updatedCars = ref.read(carsControllerProvider);
                        if (updatedCars.isEmpty) {
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
              ),
      ),
    );
  }
}
