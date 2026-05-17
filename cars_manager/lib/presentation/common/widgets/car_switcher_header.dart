import 'dart:convert';
import 'dart:typed_data';

import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the car-switcher bottom sheet from any screen.
///
/// Used by the Home screen's "Switch ›" button so the same sheet
/// that was previously in the app-bar is accessible in-content.
void showCarSwitcherSheet(BuildContext context, WidgetRef ref) {
  final cars = ref.read(carsControllerProvider);
  final activeCarId = ref.read(activeCarControllerProvider);
  final l10n = AppLocalizations.of(context)!;
  final textTheme = Theme.of(context).textTheme;

  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return Consumer(
        builder: (_, ref, _) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.nav_switchCar,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ...cars.map(
                  (car) => ListTile(
                    leading: _buildCarAvatarStatic(car, sheetContext),
                    title: Text(
                      car.name,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${car.manufacture} ${car.model} • ${car.yearOfManufacture}',
                      style: textTheme.bodySmall,
                    ),
                    trailing: car.id == activeCarId
                        ? Icon(
                            Icons.check,
                            color: Theme.of(sheetContext).colorScheme.primary,
                          )
                        : null,
                    onTap: () {
                      ref
                          .read(activeCarControllerProvider.notifier)
                          .select(car.id);
                      Navigator.pop(sheetContext);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}

CircleAvatar _buildCarAvatarStatic(Car car, BuildContext context) {
  ImageProvider? imageProvider;
  final b64 = car.imageBase64;
  if (b64 != null && b64.trim().isNotEmpty) {
    try {
      imageProvider = MemoryImage(base64Decode(b64));
    } on FormatException {
      imageProvider = null;
    }
  } else {
    final url = car.imageUrl;
    if (url != null && url.trim().isNotEmpty) {
      imageProvider = NetworkImage(url);
    }
  }

  return CircleAvatar(
    radius: 20,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    backgroundImage: imageProvider,
    child: imageProvider == null
        ? Icon(
            Icons.directions_car,
            color: Theme.of(context).colorScheme.primary,
          )
        : null,
  );
}

class CarSwitcherHeader extends ConsumerStatefulWidget {
  const CarSwitcherHeader({super.key});

  @override
  ConsumerState<CarSwitcherHeader> createState() => _CarSwitcherHeaderState();
}

class _CarSwitcherHeaderState extends ConsumerState<CarSwitcherHeader>
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
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
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
                  l10n.nav_switchCar,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ...cars.map(
                (car) => ListTile(
                  leading: _buildCarAvatar(car, context),
                  title: Text(
                    car.name,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${car.manufacture} ${car.model} • ${car.yearOfManufacture}',
                    style: textTheme.bodySmall,
                  ),
                  trailing: car.id == activeCarId
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    ref
                        .read(activeCarControllerProvider.notifier)
                        .select(car.id);
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
    final imageProvider = _imageProviderFor(car);

    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Icon(
              Icons.directions_car,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
    );
  }

  ImageProvider? _imageProviderFor(Car car) {
    final b64 = car.imageBase64;
    if (b64 != null && b64.trim().isNotEmpty) {
      final bytes = _tryDecodeBase64(b64);
      if (bytes != null) return MemoryImage(bytes);
    }

    final imageUrl = car.imageUrl;
    if (imageUrl != null && imageUrl.trim().isNotEmpty) {
      return NetworkImage(imageUrl);
    }

    return null;
  }

  Uint8List? _tryDecodeBase64(String value) {
    try {
      return base64Decode(value);
    } on FormatException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeCar = ref.watch(activeCarProvider);
    final cars = ref.watch(carsControllerProvider);
    final activeCarId = ref.watch(activeCarControllerProvider);
    final textTheme = Theme.of(context).textTheme;

    if (activeCar == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/CarsManagerLogo.png', height: 28),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)?.appTitle ?? 'CarsManager',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () => _openCarSwitcher(context, cars, activeCarId),
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
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${activeCar.manufacture} ${activeCar.model} • ${activeCar.yearOfManufacture}',
                    style: textTheme.bodySmall?.copyWith(
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
