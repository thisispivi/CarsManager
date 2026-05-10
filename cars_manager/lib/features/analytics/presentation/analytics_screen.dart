import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/analytics/domain/analytics_provider.dart';
import 'package:cars_manager/features/analytics/domain/export_service.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(activeCarAnalyticsProvider);
    final cars = ref.watch(carsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: cars.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () async {
                final csv = ExportService.carsToCSV(cars);
                final filename =
                    'cars_export_${DateTime.now().millisecondsSinceEpoch}.csv';
                try {
                  await ExportService.shareCSV(csv, filename);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Export failed: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.download),
              label: const Text('Export CSV'),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          Text('Analytics', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppDimensions.spacing16),
          if (analytics.vehicleName == null)
            Text(l10n.stats_selectCarHint)
          else ...[
            _MetricCard(
              label: 'Total expenses',
              value: analytics.totalExpenses.toString(),
              icon: Icons.payments_rounded,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _MetricCard(
              label: 'Fuel entries',
              value: analytics.fuelEntryCount.toString(),
              icon: Icons.local_gas_station_rounded,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _MetricCard(
              label: 'Tracked vehicle',
              value: analytics.vehicleName!,
              icon: Icons.directions_car_filled_rounded,
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: AppDimensions.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(value, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
