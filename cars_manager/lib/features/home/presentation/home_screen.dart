import 'dart:math' as math;

import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/search/presentation/search_overlay.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:cars_manager/presentation/common/widgets/car_switcher_header.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/widgets/notification_center.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:cars_manager/shared/widgets/section_header_row.dart';
import 'package:cars_manager/shared/widgets/vehicle_visual_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cars = ref.watch(carsControllerProvider);
    final activeCar = ref.watch(activeCarProvider) ?? cars.firstOrNull;
    final currency = ref.watch(appSettingsProvider).currency;

    Future<void> openAddForm() async {
      final created = await Navigator.of(
        context,
      ).push<Car>(MaterialPageRoute(builder: (_) => const CarFormPage()));
      if (created == null || !context.mounted) return;
      ref.read(carsControllerProvider.notifier).add(created);
      context.go('/car/${created.id}');
    }

    if (cars.isEmpty || activeCar == null) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: EmptyState(
              icon: Icons.directions_car_filled_outlined,
              title: l10n.home_addFirstCar,
              subtitle: l10n.home_addFirstCarSubtitle,
              actionLabel: l10n.home_addCar,
              onAction: openAddForm,
            ),
          ),
        ),
      );
    }

    final dashboard = _DashboardData.fromCar(activeCar, currency, l10n);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {},
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            final content = isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _ActiveCarHero(
                              car: activeCar,
                              data: dashboard,
                              onSwitchCar: () =>
                                  showCarSwitcherSheet(context, ref),
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            _UpcomingSection(items: dashboard.upcoming),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _QuickActions(activeCar: activeCar),
                            const SizedBox(height: AppSpacing.xl),
                            _RecentActivity(
                              items: dashboard.recentActivity,
                              carId: activeCar.id,
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            _MonthlySummary(data: dashboard),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _GreetingRow(l10n: l10n),
                      const SizedBox(height: AppSpacing.lg),
                      _ActiveCarHero(
                        car: activeCar,
                        data: dashboard,
                        onSwitchCar: () => showCarSwitcherSheet(context, ref),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _QuickActions(activeCar: activeCar),
                      const SizedBox(height: AppSpacing.xl),
                      _UpcomingSection(items: dashboard.upcoming),
                      const SizedBox(height: AppSpacing.xl),
                      _RecentActivity(
                        items: dashboard.recentActivity,
                        carId: activeCar.id,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _MonthlySummary(data: dashboard),
                    ],
                  );

            return ListView(
              padding: EdgeInsets.all(isWide ? AppSpacing.xxl : AppSpacing.lg),
              children: [content],
            );
          },
        ),
      ),
    );
  }
}

class _GreetingRow extends StatelessWidget {
  const _GreetingRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('EEE, MMM d').format(DateTime.now());

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateStr,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.home_welcomeBack,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
        const NotificationCenter(),
      ],
    );
  }
}

class _ActiveCarHero extends StatelessWidget {
  const _ActiveCarHero({
    required this.car,
    required this.data,
    this.onSwitchCar,
  });

