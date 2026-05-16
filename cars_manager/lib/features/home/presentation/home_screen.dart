import 'dart:math' as math;

import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              title: 'Add your first car',
              subtitle:
                  'Track fuel, expenses, maintenance, and deadlines from one calm dashboard.',
              actionLabel: 'Add Car',
              onAction: openAddForm,
            ),
          ),
        ),
      );
    }

    final dashboard = _DashboardData.fromCar(activeCar, currency);

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
                            _ActiveCarHero(car: activeCar, data: dashboard),
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
                            _QuickActions(
                              activeCar: activeCar,
                              onAddCar: openAddForm,
                            ),
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
                      _ActiveCarHero(car: activeCar, data: dashboard),
                      const SizedBox(height: AppSpacing.xl),
                      _QuickActions(
                        activeCar: activeCar,
                        onAddCar: openAddForm,
                      ),
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

class _ActiveCarHero extends StatelessWidget {
  const _ActiveCarHero({required this.car, required this.data});

  final Car car;
  final _DashboardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final hasImage =
        (car.imageBase64 != null && car.imageBase64!.isNotEmpty) ||
        (car.imageUrl != null && car.imageUrl!.isNotEmpty);

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      onTap: () => context.push('/car/${car.id}'),
      child: _DashboardCard(
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
                        backgroundColor: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.zero,
                        primaryColor: colors.primary,
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
                              fontWeight: FontWeight.w600,
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
                child: Builder(
                  builder: (context) {
                    int urgency(int? d) =>
                        d == null ? 9999 : (d < 0 ? -9999 : d);
                    final chips = [
                      ('Insurance', data.insuranceDays),
                      ('Inspection', data.inspectionDays),
                      ('Tax', data.taxDays),
                    ]..sort((a, b) => urgency(a.$2).compareTo(urgency(b.$2)));
                    return Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final c in chips)
                          _StatusChip(label: c.$1, days: c.$2),
                      ],
                    );
                  },
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
  const _QuickActions({required this.activeCar, required this.onAddCar});

  final Car activeCar;
  final VoidCallback onAddCar;

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(title: 'Quick actions'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _ActionButton(
                icon: Icons.local_gas_station_rounded,
                label: 'Fuel',
                onTap: () => context.push('/car/${activeCar.id}/fuel'),
              ),
              _ActionButton(
                icon: Icons.receipt_long_rounded,
                label: 'Expense',
                onTap: () => context.push('/car/${activeCar.id}/expenses'),
              ),
              _ActionButton(
                icon: Icons.directions_car_filled_rounded,
                label: 'Add Car',
                onTap: onAddCar,
              ),
              _ActionButton(
                icon: Icons.grid_view_rounded,
                label: 'All cars',
                onTap: () => context.go('/garage'),
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
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(title: 'Upcoming'),
          const SizedBox(height: AppSpacing.md),
          if (items.isEmpty)
            const _MutedLine(
              icon: Icons.check_circle_outline_rounded,
              text: 'No upcoming deadlines yet.',
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
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: _SectionTitle(title: 'Recent activity')),
              if (items.isNotEmpty)
                TextButton(
                  onPressed: () => context.push('/car/$carId/timeline'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                  ),
                  child: const Text('See all'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (items.isEmpty)
            const _MutedLine(
              icon: Icons.history_rounded,
              text: 'New fuel and expense entries will appear here.',
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
    final theme = Theme.of(context);
    final maxValue = math.max(1, data.monthlySeries.reduce(math.max));
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
          const _SectionTitle(title: 'Monthly summary'),
          const SizedBox(height: AppSpacing.lg),
          Text(
            data.formatMoney(data.currentMonthTotal),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Spent this month across fuel and expenses',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: onTap,
      child: Container(
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
            Icon(icon, size: 18, color: AppColors.brandPrimary),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
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

class _DueRow extends StatelessWidget {
  const _DueRow({required this.item});

  final _DueItem item;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(item.days);
    final daysText = item.days < 0 ? 'Overdue' : '${item.days}d';
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withValues(alpha: 0.12),
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
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
            daysText,
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

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item});

  final _ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: item.color.withValues(alpha: 0.12),
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
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                DateFormat.yMMMd().format(item.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          item.amount,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
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
              fontWeight: FontWeight.w600,
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
                      ? AppColors.brandPrimary
                      : AppColors.brandPrimary.withValues(alpha: 0.18),
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
                ? AppColors.brandPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
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

  factory _DashboardData.fromCar(Car car, String currency) {
    final now = DateTime.now();
    final money = NumberFormat.simpleCurrency(name: currency);

    final dueItems = [
      if (car.nextInsuranceExpirationDate != null)
        _DueItem(
          icon: Icons.description_outlined,
          title: 'Insurance renewal',
          subtitle: DateFormat.yMMMd().format(car.nextInsuranceExpirationDate!),
          days: car.daysUntilNextInsuranceExpiration!,
        ),
      if (car.nextInspectionDate != null)
        _DueItem(
          icon: Icons.fact_check_outlined,
          title: 'Inspection',
          subtitle: DateFormat.yMMMd().format(car.nextInspectionDate!),
          days: car.daysUntilNextInspection!,
        ),
      if (car.nextTaxDueDate != null)
        _DueItem(
          icon: Icons.paid_outlined,
          title: 'Vehicle tax',
          subtitle: DateFormat.yMMMd().format(car.nextTaxDueDate!),
          days: car.daysUntilNextTaxDue!,
        ),
    ]..sort((a, b) => a.days.compareTo(b.days));

    final activity = <_ActivityItem>[
      for (final entry in car.fuel)
        _ActivityItem(
          icon: Icons.local_gas_station_rounded,
          color: AppColors.success,
          title: 'Fuel entry',
          date: entry.date,
          amount: money.format(entry.totalCost),
        ),
      for (final repair in car.repairDatas)
        _ActivityItem(
          icon: Icons.build_rounded,
          color: const Color(0xFF8B5CF6),
          title: 'Repair',
          date: repair.date,
          amount: money.format(repair.amount),
        ),
      for (final fine in car.fineDatas)
        _ActivityItem(
          icon: Icons.report_gmailerrorred_rounded,
          color: AppColors.danger,
          title: 'Fine',
          date: fine.date,
          amount: money.format(fine.amount),
        ),
      for (final tax in car.taxDatas)
        _ActivityItem(
          icon: Icons.paid_outlined,
          color: const Color(0xFF06B6D4),
          title: 'Vehicle tax',
          date: tax.date,
          amount: money.format(tax.amount),
        ),
      for (final inspection in car.inspectionDatas)
        _ActivityItem(
          icon: Icons.fact_check_outlined,
          color: AppColors.warning,
          title: 'Inspection',
          date: inspection.date,
          amount: money.format(inspection.amount ?? 0),
        ),
      for (final insurance in car.insuranceDatas)
        _ActivityItem(
          icon: Icons.description_outlined,
          color: AppColors.info,
          title: 'Insurance',
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

Color _statusColor(int? days) {
  if (days == null) return AppColors.info;
  if (days < 0) return AppColors.danger;
  if (days <= 30) return AppColors.warning;
  return AppColors.success;
}
