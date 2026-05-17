import 'dart:math' as math;

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/shared/widgets/app_back_button.dart';
import 'package:cars_manager/shared/widgets/vehicle_visual_card.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/entries/add_payment_bottom_sheet.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class VehicleDetailScreen extends ConsumerStatefulWidget {
  const VehicleDetailScreen({
    super.key,
    required this.carId,
    this.initialTabIndex = 0,
  });

  final String carId;
  final int initialTabIndex;

  @override
  ConsumerState<VehicleDetailScreen> createState() =>
      _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends ConsumerState<VehicleDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void didUpdateWidget(VehicleDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTabIndex != oldWidget.initialTabIndex) {
      _tabController.animateTo(widget.initialTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cars = ref.watch(carsControllerProvider);
    final car = cars.where((item) => item.id == widget.carId).firstOrNull;
    final activeCarId = ref.watch(activeCarControllerProvider);
    final currency = ref.watch(appSettingsProvider).currency;

    if (car == null) {
      return SafeArea(
        child: EmptyState(
          icon: Icons.directions_car_outlined,
          title: l10n.vehicleDetail_notFound,
          subtitle: l10n.vehicleDetail_notFoundSubtitle,
          actionLabel: l10n.vehicleDetail_backToGarage,
          onAction: () => context.go('/garage'),
        ),
      );
    }

    if (activeCarId != car.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(activeCarControllerProvider.notifier).select(car.id);
      });
    }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;
          final header = _VehicleHeader(car: car, l10n: l10n);
          final tabs = _VehicleTabs(
            car: car,
            currency: currency,
            controller: _tabController,
            l10n: l10n,
          );

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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: tabs,
            ),
          );
        },
      ),
    );
  }
}

class _VehicleHeader extends ConsumerWidget {
  const _VehicleHeader({required this.car, required this.l10n});

