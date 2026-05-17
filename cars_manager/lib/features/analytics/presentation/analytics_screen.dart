import 'dart:math' as math;

import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/features/analytics/domain/export_service.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(carsControllerProvider);
    final currency = ref.watch(appSettingsProvider).currency;
    final l10n = AppLocalizations.of(context)!;
    final data = _AnalyticsData.fromCars(cars, currency);

    Future<void> exportData() async {
      final csv = ExportService.carsToCSV(cars);
      final filename =
          'cars_export_${DateTime.now().millisecondsSinceEpoch}.csv';
      try {
        await ExportService.shareCSV(csv, filename);
      } catch (error) {
        if (!context.mounted) return;
        AppSnackBar.show(
          context,
          l10n.analytics_exportFailed('$error'),
          isError: true,
        );
      }
    }

    if (cars.isEmpty) {
      return const SafeArea(
        child: EmptyState(
          icon: Icons.insights_rounded,
          title: 'No analytics yet',
          subtitle:
              'Add a car and start logging fuel or expenses to unlock insights.',
        ),
      );
    }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 920;
          final content = isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _InsightStrip(insights: data.insights),
                          const SizedBox(height: AppSpacing.xl),
                          _CostOverview(data: data),
                          const SizedBox(height: AppSpacing.xl),
                          _MonthlyTrendTable(data: data),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _CategoryBreakdown(data: data),
                          const SizedBox(height: AppSpacing.xl),
                          _CarComparison(data: data),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _InsightStrip(insights: data.insights),
                    const SizedBox(height: AppSpacing.xl),
                    _CostOverview(data: data),
                    const SizedBox(height: AppSpacing.xl),
                    _CategoryBreakdown(data: data),
                    const SizedBox(height: AppSpacing.xl),
                    _CarComparison(data: data),
                    const SizedBox(height: AppSpacing.xl),
                    _MonthlyTrendTable(data: data),
                  ],
                );

          return ListView(
            padding: EdgeInsets.all(isWide ? AppSpacing.xxl : AppSpacing.lg),
            children: [
              _HeroTotalCard(
                data: data,
                onExport: exportData,
                carsCount: cars.length,
              ),
              const SizedBox(height: AppSpacing.xl),
              content,
            ],
          );
        },
      ),
    );
  }
}

class _HeroTotalCard extends StatelessWidget {
  const _HeroTotalCard({
    required this.data,
    required this.onExport,
    required this.carsCount,
  });

  final _AnalyticsData data;
  final VoidCallback onExport;
  final int carsCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final fg = cs.onInverseSurface;
    final fgMuted = cs.onInverseSurface.withValues(alpha: 0.60);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.inverseSurface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL TRACKED',
                  style: TextStyle(
                    color: fgMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.money.format(data.totalSpend),
                  style: TextStyle(
                    color: fg,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$carsCount ${carsCount == 1 ? 'vehicle' : 'vehicles'} · last 12 months',
                  style: TextStyle(
                    color: fgMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onExport,
            icon: const Icon(Icons.download_rounded),
            color: fg,
            tooltip: 'Export CSV',
          ),
        ],
      ),
    );
  }
}

class _InsightStrip extends StatelessWidget {
  const _InsightStrip({required this.insights});

  final List<_Insight> insights;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: insights.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final insight = insights[index];
          return SizedBox(
            width: 280,
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(insight.icon, color: insight.color),
                  const Spacer(),
                  Text(
                    insight.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    insight.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CostOverview extends StatelessWidget {
  const _CostOverview({required this.data});

  final _AnalyticsData data;

  @override
  Widget build(BuildContext context) {
    final maxValue = math.max(
      1,
      data.monthlyTotals.map((m) => m.total).fold<double>(0, math.max),
    );

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Total cost overview',
            trailing: data.money.format(data.totalSpend),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < data.monthlyTotals.length; i++) ...[
                  Expanded(
                    child: _MonthColumn(
                      month: data.monthlyTotals[i],
                      heightFactor: data.monthlyTotals[i].total / maxValue,
                      active: i == data.monthlyTotals.length - 1,
                    ),
                  ),
                  if (i != data.monthlyTotals.length - 1)
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

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({required this.data});

  final _AnalyticsData data;

  @override
  Widget build(BuildContext context) {
    final maxValue = math.max(
      1,
      data.categories.map((item) => item.value).fold<double>(0, math.max),
    );

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Category breakdown'),
          const SizedBox(height: AppSpacing.lg),
          if (data.categories.every((item) => item.value == 0))
            const _MutedText('No cost categories have data yet.')
          else
            for (final item in data.categories.where(
              (item) => item.value > 0,
            )) ...[
              _HorizontalBar(
                label: item.label,
                value: data.money.format(item.value),
                color: item.color,
                factor: item.value / maxValue,
              ),
              if (item !=
                  data.categories.where((entry) => entry.value > 0).last)
                const SizedBox(height: AppSpacing.md),
            ],
        ],
      ),
    );
  }
}

class _CarComparison extends StatelessWidget {
  const _CarComparison({required this.data});

