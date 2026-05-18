import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/home/view/widgets/car_tile.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
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

          final effectiveActive = activeCar ?? cars.firstOrNull;
          final otherCars = effectiveActive == null
              ? <Car>[]
              : (cars.where((c) => c.id != effectiveActive.id).toList()
                  ..sort((a, b) => a.name.compareTo(b.name)));

          if (cars.isEmpty) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: EmptyState(
                    icon: Icons.directions_car_filled_outlined,
                    title: l10n.garage_empty,
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
                      // ── Title row ──────────────────────────────────────
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          AppSpacing.xl,
                          horizontalPadding,
                          AppSpacing.lg,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _GarageTitleRow(
                            carsCount: cars.length,
                            onAddCar: isWide ? openAddForm : null,
                            l10n: l10n,
                          ),
                        ),
                      ),
                      // ── Stats pills ────────────────────────────────────
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          0,
                          horizontalPadding,
                          AppSpacing.xl,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _GarageStats(cars: cars, l10n: l10n),
                        ),
                      ),
                      if (effectiveActive != null) ...[
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            0,
                            horizontalPadding,
                            AppSpacing.md,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: _GarageSectionLabel(
                              title: l10n.garage_activeVehicle,
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
                            child: buildTile(effectiveActive),
                          ),
                        ),
                      ],
                      if (otherCars.isNotEmpty) ...[
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            0,
                            horizontalPadding,
                            AppSpacing.md,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: _GarageSectionLabel(
                              title: l10n.garage_otherVehicles,
                            ),
                          ),
                        ),
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
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: AppSpacing.lg),
                              itemBuilder: (_, i) => buildTile(otherCars[i]),
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
                                    childAspectRatio: 0.92,
                                  ),
                              itemCount: otherCars.length,
                              itemBuilder: (_, i) => buildTile(otherCars[i]),
                            ),
                          ),
                      ] else
                        const SliverToBoxAdapter(
                          child: SizedBox(height: AppSpacing.xxxl),
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

class _GarageSectionLabel extends StatelessWidget {
  const _GarageSectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

/// Title row showing "My Garage" heading with car count and optional add button.
class _GarageTitleRow extends StatelessWidget {
  const _GarageTitleRow({
    required this.carsCount,
    required this.l10n,
    this.onAddCar,
  });

  final int carsCount;
  final AppLocalizations l10n;
  final VoidCallback? onAddCar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.garage_title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.garage_subtitle(carsCount),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (onAddCar != null) ...[
          const SizedBox(width: AppSpacing.lg),
          Tooltip(
            message: l10n.common_add,
            child: InkWell(
              borderRadius: BorderRadius.circular(21),
              onTap: onAddCar,
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.accentLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Summary stats row — due-soon count, fuel entries, expense events.
/// Displayed at the very top of the garage for an immediate fleet overview.
class _GarageStats extends StatelessWidget {
  const _GarageStats({required this.cars, required this.l10n});

  final List<Car> cars;
  final AppLocalizations l10n;

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
          label: l10n.garage_dueSoon,
          value: '$upcoming',
          color: upcoming == 0 ? AppColors.successLight : AppColors.warnLight,
        ),
        _StatPill(
          icon: Icons.local_gas_station_rounded,
          label: l10n.garage_fuelEntries,
          value: '$fuelEntries',
          color: AppColors.successLight,
        ),
        _StatPill(
          icon: Icons.receipt_long_rounded,
          label: l10n.garage_expenseEvents,
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