  final Car car;
  final _DashboardData data;
  final VoidCallback? onSwitchCar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final hasImage =
        (car.imageBase64 != null && car.imageBase64!.isNotEmpty) ||
        (car.imageUrl != null && car.imageUrl!.isNotEmpty);

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.card),
      onTap: () => context.push('/car/${car.id}'),
      child: _DashboardCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
                child: hasImage
                    ? ImageRect(
                        aspectRatio: 16 / 9,
                        imageUrl: car.imageUrl,
                        imageBase64: car.imageBase64,
                        imageAlignment: car.imageAlignment,
                        backgroundColor: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.zero,
                        primaryColor: colors.primary,
                      )
                    : VehicleVisualCard(car: car, borderRadius: 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${l10n.home_activeCar} · ${car.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onSwitchCar,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xs,
                        ),
                        child: Text(
                          '${l10n.home_switchCar} ›',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.activeCar});

  final Car activeCar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderRow(title: l10n.home_quickActions),
          Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.local_gas_station_rounded,
                  label: l10n.home_quickFuel,
                  color: AppColors.accentLight,
                  onTap: () => context.push('/car/${activeCar.id}/fuel'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.receipt_long_rounded,
                  label: l10n.home_quickExpense,
                  color: AppColors.categoryTax,
                  onTap: () => context.push('/car/${activeCar.id}/expenses'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.search_rounded,
                  label: l10n.home_quickSearch,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  onTap: () => showSearchOverlay(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingSection extends StatelessWidget {
  const _UpcomingSection({required this.items});

  final List<_DueItem> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderRow(title: l10n.home_upcoming),
          if (items.isEmpty)
            _MutedLine(
              icon: Icons.check_circle_outline_rounded,
              text: l10n.home_upcomingEmpty,
            )
          else
            for (final item in items) ...[
              _DueRow(item: item),
              if (item != items.last) const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _RecentActivity extends StatelessWidget {
  const _RecentActivity({required this.items, required this.carId});

  final List<_ActivityItem> items;
  final String carId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderRow(
            title: l10n.home_recentActivity,
            actionLabel: items.isNotEmpty
                ? l10n.home_recentActivitySeeAll
                : null,
            onAction: items.isNotEmpty
                ? () => context.push('/car/$carId/timeline')
                : null,
          ),
          if (items.isEmpty)
            _MutedLine(
              icon: Icons.history_rounded,
              text: l10n.home_recentActivityEmpty,
            )
          else
            for (final item in items) ...[
              _ActivityRow(item: item),
              if (item != items.last) const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _MonthlySummary extends StatelessWidget {
  const _MonthlySummary({required this.data});

  final _DashboardData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final maxValue = math.max(1.0, data.monthlySeries.reduce(math.max));
    final now = DateTime.now();
    final count = data.monthlySeries.length;
    final monthDates = List.generate(
      count,
      (i) => DateTime(now.year, now.month - (count - 1) + i),
    );

    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderRow(title: l10n.home_monthlySummary),
          Text(
            data.formatMoney(data.currentMonthTotal),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.home_monthlySummarySubtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 104,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < data.monthlySeries.length; i++) ...[
                  Expanded(
                    child: _MiniBarWithLabel(
                      heightFactor: data.monthlySeries[i] / maxValue,
                      isActive: i == data.monthlySeries.length - 1,
                      label: DateFormat.MMM().format(monthDates[i]),
                    ),
                  ),
                  if (i != data.monthlySeries.length - 1)
                    const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child, this.padding});

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

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DueRow extends StatelessWidget {
  const _DueRow({required this.item});

  final _DueItem item;

  @override
  Widget build(BuildContext context) {
    final color = statusColorForDaysOf(context, item.days);
    // Show actual number including negatives (e.g. "-5d" for overdue)
    final daysText = '${item.days}d';
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, size: 18, color: color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Pill with glow bullet inside at the right
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                daysText,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.7),
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

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item});

  final _ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item.icon, size: 18, color: item.color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                DateFormat.yMMMd().format(item.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Text(
          item.amount,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _MutedLine extends StatelessWidget {
  const _MutedLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniBarWithLabel extends StatelessWidget {
  const _MiniBarWithLabel({
    required this.heightFactor,
    required this.isActive,
    required this.label,
  });

  final double heightFactor;
  final bool isActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: math.max(0.08, heightFactor),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.accentLight
                      : AppColors.accentLight.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isActive
                ? AppColors.accentLight
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _DashboardData {
  const _DashboardData({
    required this.currency,
    required this.insuranceDays,
    required this.inspectionDays,
    required this.taxDays,
    required this.upcoming,
    required this.recentActivity,
    required this.monthlySeries,
    required this.currentMonthTotal,
  });

  final String currency;
  final int? insuranceDays;
  final int? inspectionDays;
  final int? taxDays;
  final List<_DueItem> upcoming;
  final List<_ActivityItem> recentActivity;
  final List<double> monthlySeries;
  final double currentMonthTotal;

  bool get hasOverdue =>
      (insuranceDays != null && insuranceDays! < 0) ||
      (inspectionDays != null && inspectionDays! < 0) ||
      (taxDays != null && taxDays! < 0);

  factory _DashboardData.fromCar(
    Car car,
    String currency,
    AppLocalizations l10n,
  ) {
    final now = DateTime.now();
    final money = NumberFormat.simpleCurrency(name: currency);

    final dueItems = [
      if (car.nextInsuranceExpirationDate != null)
        _DueItem(
          icon: Icons.description_outlined,
          title: l10n.home_activityInsurance,
          subtitle: DateFormat.yMMMd().format(car.nextInsuranceExpirationDate!),
          days: car.daysUntilNextInsuranceExpiration!,
        ),
      if (car.nextInspectionDate != null)
        _DueItem(
          icon: Icons.fact_check_outlined,
          title: l10n.home_activityInspection,
          subtitle: DateFormat.yMMMd().format(car.nextInspectionDate!),
          days: car.daysUntilNextInspection!,
        ),
      if (car.nextTaxDueDate != null)
        _DueItem(
          icon: Icons.paid_outlined,
          title: l10n.home_activityVehicleTax,
          subtitle: DateFormat.yMMMd().format(car.nextTaxDueDate!),
          days: car.daysUntilNextTaxDue!,
        ),
    ]..sort((a, b) => a.days.compareTo(b.days));

    final activity = <_ActivityItem>[
      for (final entry in car.fuel)
        _ActivityItem(
          icon: Icons.local_gas_station_rounded,
          color: AppColors.categoryFuel,
          title: l10n.home_activityFuelEntry,
          date: entry.date,
          amount: money.format(entry.totalCost),
        ),
      for (final repair in car.repairDatas)
        _ActivityItem(
          icon: Icons.build_rounded,
          color: AppColors.categoryRepair,
          title: l10n.home_activityRepair,
          date: repair.date,
          amount: money.format(repair.amount),
        ),
      for (final fine in car.fineDatas)
        _ActivityItem(
          icon: Icons.report_gmailerrorred_rounded,
          color: AppColors.categoryFine,
          title: l10n.home_activityFine,
          date: fine.date,
          amount: money.format(fine.amount),
        ),
      for (final tax in car.taxDatas)
        _ActivityItem(
          icon: Icons.paid_outlined,
          color: AppColors.categoryTax,
          title: l10n.home_activityVehicleTax,
          date: tax.date,
          amount: money.format(tax.amount),
        ),
      for (final inspection in car.inspectionDatas)
        _ActivityItem(
          icon: Icons.fact_check_outlined,
          color: AppColors.categoryInspection,
          title: l10n.home_activityInspection,
          date: inspection.date,
          amount: money.format(inspection.amount ?? 0),
        ),
      for (final insurance in car.insuranceDatas)
        _ActivityItem(
          icon: Icons.description_outlined,
          color: AppColors.categoryInsurance,
          title: l10n.home_activityInsurance,
          date: insurance.startDate,
          amount: money.format(insurance.premiumAmount),
        ),
    ]..sort((a, b) => b.date.compareTo(a.date));

    final months = List.generate(6, (index) {
      final month = DateTime(now.year, now.month - 5 + index);
      return _monthSpend(car, month);
    });

    return _DashboardData(
      currency: currency,
      insuranceDays: car.daysUntilNextInsuranceExpiration,
      inspectionDays: car.daysUntilNextInspection,
      taxDays: car.daysUntilNextTaxDue,
      upcoming: dueItems.take(3).toList(),
      recentActivity: activity.take(4).toList(),
      monthlySeries: months,
      currentMonthTotal: months.last,
    );
  }

  String formatMoney(double value) =>
      NumberFormat.simpleCurrency(name: currency).format(value);

  static double _monthSpend(Car car, DateTime month) {
    bool isSameMonth(DateTime date) =>
        date.year == month.year && date.month == month.month;

    return car.fuel
            .where((entry) => isSameMonth(entry.date))
            .fold<double>(0, (sum, entry) => sum + entry.totalCost) +
        car.insuranceDatas
            .where((entry) => isSameMonth(entry.startDate))
            .fold<double>(0, (sum, entry) => sum + entry.premiumAmount) +
        car.inspectionDatas
            .where((entry) => isSameMonth(entry.date))
            .fold<double>(0, (sum, entry) => sum + (entry.amount ?? 0)) +
        car.taxDatas
            .where((entry) => isSameMonth(entry.date))
            .fold<double>(0, (sum, entry) => sum + entry.amount) +
        car.repairDatas
            .where((entry) => isSameMonth(entry.date))
            .fold<double>(0, (sum, entry) => sum + entry.amount) +
        car.fineDatas
            .where((entry) => isSameMonth(entry.date))
            .fold<double>(0, (sum, entry) => sum + entry.amount);
  }
}

class _DueItem {
  const _DueItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.days,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final int days;
}

class _ActivityItem {
  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.date,
    required this.amount,
  });

  final IconData icon;
  final Color color;
  final String title;
  final DateTime date;
  final String amount;
}