  final _AnalyticsData data;

  @override
  Widget build(BuildContext context) {
    // Not useful as a "comparison" with only one vehicle.
    if (data.carTotals.length <= 1) return const SizedBox.shrink();

    final maxValue = math.max(
      1,
      data.carTotals.map((item) => item.value).fold<double>(0, math.max),
    );

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Cost per car'),
          const SizedBox(height: AppSpacing.lg),
          for (final item in data.carTotals) ...[
            _HorizontalBar(
              label: item.label,
              value: data.money.format(item.value),
              color: item.color,
              factor: item.value / maxValue,
            ),
            if (item != data.carTotals.last)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _MonthlyTrendTable extends StatelessWidget {
  const _MonthlyTrendTable({required this.data});

  final _AnalyticsData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w800,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final cellStyle = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final mutedStyle = cellStyle?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    Widget row({
      required String month,
      required String fuel,
      required String maint,
      required String fixed,
      required String total,
      TextStyle? style,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(month, style: style)),
            Expanded(
              flex: 3,
              child: Text(fuel, style: style, textAlign: TextAlign.right),
            ),
            Expanded(
              flex: 3,
              child: Text(maint, style: style, textAlign: TextAlign.right),
            ),
            Expanded(
              flex: 3,
              child: Text(fixed, style: style, textAlign: TextAlign.right),
            ),
            Expanded(
              flex: 3,
              child: Text(total, style: style, textAlign: TextAlign.right),
            ),
          ],
        ),
      );
    }

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Monthly trend'),
          const SizedBox(height: AppSpacing.md),
          row(
            month: 'Month',
            fuel: 'Fuel',
            maint: 'Maint.',
            fixed: 'Fixed',
            total: 'Total',
            style: headerStyle,
          ),
          const Divider(height: AppSpacing.md),
          for (final month in data.monthlyTotals.reversed)
            row(
              month: DateFormat.MMM().format(month.month),
              fuel: data.money.format(month.fuel),
              maint: data.money.format(month.maintenance),
              fixed: data.money.format(month.fixed),
              total: data.money.format(month.total),
              style: month == data.monthlyTotals.last ? cellStyle : mutedStyle,
            ),
        ],
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final String? trailing;

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
        if (trailing != null)
          Text(
            trailing!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}

class _MonthColumn extends StatelessWidget {
  const _MonthColumn({
    required this.month,
    required this.heightFactor,
    required this.active,
  });

  final _MonthlyTotal month;
  final double heightFactor;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: math.max(0.06, heightFactor),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: active
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          DateFormat.MMM().format(month.month),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _HorizontalBar extends StatelessWidget {
  const _HorizontalBar({
    required this.label,
    required this.value,
    required this.color,
    required this.factor,
  });

  final String label;
  final String value;
  final Color color;
  final double factor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: factor.clamp(0.02, 1),
            color: color,
            backgroundColor: color.withValues(alpha: 0.12),
          ),
        ),
      ],
    );
  }
}

class _MutedText extends StatelessWidget {
  const _MutedText(this.text);

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

class _AnalyticsData {
  const _AnalyticsData({
    required this.money,
    required this.totalSpend,
    required this.categories,
    required this.carTotals,
    required this.monthlyTotals,
    required this.insights,
  });

  final NumberFormat money;
  final double totalSpend;
  final List<_LabeledValue> categories;
  final List<_LabeledValue> carTotals;
  final List<_MonthlyTotal> monthlyTotals;
  final List<_Insight> insights;

