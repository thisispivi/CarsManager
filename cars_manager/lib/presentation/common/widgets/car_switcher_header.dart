import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/main.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarSwitcherHeader extends StatefulWidget {
  const CarSwitcherHeader({super.key});

  @override
  State<CarSwitcherHeader> createState() => _CarSwitcherHeaderState();
}

class _CarSwitcherHeaderState extends State<CarSwitcherHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _openCarSwitcher(
    BuildContext context,
    List<Car> cars,
    String? activeCarId,
  ) {
    _rotationController.forward();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Switch Car',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...cars.map(
                (car) => ListTile(
                  leading: _buildCarAvatar(car, context),
                  title: Text(
                    car.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${car.manufacture} ${car.model} • ${car.yearOfManufacture}',
                    style: GoogleFonts.spaceGrotesk(fontSize: 12),
                  ),
                  trailing: car.id == activeCarId
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    context.read<CarsManagerState>().setActiveCar(car.id);
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    ).whenComplete(() => _rotationController.reverse());
  }

  Widget _buildCarAvatar(Car car, BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      backgroundImage: (car.imageBase64 != null && car.imageBase64!.isNotEmpty)
          ? MemoryImage(
              Uri.parse(
                'data:image/png;base64,${car.imageBase64}',
              ).data!.contentAsBytes(),
            )
          : (car.imageUrl != null && car.imageUrl!.isNotEmpty)
          ? NetworkImage(car.imageUrl!)
          : null,
      child:
          (car.imageBase64 == null || car.imageBase64!.isEmpty) &&
              (car.imageUrl == null || car.imageUrl!.isEmpty)
          ? Icon(
              Icons.directions_car,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CarsManagerState>();
    final activeCar = state.activeCar;

    if (activeCar == null) {
      return Text(
        AppLocalizations.of(context)?.appTitle ?? 'Cars Manager',
        style: GoogleFonts.spaceGrotesk(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    return InkWell(
      onTap: () => _openCarSwitcher(context, state.cars, state.activeCarId),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCarAvatar(activeCar, context),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeCar.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${activeCar.manufacture} ${activeCar.model} • ${activeCar.yearOfManufacture}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(
                CurvedAnimation(
                  parent: _rotationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
