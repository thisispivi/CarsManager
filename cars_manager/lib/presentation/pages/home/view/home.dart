import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/home/view/widgets/car_tile.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:cars_manager/shared/widgets/vehicle_visual_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarsHomePage extends ConsumerWidget {
  const CarsHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cars = ref.watch(carsControllerProvider);
    final activeCarId = ref.watch(activeCarControllerProvider);
    final activeCar = cars.where((car) => car.id == activeCarId).firstOrNull;

    Future<void> openAddForm() async {
      final created = await Navigator.of(
        context,
      ).push<Car>(MaterialPageRoute(builder: (_) => const CarFormPage()));
      if (created == null || !context.mounted) return;
      ref.read(carsControllerProvider.notifier).add(created);
      context.go('/car/${created.id}');
    }

    Widget buildTile(Car car) {
      final isActive = activeCarId == car.id;
      return RepaintBoundary(
        child: CarTile(
          car: car,
          isActive: isActive,
          onSelect: () {
            ref.read(activeCarControllerProvider.notifier).select(car.id);
            context.push('/car/${car.id}');
          },
          onEdit: () async {
            final updated = await Navigator.of(context).push<Car>(
              MaterialPageRoute(builder: (_) => CarFormPage(initialCar: car)),
            );
            if (updated == null) return;
            ref.read(carsControllerProvider.notifier).update(updated);
          },
          onDelete: () async {
            final wasActive = activeCarId == car.id;
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(l10n.cars_removeConfirmTitle),
                  content: Text(l10n.cars_removeConfirmBody(car.name)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(l10n.common_cancel),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.dangerLight,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(l10n.common_delete),
                    ),
                  ],
                );
              },
            );
            if (confirm != true) return;

            ref.read(carsControllerProvider.notifier).remove(car.id);

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
              AppSnackBar.show(context, l10n.cars_activeRemoved);
            }
          },
        ),
      );
    }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isWide = width >= 900;
          final crossAxisCount = width >= 1180 ? 3 : (width >= 720 ? 2 : 1);
          final horizontalPadding = isWide ? AppSpacing.xxl : AppSpacing.lg;
          final contentMaxWidth = width >= 1600 ? 1400.0 : double.infinity;

          // Active car is shown in the header — exclude it from the list below.
          final otherCars = cars.where((car) => car.id != activeCarId).toList();

          if (cars.isEmpty) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: EmptyState(
                    icon: Icons.directions_car_filled_outlined,
                    title: 'Your garage is empty',
                    subtitle: l10n.cars_emptyState,
                    actionLabel: l10n.common_add,
                    onAction: openAddForm,
                  ),
                ),
              ),
            );
          }

          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          AppSpacing.xl,
                          horizontalPadding,
                          AppSpacing.lg,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _GarageHeader(
                            carsCount: cars.length,
                            activeCar: activeCar ?? cars.first,
                            onAddCar: openAddForm,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          0,
                          horizontalPadding,
                          AppSpacing.xl,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _GarageStats(cars: cars),
                        ),
                      ),
                      if (otherCars.isNotEmpty)
                        if (crossAxisCount == 1)
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              0,
                              horizontalPadding,
                              AppSpacing.xxxl,
                            ),
                            sliver: SliverList.separated(
                              itemCount: otherCars.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: AppSpacing.lg),
                              itemBuilder: (context, index) =>
                                  buildTile(otherCars[index]),
                            ),
                          )
                        else
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              0,
                              horizontalPadding,
                              AppSpacing.xxxl,
                            ),
                            sliver: SliverGrid.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: AppSpacing.lg,
                                    mainAxisSpacing: AppSpacing.lg,
                                    childAspectRatio: 0.9,
                                  ),
                              itemCount: otherCars.length,
                              itemBuilder: (context, index) =>
                                  buildTile(otherCars[index]),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              if (!isWide)
                Positioned(
                  right: AppSpacing.lg,
                  bottom: AppSpacing.lg,
                  child: FloatingActionButton(
                    tooltip: l10n.common_add,
                    onPressed: openAddForm,
                    child: const Icon(Icons.add_rounded),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _GarageHeader extends StatelessWidget {
  const _GarageHeader({
    required this.carsCount,
    required this.activeCar,
    required this.onAddCar,
  });

  final int carsCount;
  final Car activeCar;
  final VoidCallback onAddCar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        (activeCar.imageBase64 != null && activeCar.imageBase64!.isNotEmpty) ||
        (activeCar.imageUrl != null && activeCar.imageUrl!.isNotEmpty);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 820;

        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Garage',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
                height: 1.1,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$carsCount ${carsCount == 1 ? 'vehicle' : 'vehicles'} tracked with health, fuel, and cost history.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

        final action = InkWell(
          borderRadius: BorderRadius.circular(21),
          onTap: onAddCar,
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.accentLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isWide)
              Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(width: AppSpacing.lg),
                  action,
                ],
              )
            else ...[
              title,
              const SizedBox(height: AppSpacing.lg),
            ],
            const SizedBox(height: AppSpacing.xl),
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              onTap: () => context.push('/car/${activeCar.id}'),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                    color: theme.colorScheme.outline,
                    width: 0.5,
                  ),
                  boxShadow: theme.brightness == Brightness.light
                      ? AppShadows.brandGlow(theme.colorScheme.primary)
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: isWide
                      ? Row(
                          children: [
                            SizedBox(
                              width: 260,
                              child: _ActiveCarImage(
                                car: activeCar,
                                hasImage: hasImage,
                              ),
                            ),
                            Expanded(child: _ActiveCarCopy(car: activeCar)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _ActiveCarImage(car: activeCar, hasImage: hasImage),
                            _ActiveCarCopy(car: activeCar),
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ActiveCarImage extends StatelessWidget {
  const _ActiveCarImage({required this.car, required this.hasImage});

  final Car car;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: hasImage
          ? ImageRect(
              aspectRatio: 16 / 9,
              imageUrl: car.imageUrl,
              imageBase64: car.imageBase64,
              imageAlignment: car.imageAlignment,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.zero,
              primaryColor: AppColors.accentLight,
            )
          : VehicleVisualCard(car: car, borderRadius: 0),
    );
  }
}

class _ActiveCarCopy extends StatelessWidget {
  const _ActiveCarCopy({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Active vehicle',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            car.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${car.manufacture} ${car.model} • ${car.yearOfManufacture}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Builder(
            builder: (context) {
              int urgency(int? d) => d == null ? 9999 : (d < 0 ? -9999 : d);
              final chips = [
                ('Insurance', car.daysUntilNextInsuranceExpiration),
                ('Inspection', car.daysUntilNextInspection),
                ('Tax', car.daysUntilNextTaxDue),
              ]..sort((a, b) => urgency(a.$2).compareTo(urgency(b.$2)));
              return Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final c in chips) _StatusChip(label: c.$1, days: c.$2),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GarageStats extends StatelessWidget {
  const _GarageStats({required this.cars});

  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    final upcoming = cars
        .expand(
          (car) => [
            car.daysUntilNextInsuranceExpiration,
            car.daysUntilNextInspection,
            car.daysUntilNextTaxDue,
          ],
        )
        .where((days) => days != null && days <= 30)
        .length;
    final fuelEntries = cars.fold<int>(0, (sum, car) => sum + car.fuel.length);
    final totalEvents = cars.fold<int>(
      0,
      (sum, car) =>
          sum +
          car.insuranceDatas.length +
          car.inspectionDatas.length +
          car.taxDatas.length +
          car.repairDatas.length +
          car.fineDatas.length,
    );

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        _StatPill(
          icon: Icons.notifications_active_rounded,
          label: 'Due soon',
          value: '$upcoming',
          color: upcoming == 0 ? AppColors.successLight : AppColors.warnLight,
        ),
        _StatPill(
          icon: Icons.local_gas_station_rounded,
          label: 'Fuel entries',
          value: '$fuelEntries',
          color: AppColors.successLight,
        ),
        _StatPill(
          icon: Icons.receipt_long_rounded,
          label: 'Expense events',
          value: '$totalEvents',
          color: AppColors.accentLight,
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: theme.colorScheme.outline, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Text(
            value,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.days});

  final String label;
  final int? days;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(days);
    final text = days == null
        ? 'No data'
        : days! < 0
        ? 'Overdue'
        : '$days d';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        '$label • $text',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Color _statusColor(int? days) {
  if (days == null) return AppColors.categoryInspection;
  if (days < 0) return AppColors.dangerLight;
  if (days <= 30) return AppColors.warnLight;
  return AppColors.successLight;
}