  factory _AnalyticsData.fromCars(List<Car> cars, String currency) {
    final money = NumberFormat.simpleCurrency(name: currency);
    final totalFuel = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalFuelCost,
    );
    final totalInsurance = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalPaidInsurances,
    );
    final totalInspection = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalPaidInspections,
    );
    final totalTax = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalPaidTaxes,
    );
    final totalRepair = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalPaidRepairs,
    );
    final totalFine = cars.fold<double>(
      0,
      (sum, car) => sum + car.totalPaidFines,
    );

    final categories = [
      _LabeledValue('Fuel', totalFuel, AppColors.categoryFuel),
      _LabeledValue('Insurance', totalInsurance, AppColors.categoryInsurance),
      _LabeledValue(
        'Inspection',
        totalInspection,
        AppColors.categoryInspection,
      ),
      _LabeledValue('Tax', totalTax, AppColors.categoryTax),
      _LabeledValue('Repairs', totalRepair, AppColors.categoryRepair),
      _LabeledValue('Fines', totalFine, AppColors.categoryFine),
    ]..sort((a, b) => b.value.compareTo(a.value));

    final carTotals = [
      for (var i = 0; i < cars.length; i++)
        _LabeledValue(
          cars[i].name,
          cars[i].totalFuelCost + cars[i].totalPaidExpenses,
          AppColors.chartColors[i % AppColors.chartColors.length],
        ),
    ]..sort((a, b) => b.value.compareTo(a.value));

    final now = DateTime.now();
    final monthlyTotals = [
      for (var i = 5; i >= 0; i--)
        _MonthlyTotal.fromCars(cars, DateTime(now.year, now.month - i)),
    ];

    final totalSpend = categories.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );
    final topCategory = categories.firstWhere(
      (item) => item.value > 0,
      orElse: () =>
          const _LabeledValue('No spend yet', 0, AppColors.categoryInspection),
    );
    final upcomingCount = cars
        .expand(
          (car) => [
            car.daysUntilNextInsuranceExpiration,
            car.daysUntilNextInspection,
            car.daysUntilNextTaxDue,
          ],
        )
        .where((days) => days != null && days <= 30)
        .length;
    final latestMonth = monthlyTotals.last.total;
    final previousMonth = monthlyTotals.length > 1
        ? monthlyTotals[monthlyTotals.length - 2].total
        : 0;
    final delta = previousMonth == 0
        ? 0
        : ((latestMonth - previousMonth) / previousMonth * 100);

    return _AnalyticsData(
      money: money,
      totalSpend: totalSpend,
      categories: categories,
      carTotals: carTotals,
      monthlyTotals: monthlyTotals,
      insights: [
        _Insight(
          icon: Icons.payments_rounded,
          color: AppColors.accentLight,
          title: '${money.format(totalSpend)} tracked',
          subtitle: 'Across every vehicle and category',
        ),
        _Insight(
          icon: Icons.trending_up_rounded,
          color: delta > 0 ? AppColors.warnLight : AppColors.successLight,
          title: previousMonth == 0
              ? 'This month is active'
              : '${delta.abs().toStringAsFixed(0)}% ${delta >= 0 ? 'up' : 'down'}',
          subtitle: 'Compared with last month',
        ),
        _Insight(
          icon: Icons.category_rounded,
          color: topCategory.color,
          title: topCategory.label,
          subtitle: topCategory.value == 0
              ? 'Start logging to see patterns'
              : 'Largest spend category',
        ),
        _Insight(
          icon: Icons.notifications_active_rounded,
          color: upcomingCount > 0
              ? AppColors.warnLight
              : AppColors.successLight,
          title: upcomingCount == 0
              ? 'No urgent deadlines'
              : '$upcomingCount deadlines soon',
          subtitle: 'Due in the next 30 days',
        ),
      ],
    );
  }
}

class _MonthlyTotal {
  const _MonthlyTotal({
    required this.month,
    required this.fuel,
    required this.maintenance,
    required this.fixed,
  });

  final DateTime month;
  final double fuel;
  final double maintenance;
  final double fixed;

  double get total => fuel + maintenance + fixed;

  factory _MonthlyTotal.fromCars(List<Car> cars, DateTime month) {
    bool sameMonth(DateTime date) =>
        date.year == month.year && date.month == month.month;

    return _MonthlyTotal(
      month: month,
      fuel: cars.fold<double>(
        0,
        (sum, car) =>
            sum +
            car.fuel
                .where((entry) => sameMonth(entry.date))
                .fold<double>(0, (value, entry) => value + entry.totalCost),
      ),
      maintenance: cars.fold<double>(
        0,
        (sum, car) =>
            sum +
            car.repairDatas
                .where((entry) => sameMonth(entry.date))
                .fold<double>(0, (value, entry) => value + entry.amount) +
            car.inspectionDatas
                .where((entry) => sameMonth(entry.date))
                .fold<double>(0, (value, entry) => value + (entry.amount ?? 0)),
      ),
      fixed: cars.fold<double>(
        0,
        (sum, car) =>
            sum +
            car.insuranceDatas
                .where((entry) => sameMonth(entry.startDate))
                .fold<double>(
                  0,
                  (value, entry) => value + entry.premiumAmount,
                ) +
            car.taxDatas
                .where((entry) => sameMonth(entry.date))
                .fold<double>(0, (value, entry) => value + entry.amount) +
            car.fineDatas
                .where((entry) => sameMonth(entry.date))
                .fold<double>(0, (value, entry) => value + entry.amount),
      ),
    );
  }
}

class _LabeledValue {
  const _LabeledValue(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}

class _Insight {
  const _Insight({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
}
