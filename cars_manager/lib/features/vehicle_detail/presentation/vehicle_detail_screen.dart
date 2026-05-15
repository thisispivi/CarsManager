import 'dart:math' as math;

import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({
    super.key,
    required this.carId,
    this.initialTabIndex = 0,
  });

  final String carId;
  final int initialTabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(carsControllerProvider);
    final car = cars.where((item) => item.id == carId).firstOrNull;
    final activeCarId = ref.watch(activeCarControllerProvider);
    final currency = ref.watch(appSettingsProvider).currency;

    if (car == null) {
      return SafeArea(
        child: EmptyState(
          icon: Icons.directions_car_outlined,
          title: 'Vehicle not found',
          subtitle: 'This car may have been removed from your garage.',
          actionLabel: 'Back to Garage',
          onAction: () => context.go('/garage'),
        ),
      );
    }

    if (activeCarId != car.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(activeCarControllerProvider.notifier).select(car.id);
      });
    }

    return DefaultTabController(
      key: ValueKey('vehicle-detail-$carId-$initialTabIndex'),
      length: 4,
      initialIndex: initialTabIndex,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 980;
            final header = _VehicleHeader(car: car);
            final tabs = _VehicleTabs(car: car, currency: currency);

            if (isWide) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 380, child: header),
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(child: tabs),
                  ],
                ),
              );
            }

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: header,
                  ),
                ),
              ],
              body: tabs,
            );
          },
        ),
      ),
    );
  }
}