  final Car car;
  final AppLocalizations l10n;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Navigation row: back button left, edit button right
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            children: [
              AppBackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/garage');
                  }
                },
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: editCar,
                icon: const Icon(Icons.edit_rounded, size: 18),
                label: Text(l10n.common_edit),
              ),
            ],
          ),
        ),
        // Car card — full-width image with info below
        _SurfaceCard(
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image / visual card with gradient overlay
                SizedBox(
                  height: 200,
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
                        VehicleVisualCard(
                          car: car,
                          height: 200,
                          borderRadius: 0,
                        ),
                      // Gradient + name overlay (always shown)
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xC0000000)],
                          ),
                        ),
                      ),
                      Positioned(
                        left: AppSpacing.lg,
                        right: AppSpacing.lg,
                        bottom: AppSpacing.lg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                              '${car.manufacture} ${car.model} · ${car.yearOfManufacture}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.80),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Info section below image
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
                                ? l10n.vehicleDetail_noPlate
                                : car.licensePlate,
                          ),
                          _InfoPill(
                            icon: Icons.local_gas_station_rounded,
                            label:
                                car.fuelType?.name ??
                                l10n.vehicleDetail_fuelNotSet,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _DueStatusRow(
                        icon: Icons.description_outlined,
                        color: AppColors.categoryInsurance,
                        label: l10n.vehicleDetail_insurance,
                        days: car.daysUntilNextInsuranceExpiration,
                        dueDate: car.nextInsuranceExpirationDate,
                        l10n: l10n,
                        calendarTitle:
                            '${l10n.vehicleDetail_insurance} — ${car.name}',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _DueStatusRow(
                        icon: Icons.fact_check_outlined,
                        color: AppColors.categoryInspection,
                        label: l10n.vehicleDetail_inspection,
                        days: car.daysUntilNextInspection,
                        dueDate: car.nextInspectionDate,
                        l10n: l10n,
                        calendarTitle:
                            '${l10n.vehicleDetail_inspection} — ${car.name}',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _DueStatusRow(
                        icon: Icons.paid_outlined,
                        color: AppColors.categoryTax,
                        label: l10n.vehicleDetail_tax,
                        days: car.daysUntilNextTaxDue,
                        dueDate: car.nextTaxDueDate,
                        l10n: l10n,
                        calendarTitle:
                            '${l10n.vehicleDetail_tax} — ${car.name}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VehicleTabs extends StatelessWidget {
  const _VehicleTabs({
    required this.car,
    required this.currency,
    required this.controller,
    required this.l10n,
  });

  final Car car;
  final String currency;
  final TabController controller;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SurfaceCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xs,
          ),
          child: TabBar(
            controller: controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant,
            tabs: [
              Tab(text: l10n.vehicleDetail_tabOverview),
              Tab(text: l10n.vehicleDetail_tabFuel),
              Tab(text: l10n.vehicleDetail_tabExpenses),
              Tab(text: l10n.vehicleDetail_tabTimeline),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              _OverviewTab(car: car, currency: currency, l10n: l10n),
              _FuelTab(car: car, currency: currency, l10n: l10n),
              _ExpensesTab(car: car, currency: currency, l10n: l10n),
              _TimelineTab(car: car, currency: currency, l10n: l10n),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({
    required this.car,
    required this.currency,
    required this.l10n,
  });

  final Car car;
  final String currency;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.simpleCurrency(name: currency);
    final total = car.totalFuelCost + car.totalPaidExpenses;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _MetricCard(
              icon: Icons.payments_rounded,
              label: l10n.vehicleDetail_totalTracked,
              value: money.format(total),
            ),
            _MetricCard(
              icon: Icons.local_gas_station_rounded,
              label: l10n.vehicleDetail_fuelEntries,
              value: '${car.fuel.length}',
            ),
            _MetricCard(
              icon: Icons.build_rounded,
              label: l10n.vehicleDetail_serviceEvents,
              value: '${car.repairDatas.length + car.inspectionDatas.length}',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(l10n.vehicleDetail_costBreakdown),
              const SizedBox(height: AppSpacing.lg),
              _BreakdownBar(
                items: [
                  _BreakdownItem(
                    l10n.vehicleDetail_fuel,
                    car.totalFuelCost,
                    AppColors.categoryFuel,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_insurance,
                    car.totalPaidInsurances.toDouble(),
                    AppColors.categoryInsurance,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_tax,
                    car.totalPaidTaxes.toDouble(),
                    AppColors.categoryTax,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_repair,
                    car.totalPaidRepairs.toDouble(),
                    AppColors.categoryRepair,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_fine,
                    car.totalPaidFines.toDouble(),
                    AppColors.categoryFine,
                  ),
                ],
                currency: currency,
                l10n: l10n,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FuelTab extends ConsumerStatefulWidget {
  const _FuelTab({
    required this.car,
    required this.currency,
    required this.l10n,
  });

  final Car car;
  final String currency;
  final AppLocalizations l10n;

  @override
  ConsumerState<_FuelTab> createState() => _FuelTabState();
}

class _FuelTabState extends ConsumerState<_FuelTab> {
  _FuelPeriod _period = _FuelPeriod.oneYear;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
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
      AppSnackBar.show(context, l10n.vehicleDetail_addFuel);
    }

    Future<void> editFuelEntry(FuelEntry entry) async {
      final updated = await showModalBottomSheet<FuelEntry>(
        context: context,
        isScrollControlled: true,
        builder: (context) => AddFuelEntryBottomSheet(
          lockedFuelType: car.fuelType,
          initialEntry: entry,
        ),
      );
      if (updated == null) return;
      final newList = car.fuel.map((e) => e == entry ? updated : e).toList();
      ref
          .read(carsControllerProvider.notifier)
          .update(car.copyWith(fuel: newList));
    }

    void deleteFuelEntry(FuelEntry entry) {
      ref
          .read(carsControllerProvider.notifier)
          .update(
            car.copyWith(fuel: car.fuel.where((e) => e != entry).toList()),
          );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        AppSpacing.xxxl,
      ),
      children: [
        _SurfaceCard(
          child: _PeriodSelector<_FuelPeriod>(
            value: _period,
            values: _FuelPeriod.values,
            labelFor: (period) => period.labelFor(l10n),
            onChanged: (period) => setState(() {
              _period = period;
              _showAll = false;
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _MetricCard(
              icon: Icons.payments_rounded,
              label: l10n.vehicleDetail_totalTracked,
              value: money.format(fuelCost),
            ),
            _MetricCard(
              icon: Icons.water_drop_rounded,
              label: l10n.vehicleDetail_totalLiters,
              value: NumberFormat.decimalPattern().format(liters),
            ),
            _MetricCard(
              icon: Icons.speed_rounded,
              label: l10n.vehicleDetail_avgPricePerLiter,
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
                l10n.vehicleDetail_fuelHistory(_period.labelFor(l10n)),
                actionLabel: l10n.vehicleDetail_addFuel,
                onAction: addFuelEntry,
              ),
              const SizedBox(height: AppSpacing.md),
              if (entries.isEmpty)
                _EmptyTabLine(l10n.vehicleDetail_noFuelEntries)
              else ...[
                for (final entry
                    in (_showAll ? entries : entries.take(8).toList())) ...[
                  _ActionableDataRow(
                    icon: Icons.local_gas_station_rounded,
                    title: '${entry.liters.toStringAsFixed(2)} L',
                    subtitle: entry.liters > 0
                        ? '${DateFormat.yMMMd().format(entry.date)} · ${money.format(entry.totalCost / entry.liters)}/L'
                        : DateFormat.yMMMd().format(entry.date),
                    trailing: money.format(entry.totalCost),
                    color: AppColors.categoryFuel,
                    onEdit: () => editFuelEntry(entry),
                    onDelete: () => deleteFuelEntry(entry),
                    l10n: l10n,
                  ),
                  if (entry !=
                      (_showAll ? entries : entries.take(8).toList()).last)
                    const Divider(height: 20),
                ],
                if (entries.length > 8) ...[
                  const Divider(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _showAll = !_showAll),
                      child: Text(
                        _showAll
                            ? l10n.common_showLess
                            : l10n.vehicleDetail_showAllEntries(entries.length),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpensesTab extends ConsumerStatefulWidget {
  const _ExpensesTab({
    required this.car,
    required this.currency,
    required this.l10n,
  });

  final Car car;
  final String currency;
  final AppLocalizations l10n;

  @override
  ConsumerState<_ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends ConsumerState<_ExpensesTab> {
  _ExpenseFilter _filter = _ExpenseFilter.all;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final car = widget.car;
    final currency = widget.currency;

    Future<void> addExpense() async {
      final type = await showModalBottomSheet<PaymentEntryType>(
        context: context,
        builder: (context) => _ExpenseTypePicker(l10n: l10n),
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
      AppSnackBar.show(context, l10n.vehicleDetail_addExpense);
    }

    Future<void> editExpense(_TimelineEvent event) async {
      if (event.expenseFilter == null) return;
      final type = switch (event.expenseFilter!) {
        _ExpenseFilter.insurance => PaymentEntryType.insurance,
        _ExpenseFilter.inspection => PaymentEntryType.inspection,
        _ExpenseFilter.tax => PaymentEntryType.tax,
        _ExpenseFilter.repair => PaymentEntryType.repair,
        _ExpenseFilter.fine => PaymentEntryType.fine,
        _ExpenseFilter.all => null,
      };
      if (type == null) return;

      final data = await showModalBottomSheet<Object>(
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            AddPaymentBottomSheet(type: type, initialData: event.rawData),
      );
      if (data == null) return;

      Car updatedCar;
      switch (type) {
        case PaymentEntryType.insurance:
          updatedCar = car.copyWith(
            insuranceDatas: car.insuranceDatas
                .map((e) => e == event.rawData ? data as InsuranceData : e)
                .toList(),
          );
        case PaymentEntryType.inspection:
          updatedCar = car.copyWith(
            inspectionDatas: car.inspectionDatas
                .map((e) => e == event.rawData ? data as InspectionData : e)
                .toList(),
          );
        case PaymentEntryType.tax:
          updatedCar = car.copyWith(
            taxDatas: car.taxDatas
                .map((e) => e == event.rawData ? data as TaxData : e)
                .toList(),
          );
        case PaymentEntryType.repair:
          updatedCar = car.copyWith(
            repairDatas: car.repairDatas
                .map((e) => e == event.rawData ? data as RepairData : e)
                .toList(),
          );
        case PaymentEntryType.fine:
          updatedCar = car.copyWith(
            fineDatas: car.fineDatas
                .map((e) => e == event.rawData ? data as FineData : e)
                .toList(),
          );
      }
      ref.read(carsControllerProvider.notifier).update(updatedCar);
    }

    void deleteExpense(_TimelineEvent event) {
      if (event.expenseFilter == null) return;
      final type = switch (event.expenseFilter!) {
        _ExpenseFilter.insurance => PaymentEntryType.insurance,
        _ExpenseFilter.inspection => PaymentEntryType.inspection,
        _ExpenseFilter.tax => PaymentEntryType.tax,
        _ExpenseFilter.repair => PaymentEntryType.repair,
        _ExpenseFilter.fine => PaymentEntryType.fine,
        _ExpenseFilter.all => null,
      };
      if (type == null) return;

      Car updatedCar;
      switch (type) {
        case PaymentEntryType.insurance:
          updatedCar = car.copyWith(
            insuranceDatas: car.insuranceDatas
                .where((e) => e != event.rawData)
                .toList(),
          );
        case PaymentEntryType.inspection:
          updatedCar = car.copyWith(
            inspectionDatas: car.inspectionDatas
                .where((e) => e != event.rawData)
                .toList(),
          );
        case PaymentEntryType.tax:
          updatedCar = car.copyWith(
            taxDatas: car.taxDatas.where((e) => e != event.rawData).toList(),
          );
        case PaymentEntryType.repair:
          updatedCar = car.copyWith(
            repairDatas: car.repairDatas
                .where((e) => e != event.rawData)
                .toList(),
          );
        case PaymentEntryType.fine:
          updatedCar = car.copyWith(
            fineDatas: car.fineDatas.where((e) => e != event.rawData).toList(),
          );
      }
      ref.read(carsControllerProvider.notifier).update(updatedCar);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        AppSpacing.xxxl,
      ),
      children: [
        _SurfaceCard(
          child: _PeriodSelector<_ExpenseFilter>(
            value: _filter,
            values: _ExpenseFilter.values,
            labelFor: (filter) => filter.label(l10n),
            onChanged: (filter) => setState(() {
              _filter = filter;
              _showAll = false;
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(
                _filter == _ExpenseFilter.all
                    ? l10n.vehicleDetail_expenseCategories
                    : l10n.vehicleDetail_categorySummary(_filter.label(l10n)),
              ),
              const SizedBox(height: AppSpacing.lg),
              _BreakdownBar(
                items: _filter.applyBreakdown([
                  _BreakdownItem(
                    l10n.vehicleDetail_insurance,
                    car.totalPaidInsurances.toDouble(),
                    AppColors.categoryInsurance,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_inspection,
                    car.totalPaidInspections.toDouble(),
                    AppColors.categoryInspection,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_tax,
                    car.totalPaidTaxes.toDouble(),
                    AppColors.categoryTax,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_repair,
                    car.totalPaidRepairs.toDouble(),
                    AppColors.categoryRepair,
                  ),
                  _BreakdownItem(
                    l10n.vehicleDetail_fine,
                    car.totalPaidFines.toDouble(),
                    AppColors.categoryFine,
                  ),
                ]),
                currency: currency,
                l10n: l10n,
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
                    ? l10n.vehicleDetail_latestExpenses
                    : l10n.vehicleDetail_latestExpensesFiltered(
                        _filter.label(l10n).toLowerCase(),
                      ),
                actionLabel: l10n.vehicleDetail_addExpense,
                onAction: addExpense,
              ),
              const SizedBox(height: AppSpacing.md),
              ..._expenseRows(
                car,
                currency,
                _filter,
                l10n: l10n,
                showAll: _showAll,
                onToggleShowAll: () => setState(() => _showAll = !_showAll),
                onEdit: editExpense,
                onDelete: deleteExpense,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineTab extends StatefulWidget {
  const _TimelineTab({
    required this.car,
    required this.currency,
    required this.l10n,
  });

  final Car car;
  final String currency;
  final AppLocalizations l10n;

  @override
  State<_TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<_TimelineTab> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final events = _timelineEvents(widget.car, widget.currency, l10n);
    final visible = _showAll ? events : events.take(20).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        AppSpacing.xxxl,
      ),
      children: [
        _SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeading(l10n.vehicleDetail_vehicleTimeline),
              const SizedBox(height: AppSpacing.md),
              if (events.isEmpty)
                _EmptyTabLine(l10n.vehicleDetail_timelineEmpty)
              else ...[
                for (final event in visible) ...[
                  _DataRowLine(
                    icon: event.icon,
                    title: event.title,
                    subtitle: DateFormat.yMMMd().format(event.date),
                    trailing: event.amount,
                    color: event.color,
                  ),
                  if (event != visible.last) const Divider(height: 20),
                ],
                if (events.length > 20) ...[
                  const Divider(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _showAll = !_showAll),
                      child: Text(
                        _showAll
                            ? l10n.common_showLess
                            : l10n.vehicleDetail_showAllEvents(events.length),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── Shared surface card ──────────────────────────────────────────────────────

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: theme.colorScheme.outline, width: 0.5),
        boxShadow: theme.brightness == Brightness.light ? AppShadows.sm : null,
      ),
      child: child,
    );
  }
}

// ── Metric card (auto-expands in a Row) ─────────────────────────────────────

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
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Breakdown bar ────────────────────────────────────────────────────────────

class _BreakdownBar extends StatelessWidget {
  const _BreakdownBar({
    required this.items,
    required this.currency,
    required this.l10n,
  });

  final List<_BreakdownItem> items;
  final String currency;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.where((item) => item.value > 0).toList();
    final total = visibleItems.fold<double>(0, (sum, item) => sum + item.value);
    final money = NumberFormat.simpleCurrency(name: currency);

    if (visibleItems.isEmpty || total == 0) {
      return _EmptyTabLine(l10n.vehicleDetail_noData);
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

// ── Plain data row ───────────────────────────────────────────────────────────

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
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
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

// ── Actionable data row (with edit/delete three-dot menu) ───────────────────

class _ActionableDataRow extends StatelessWidget {
  const _ActionableDataRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.color,
    required this.onEdit,
    required this.onDelete,
    required this.l10n,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;
  final Color color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
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
                  color: cs.onSurfaceVariant,
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
        PopupMenuButton<String>(
          tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
          icon: Icon(Icons.more_vert, size: 20, color: cs.onSurfaceVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 18, color: cs.onSurface),
                  const SizedBox(width: 10),
                  Text(l10n.common_edit),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 18, color: cs.error),
                  const SizedBox(width: 10),
                  Text(l10n.common_delete, style: TextStyle(color: cs.error)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Due status row with icon ─────────────────────────────────────────────────

class _DueStatusRow extends StatelessWidget {
  const _DueStatusRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.days,
    required this.l10n,
    this.dueDate,
    this.calendarTitle,
  });

  final IconData icon;
  final Color color;
  final String label;
  final int? days;
  final AppLocalizations l10n;
  final DateTime? dueDate;
  final String? calendarTitle;

  @override
  Widget build(BuildContext context) {
    final statusColor = statusColorForDaysOf(context, days);
    final value = days == null ? l10n.common_noData : '${days!}d';
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        if (dueDate != null) ...[
          Tooltip(
            message: l10n.common_addToCalendar,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Add2Calendar.addEvent2Cal(
                Event(
                  title: calendarTitle ?? label,
                  startDate: dueDate!,
                  endDate: dueDate!,
                  allDay: true,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        // Pill with glow bullet inside at the right
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.7),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
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
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
            selectedColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.10),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: item == value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: item == value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
      ],
    );
  }
}

class _ExpenseTypePicker extends StatelessWidget {
  const _ExpenseTypePicker({required this.l10n});

  final AppLocalizations l10n;

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
                    l10n.vehicleDetail_addExpenseTitle,
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
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ExpenseTypeChoice(
                  type: PaymentEntryType.insurance,
                  icon: Icons.description_outlined,
                  label: l10n.vehicleDetail_insurance,
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.inspection,
                  icon: Icons.fact_check_outlined,
                  label: l10n.vehicleDetail_inspection,
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.tax,
                  icon: Icons.paid_outlined,
                  label: l10n.vehicleDetail_tax,
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.repair,
                  icon: Icons.build_rounded,
                  label: l10n.vehicleDetail_repair,
                ),
                _ExpenseTypeChoice(
                  type: PaymentEntryType.fine,
                  icon: Icons.report_gmailerrorred_rounded,
                  label: l10n.vehicleDetail_fine,
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
      avatar: Icon(
        icon,
        size: 18,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(label),
      onPressed: () => Navigator.of(context).pop(type),
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.1),
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      ),
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

// ── Data models ──────────────────────────────────────────────────────────────

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
    this.rawData,
  });

  final IconData icon;
  final Color color;
  final String title;
  final DateTime date;
  final String amount;
  final _ExpenseFilter? expenseFilter;

  /// The original data object, used for edit/delete operations.
  final Object? rawData;
}

// ── Helper functions ─────────────────────────────────────────────────────────

List<Widget> _expenseRows(
  Car car,
  String currency,
  _ExpenseFilter filter, {
  required AppLocalizations l10n,
  bool showAll = false,
  VoidCallback? onToggleShowAll,
  void Function(_TimelineEvent)? onEdit,
  void Function(_TimelineEvent)? onDelete,
}) {
  final all = _timelineEvents(car, currency, l10n).where((event) {
    if (event.expenseFilter == null) return false;
    return filter == _ExpenseFilter.all || event.expenseFilter == filter;
  }).toList();

  if (all.isEmpty) {
    return [
      _EmptyTabLine(
        filter == _ExpenseFilter.all
            ? l10n.vehicleDetail_noExpenses
            : l10n.vehicleDetail_noExpensesFiltered(
                filter.label(l10n).toLowerCase(),
              ),
      ),
    ];
  }

  final visible = showAll ? all : all.take(10).toList();
  return [
    for (final event in visible) ...[
      if (onEdit != null && onDelete != null)
        _ActionableDataRow(
          icon: event.icon,
          title: event.title,
          subtitle: DateFormat.yMMMd().format(event.date),
          trailing: event.amount,
          color: event.color,
          onEdit: () => onEdit(event),
          onDelete: () => onDelete(event),
          l10n: l10n,
        )
      else
        _DataRowLine(
          icon: event.icon,
          title: event.title,
          subtitle: DateFormat.yMMMd().format(event.date),
          trailing: event.amount,
          color: event.color,
        ),
      if (event != visible.last) const Divider(height: 20),
    ],
    if (all.length > 10 && onToggleShowAll != null) ...[
      const Divider(height: 20),
      Center(
        child: TextButton(
          onPressed: onToggleShowAll,
          child: Text(
            showAll
                ? l10n.common_showLess
                : l10n.vehicleDetail_showAllExpenses(all.length),
          ),
        ),
      ),
    ],
  ];
}

List<_TimelineEvent> _timelineEvents(
  Car car,
  String currency,
  AppLocalizations l10n,
) {
  final money = NumberFormat.simpleCurrency(name: currency);
  final events = <_TimelineEvent>[
    for (final entry in car.fuel)
      _TimelineEvent(
        icon: Icons.local_gas_station_rounded,
        color: AppColors.categoryFuel,
        title: l10n.vehicleDetail_fuel,
        date: entry.date,
        amount: money.format(entry.totalCost),
        rawData: entry,
      ),
    for (final entry in car.insuranceDatas)
      _TimelineEvent(
        icon: Icons.description_outlined,
        color: AppColors.categoryInsurance,
        title: l10n.vehicleDetail_insurance,
        date: entry.startDate,
        amount: money.format(entry.premiumAmount),
        expenseFilter: _ExpenseFilter.insurance,
        rawData: entry,
      ),
    for (final entry in car.inspectionDatas)
      _TimelineEvent(
        icon: Icons.fact_check_outlined,
        color: AppColors.categoryInspection,
        title: l10n.vehicleDetail_inspection,
        date: entry.date,
        amount: money.format(entry.amount ?? 0),
        expenseFilter: _ExpenseFilter.inspection,
        rawData: entry,
      ),
    for (final entry in car.taxDatas)
      _TimelineEvent(
        icon: Icons.paid_outlined,
        color: AppColors.categoryTax,
        title: l10n.vehicleDetail_tax,
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.tax,
        rawData: entry,
      ),
    for (final entry in car.repairDatas)
      _TimelineEvent(
        icon: Icons.build_rounded,
        color: AppColors.categoryRepair,
        title: entry.description.isEmpty
            ? l10n.vehicleDetail_repair
            : entry.description,
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.repair,
        rawData: entry,
      ),
    for (final entry in car.fineDatas)
      _TimelineEvent(
        icon: Icons.report_gmailerrorred_rounded,
        color: AppColors.categoryFine,
        title: l10n.vehicleDetail_fine,
        date: entry.date,
        amount: money.format(entry.amount),
        expenseFilter: _ExpenseFilter.fine,
        rawData: entry,
      ),
  ]..sort((a, b) => b.date.compareTo(a.date));

  return events;
}

// ── Enums ────────────────────────────────────────────────────────────────────

enum _FuelPeriod {
  threeMonths('3M', 3),
  sixMonths('6M', 6),
  oneYear('1Y', 12),
  all(null, null);

  const _FuelPeriod(this.abbreviation, this.months);

  /// Short abbreviation (e.g. '3M'); null only for the 'all' case.
  final String? abbreviation;
  final int? months;

  String labelFor(AppLocalizations l10n) => abbreviation ?? l10n.common_all;

  DateTime? cutoffDate(DateTime now) {
    final value = months;
    if (value == null) return null;
    return DateTime(now.year, now.month - value + 1);
  }
}

enum _ExpenseFilter {
  all,
  insurance,
  inspection,
  tax,
  repair,
  fine;

  String label(AppLocalizations l10n) => switch (this) {
    _ExpenseFilter.all => l10n.common_all,
    _ExpenseFilter.insurance => l10n.vehicleDetail_insurance,
    _ExpenseFilter.inspection => l10n.vehicleDetail_inspection,
    _ExpenseFilter.tax => l10n.vehicleDetail_tax,
    _ExpenseFilter.repair => l10n.vehicleDetail_repair,
    _ExpenseFilter.fine => l10n.vehicleDetail_fine,
  };

  List<_BreakdownItem> applyBreakdown(List<_BreakdownItem> items) {
    if (this == _ExpenseFilter.all) return items;
    // Match by position: insurance=0, inspection=1, tax=2, repair=3, fine=4
    final index = _ExpenseFilter.values.indexOf(this) - 1;
    if (index < 0 || index >= items.length) return items;
    return [items[index]];
  }
}
