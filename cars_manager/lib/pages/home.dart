import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarsHomePage extends StatelessWidget {
  const CarsHomePage({super.key});

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
            ).push(MaterialPageRoute(builder: (_) => const CarDashboardPage()));
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
                  child: Text(
                    l10n.cars_emptyState,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
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

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: crossAxisCount == 1 ? 1.35 : 1.15,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    final isActive = state.activeCarId == car.id;
                    return _CarTile(
                      car: car,
                      isActive: isActive,
                      onSelect: () {
                        state.setActiveCar(car.id);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CarDashboardPage(),
                          ),
                        );
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

class _CarTile extends StatelessWidget {
  final Car car;
  final bool isActive;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CarTile({
    required this.car,
    required this.isActive,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 6 : 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onSelect,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageRect(
                imageUrl: car.imageUrl,
                imageAlignment: car.imageAlignment,
                aspectRatio: 16 / 9,
                backgroundColor: Theme.of(
                  context,
                ).navigationBarTheme.backgroundColor!,
                borderRadius: BorderRadius.circular(10),
                primaryColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${car.manufacture} • ${car.model}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${car.yearOfManufacture} • ${car.licensePlate}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit();
                          break;
                        case 'remove':
                          onDelete();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(AppLocalizations.of(context)!.common_edit),
                      ),
                      PopupMenuItem(
                        value: 'remove',
                        child: Text(
                          AppLocalizations.of(context)!.common_delete,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
