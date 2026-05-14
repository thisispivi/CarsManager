import 'dart:math' as math;

import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.analytics_exportFailed('$error'))),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.analytics_title,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${cars.length} ${cars.length == 1 ? 'vehicle' : 'vehicles'} tracked',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: exportData,
                    icon: const Icon(Icons.download_rounded),
                    label: Text(l10n.analytics_exportCsv),
                  ),
                ],
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
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Monthly trend'),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              dataTextStyle: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
              columns: const [
                DataColumn(label: Text('Month')),
                DataColumn(label: Text('Fuel'), numeric: true),
                DataColumn(label: Text('Maintenance'), numeric: true),
                DataColumn(label: Text('Fixed'), numeric: true),
                DataColumn(label: Text('Total'), numeric: true),
              ],
              rows: [
                for (final month in data.monthlyTotals.reversed)
                  DataRow(
                    cells: [
                      DataCell(Text(DateFormat.MMM().format(month.month))),
                      DataCell(Text(data.money.format(month.fuel))),
                      DataCell(Text(data.money.format(month.maintenance))),
                      DataCell(Text(data.money.format(month.fixed))),
                      DataCell(Text(data.money.format(month.total))),
                    ],
                  ),
              ],
            ),
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
      padding: const EdgeInsets.all(AppSpacing.lg),
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
              color: AppColors.brandPrimary,
              fontWeight: FontWeight.w800,
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
                      ? AppColors.brandPrimary
                      : AppColors.brandPrimary.withValues(alpha: 0.18),
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
      _LabeledValue('Fuel', totalFuel, AppColors.success),
      _LabeledValue('Insurance', totalInsurance, AppColors.info),
      _LabeledValue('Inspection', totalInspection, AppColors.warning),
      _LabeledValue('Tax', totalTax, const Color(0xFF06B6D4)),
      _LabeledValue('Repairs', totalRepair, const Color(0xFF8B5CF6)),
      _LabeledValue('Fines', totalFine, AppColors.danger),
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
      orElse: () => const _LabeledValue('No spend yet', 0, AppColors.info),
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
          color: AppColors.brandPrimary,
          title: '${money.format(totalSpend)} tracked',
          subtitle: 'Across every vehicle and category',
        ),
        _Insight(
          icon: Icons.trending_up_rounded,
          color: delta > 0 ? AppColors.warning : AppColors.success,
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
          color: upcomingCount > 0 ? AppColors.warning : AppColors.success,
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