class _VehicleHeader extends ConsumerWidget {
  const _VehicleHeader({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasImage =
        (car.imageBase64 != null && car.imageBase64!.isNotEmpty) ||
        (car.imageUrl != null && car.imageUrl!.isNotEmpty);

    Future<void> editCar() async {
      final updated = await Navigator.of(context).push<Car>(
        MaterialPageRoute(builder: (_) => CarFormPage(initialCar: car)),
      );
      if (updated == null) return;
      ref.read(carsControllerProvider.notifier).update(updated);
    }

    return _SurfaceCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (hasImage)
                    ImageRect(
                      aspectRatio: 16 / 9,
                      imageUrl: car.imageUrl,
                      imageBase64: car.imageBase64,
                      imageAlignment: car.imageAlignment,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.zero,
                      primaryColor: theme.colorScheme.primary,
                    )
                  else
                    Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.brandGradient,
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 84,
                      ),
                    ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xB0000000)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    top: AppSpacing.md,
                    child: _RoundIconButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: 'Back',
                      onTap: () => context.go('/garage'),
                    ),
                  ),
                  Positioned(
                    right: AppSpacing.md,
                    top: AppSpacing.md,
                    child: _RoundIconButton(
                      icon: Icons.edit_rounded,
                      tooltip: 'Edit vehicle',
                      onTap: editCar,
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    bottom: AppSpacing.lg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${car.manufacture} ${car.model} • ${car.yearOfManufacture}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.78),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _InfoPill(
                        icon: Icons.confirmation_number_outlined,
                        label: car.licensePlate.isEmpty
                            ? 'No plate'
                            : car.licensePlate,
                      ),
                      _InfoPill(
                        icon: Icons.local_gas_station_rounded,
                        label: car.fuelType?.name ?? 'Fuel not set',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _DueStatusRow(
                    label: 'Insurance',
                    days: car.daysUntilNextInsuranceExpiration,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _DueStatusRow(
                    label: 'Inspection',
                    days: car.daysUntilNextInspection,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _DueStatusRow(label: 'Tax', days: car.daysUntilNextTaxDue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleTabs extends StatelessWidget {
  const _VehicleTabs({required this.car, required this.currency});

  final Car car;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SurfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            labelColor: AppColors.brandPrimary,
            unselectedLabelColor: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant,
            onTap: (index) {
              final basePath = '/car/${car.id}';
              final paths = [
                basePath,
                '$basePath/fuel',
                '$basePath/expenses',
                '$basePath/timeline',
              ];
              context.go(paths[index]);
            },
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Fuel'),
              Tab(text: 'Expenses'),
              Tab(text: 'Timeline'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: TabBarView(
            children: [
              _OverviewTab(car: car, currency: currency),
              _FuelTab(car: car, currency: currency),
              _ExpensesTab(car: car, currency: currency),
              _TimelineTab(car: car, currency: currency),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.car, required this.currency});

  final Car car;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.simpleCurrency(name: currency);
    final total = car.totalFuelCost + car.totalPaidExpenses;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _MetricCard(
              icon: Icons.payments_rounded,
              label: 'Total tracked',
              value: money.format(total),
            ),
            _MetricCard(
              icon: Icons.local_gas_station_rounded,
              label: 'Fuel entries',
              value: '${car.fuel.length}',
            ),
            _MetricCard(
              icon: Icons.build_rounded,
              label: 'Service events',
              value: '${car.repairDatas.length + car.inspectionDatas.length}',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeading('Cost breakdown'),
              const SizedBox(height: AppSpacing.lg),
              _BreakdownBar(
                items: [
                  _BreakdownItem('Fuel', car.totalFuelCost, AppColors.success),
                  _BreakdownItem(
                    'Insurance',
                    car.totalPaidInsurances.toDouble(),
                    AppColors.info,
                  ),
                  _BreakdownItem(
                    'Tax',
                    car.totalPaidTaxes.toDouble(),
                    const Color(0xFF06B6D4),
                  ),
                  _BreakdownItem(
                    'Repairs',
                    car.totalPaidRepairs.toDouble(),
                    const Color(0xFF8B5CF6),
                  ),
                  _BreakdownItem(
                    'Fines',
                    car.totalPaidFines.toDouble(),
                    AppColors.danger,
                  ),
                ],
                currency: currency,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FuelTab extends ConsumerStatefulWidget {
  const _FuelTab({required this.car, required this.currency});

  final Car car;
  final String currency;

  @override
  ConsumerState<_FuelTab> createState() => _FuelTabState();
}

class _FuelTabState extends ConsumerState<_FuelTab> {
  _FuelPeriod _period = _FuelPeriod.oneYear;

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final money = NumberFormat.simpleCurrency(name: widget.currency);
    final cutoff = _period.cutoffDate(DateTime.now());
    final scopedEntries = car.fuel
        .where((entry) => cutoff == null || !entry.date.isBefore(cutoff))
        .toList();
    final liters = scopedEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.liters,
    );
    final fuelCost = scopedEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.totalCost,
    );
    final avgPrice = liters == 0 ? 0 : fuelCost / liters;
    final entries = [...scopedEntries]
      ..sort((a, b) => b.date.compareTo(a.date));

    Future<void> addFuelEntry() async {
      final entry = await showModalBottomSheet<FuelEntry>(
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            AddFuelEntryBottomSheet(lockedFuelType: car.fuelType),
      );
      if (entry == null) return;
      ref
          .read(carsControllerProvider.notifier)
          .update(car.copyWith(fuel: [...car.fuel, entry]));
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Fuel entry added')));
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _SurfaceCard(
          child: _PeriodSelector<_FuelPeriod>(
            value: _period,
            values: _FuelPeriod.values,
            labelFor: (period) => period.label,
            onChanged: (period) => setState(() => _period = period),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _MetricCard(
              icon: Icons.payments_rounded,
              label: 'Fuel spent',
              value: money.format(fuelCost),
            ),
            _MetricCard(
              icon: Icons.water_drop_rounded,
              label: 'Total liters',
              value: NumberFormat.decimalPattern().format(liters),
            ),
            _MetricCard(
              icon: Icons.speed_rounded,
              label: 'Avg price/L',
              value: money.format(avgPrice),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(
                'Fuel history (${_period.label})',
                actionLabel: 'Add fuel',
                onAction: addFuelEntry,
              ),
              const SizedBox(height: AppSpacing.md),
              if (entries.isEmpty)
                const _EmptyTabLine('No fuel entries yet.')
              else
                for (final entry in entries.take(8)) ...[
                  _DataRowLine(
                    icon: Icons.local_gas_station_rounded,
                    title: '${entry.liters.toStringAsFixed(1)} L',
                    subtitle: DateFormat.yMMMd().format(entry.date),
                    trailing: money.format(entry.totalCost),
                    color: AppColors.success,
                  ),
                  if (entry != entries.take(8).last) const Divider(height: 20),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpensesTab extends ConsumerStatefulWidget {
  const _ExpensesTab({required this.car, required this.currency});

  final Car car;
  final String currency;

  @override
  ConsumerState<_ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends ConsumerState<_ExpensesTab> {
  _ExpenseFilter _filter = _ExpenseFilter.all;

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final currency = widget.currency;

    Future<void> addExpense() async {
      final type = await showModalBottomSheet<PaymentEntryType>(
        context: context,
        builder: (context) => const _ExpenseTypePicker(),
      );
      if (type == null || !context.mounted) return;

      final data = await showModalBottomSheet<Object>(
        context: context,
        isScrollControlled: true,
        builder: (context) => AddPaymentBottomSheet(type: type),
      );
      if (data == null) return;

      final updatedCar = switch (type) {
        PaymentEntryType.insurance => car.copyWith(
          insuranceDatas: [...car.insuranceDatas, data as InsuranceData],
        ),
        PaymentEntryType.inspection => car.copyWith(
          inspectionDatas: [...car.inspectionDatas, data as InspectionData],
        ),
        PaymentEntryType.tax => car.copyWith(
          taxDatas: [...car.taxDatas, data as TaxData],
        ),
        PaymentEntryType.repair => car.copyWith(
          repairDatas: [...car.repairDatas, data as RepairData],
        ),
        PaymentEntryType.fine => car.copyWith(
          fineDatas: [...car.fineDatas, data as FineData],
        ),
      };

      ref.read(carsControllerProvider.notifier).update(updatedCar);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Expense added')));
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _SurfaceCard(
          child: _PeriodSelector<_ExpenseFilter>(
            value: _filter,
            values: _ExpenseFilter.values,
            labelFor: (filter) => filter.label,
            onChanged: (filter) => setState(() => _filter = filter),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(
                _filter == _ExpenseFilter.all
                    ? 'Expense categories'
                    : '${_filter.label} summary',
              ),
              const SizedBox(height: AppSpacing.lg),
              _BreakdownBar(
                items: _filter.applyBreakdown([
                  _BreakdownItem(
                    'Insurance',
                    car.totalPaidInsurances.toDouble(),
                    AppColors.info,
                  ),
                  _BreakdownItem(
                    'Inspection',
                    car.totalPaidInspections.toDouble(),
                    AppColors.warning,
                  ),
                  _BreakdownItem(
                    'Tax',
                    car.totalPaidTaxes.toDouble(),
                    const Color(0xFF06B6D4),
                  ),
                  _BreakdownItem(
                    'Repairs',
                    car.totalPaidRepairs.toDouble(),
                    const Color(0xFF8B5CF6),
                  ),
                  _BreakdownItem(
                    'Fines',
                    car.totalPaidFines.toDouble(),
                    AppColors.danger,
                  ),
                ]),
                currency: currency,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(
                _filter == _ExpenseFilter.all
                    ? 'Latest expenses'
                    : 'Latest ${_filter.label.toLowerCase()}',
                actionLabel: 'Add expense',
                onAction: addExpense,
              ),
              const SizedBox(height: AppSpacing.md),
              ..._expenseRows(car, currency, _filter),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineTab extends StatelessWidget {
  const _TimelineTab({required this.car, required this.currency});

  final Car car;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final events = _timelineEvents(car, currency);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeading('Vehicle timeline'),
              const SizedBox(height: AppSpacing.md),
              if (events.isEmpty)
                const _EmptyTabLine(
                  'Fuel, service, and payment events will appear here.',
                )
              else
                for (final event in events.take(20)) ...[
                  _DataRowLine(
                    icon: event.icon,
                    title: event.title,
                    subtitle: DateFormat.yMMMd().format(event.date),
                    trailing: event.amount,
                    color: event.color,
                  ),
                  if (event != events.take(20).last) const Divider(height: 20),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: theme.brightness == Brightness.light ? AppShadows.sm : null,
      ),
      child: child,
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: _SurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.brandPrimary, size: 28),
            const SizedBox(height: AppSpacing.lg),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownBar extends StatelessWidget {
  const _BreakdownBar({required this.items, required this.currency});

  final List<_BreakdownItem> items;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.where((item) => item.value > 0).toList();
    final total = visibleItems.fold<double>(0, (sum, item) => sum + item.value);
    final money = NumberFormat.simpleCurrency(name: currency);

    if (visibleItems.isEmpty || total == 0) {
      return const _EmptyTabLine('No cost data yet.');
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Row(
            children: [
              for (final item in visibleItems)
                Expanded(
                  flex: math.max(1, (item.value / total * 1000).round()),
                  child: Container(height: 14, color: item.color),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final item in visibleItems) ...[
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                money.format(item.value),
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          if (item != visibleItems.last) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _DataRowLine extends StatelessWidget {
  const _DataRowLine({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          trailing,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _DueStatusRow extends StatelessWidget {
  const _DueStatusRow({required this.label, required this.days});

  final String label;
  final int? days;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(days);
    final value = days == null
        ? 'No data'
        : days! < 0
        ? 'Overdue'
        : '$days days';
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.brandPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.brandPrimary, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.brandPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.black.withValues(alpha: 0.32),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.label, {this.actionLabel, this.onAction});

  final String label;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(actionLabel!),
          ),
      ],
    );
  }
}

class _PeriodSelector<T> extends StatelessWidget {
  const _PeriodSelector({
    required this.value,
    required this.values,
    required this.labelFor,
    required this.onChanged,
  });

  final T value;
  final List<T> values;
  final String Function(T value) labelFor;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final item in values)
          ChoiceChip(
            label: Text(labelFor(item)),
            selected: item == value,
            onSelected: (_) => onChanged(item),
            selectedColor: AppColors.brandPrimary.withValues(alpha: 0.14),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: item == value
                  ? AppColors.brandPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w800,
            ),
            side: BorderSide(
              color: item == value
                  ? AppColors.brandPrimary.withValues(alpha: 0.4)
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
      ],
    );
  }
}

class _ExpenseTypePicker extends StatelessWidget {
  const _ExpenseTypePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Add expense',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ExpenseTypeChoice(
                  type: PaymentEntryType.insurance,
                  icon: Icons.description_outlined,
                  label: 'Insurance',
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.inspection,
                  icon: Icons.fact_check_outlined,
                  label: 'Inspection',
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.tax,
                  icon: Icons.paid_outlined,
                  label: 'Tax',
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.repair,
                  icon: Icons.build_rounded,
                  label: 'Repair',
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.fine,
                  icon: Icons.report_gmailerrorred_rounded,
                  label: 'Fine',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTypeChoice extends StatelessWidget {
  const _ExpenseTypeChoice({
    required this.type,
    required this.icon,
    required this.label,
  });

  final PaymentEntryType type;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18, color: AppColors.brandPrimary),
      label: Text(label),
      onPressed: () => Navigator.of(context).pop(type),
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppColors.brandPrimary,
        fontWeight: FontWeight.w800,
      ),
      backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
      side: BorderSide(color: AppColors.brandPrimary.withValues(alpha: 0.2)),
    );
  }
}

class _EmptyTabLine extends StatelessWidget {
  const _EmptyTabLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _BreakdownItem {
  const _BreakdownItem(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}

class _TimelineEvent {
  const _TimelineEvent({
    required this.icon,
    required this.color,
    required this.title,
    required this.date,
    required this.amount,
    this.expenseFilter,
  });

  final IconData icon;
  final Color color;
  final String title;
  final DateTime date;
  final String amount;
  final _ExpenseFilter? expenseFilter;
}

List<Widget> _expenseRows(Car car, String currency, _ExpenseFilter filter) {
  final rows = _timelineEvents(car, currency)
      .where((event) {
        if (event.expenseFilter == null) return false;
        return filter == _ExpenseFilter.all || event.expenseFilter == filter;
      })
      .take(10)
      .toList();

  if (rows.isEmpty) {
    return [
      _EmptyTabLine(
        filter == _ExpenseFilter.all
            ? 'No expenses yet.'
            : 'No ${filter.label.toLowerCase()} expenses yet.',
      ),
    ];
  }

  return [
    for (final event in rows) ...[
      _DataRowLine(
        icon: event.icon,
        title: event.title,
        subtitle: DateFormat.yMMMd().format(event.date),
        trailing: event.amount,
        color: event.color,
      ),
      if (event != rows.last) const Divider(height: 20),
    ],
  ];
}

List<_TimelineEvent> _timelineEvents(Car car, String currency) {
  final money = NumberFormat.simpleCurrency(name: currency);
  final events = <_TimelineEvent>[
    for (final entry in car.fuel)
      _TimelineEvent(
        icon: Icons.local_gas_station_rounded,
        color: AppColors.success,
        title: 'Fuel',
        date: entry.date,
        amount: money.format(entry.totalCost),
      ),
    for (final entry in car.insuranceDatas)
      _TimelineEvent(
        icon: Icons.description_outlined,
        color: AppColors.info,
        title: 'Insurance',
        date: entry.startDate,
        amount: money.format(entry.premiumAmount),
        expenseFilter: _ExpenseFilter.insurance,
      ),
    for (final entry in car.inspectionDatas)
      _TimelineEvent(
        icon: Icons.fact_check_outlined,
        color: AppColors.warning,
        title: 'Inspection',
        date: entry.date,
        amount: money.format(entry.amount ?? 0),
        expenseFilter: _ExpenseFilter.inspection,
      ),
    for (final entry in car.taxDatas)
      _TimelineEvent(
        icon: Icons.paid_outlined,
        color: const Color(0xFF06B6D4),
        title: 'Vehicle tax',
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.tax,
      ),
    for (final entry in car.repairDatas)
      _TimelineEvent(
        icon: Icons.build_rounded,
        color: const Color(0xFF8B5CF6),
        title: entry.description.isEmpty ? 'Repair' : entry.description,
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.repair,
      ),
    for (final entry in car.fineDatas)
      _TimelineEvent(
        icon: Icons.report_gmailerrorred_rounded,
        color: AppColors.danger,
        title: 'Fine',
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.fine,
      ),
  ]..sort((a, b) => b.date.compareTo(a.date));

  return events;
}

enum _FuelPeriod {
  threeMonths('3M', 3),
  sixMonths('6M', 6),
  oneYear('1Y', 12),
  all('All', null);

  const _FuelPeriod(this.label, this.months);

  final String label;
  final int? months;

  DateTime? cutoffDate(DateTime now) {
    final value = months;
    if (value == null) return null;
    return DateTime(now.year, now.month - value + 1);
  }
}

enum _ExpenseFilter {
  all('All'),
  insurance('Insurance'),
  inspection('Inspection'),
  tax('Tax'),
  repair('Repair'),
  fine('Fine');

  const _ExpenseFilter(this.label);

  final String label;

  List<_BreakdownItem> applyBreakdown(List<_BreakdownItem> items) {
    if (this == _ExpenseFilter.all) return items;
    return items.where((item) => item.label == label).toList();
  }
}

Color _statusColor(int? days) {
  if (days == null) return AppColors.info;
  if (days < 0) return AppColors.danger;
  if (days <= 30) return AppColors.warning;
  return AppColors.success;
}
