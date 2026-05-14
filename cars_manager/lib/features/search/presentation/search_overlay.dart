import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

Future<void> showSearchOverlay(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 700) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const SearchOverlay(),
      ),
    );
  }

  return showDialog<void>(
    context: context,
    builder: (_) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 720),
        child: const SearchOverlay(isDialog: true),
      ),
    ),
  );
}

class SearchOverlay extends ConsumerStatefulWidget {
  const SearchOverlay({super.key, this.isDialog = false});

  final bool isDialog;

  @override
  ConsumerState<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ConsumerState<SearchOverlay> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _query = _controller.text.trim());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cars = ref.watch(carsControllerProvider);
    final currency = ref.watch(appSettingsProvider).currency;
    final results = _SearchResults.fromCars(cars, currency, _query);
    final theme = Theme.of(context);

    return Material(
      color: widget.isDialog ? theme.cardColor : theme.colorScheme.surface,
      borderRadius: widget.isDialog
          ? BorderRadius.circular(AppRadius.xl)
          : BorderRadius.zero,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search cars, expenses, entries...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Clear search',
                                icon: const Icon(Icons.close_rounded),
                                onPressed: _controller.clear,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _query.isEmpty
                  ? const _SearchHint()
                  : results.isEmpty
                  ? _NoResults(query: _query)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      children: [
                        if (results.cars.isNotEmpty)
                          _ResultGroup(title: 'Cars', results: results.cars),
                        if (results.entries.isNotEmpty)
                          _ResultGroup(
                            title: 'Entries',
                            results: results.entries,
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultGroup extends StatelessWidget {
  const _ResultGroup({required this.title, required this.results});

  final String title;
  final List<_SearchResult> results;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          for (final result in results) ...[
            _ResultTile(result: result),
            if (result != results.last) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({required this.result});

  final _SearchResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () {
          Navigator.of(context).pop();
          context.go(result.route);
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: result.color.withValues(alpha: 0.12),
                child: Icon(result.icon, color: result.color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      result.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (result.trailing != null) ...[
                const SizedBox(width: AppSpacing.md),
                Text(
                  result.trailing!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Text(
          'Try a car name, license plate, expense type, date, or amount.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 40,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No results for "$query"',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Try searching for a car name, plate, or expense category.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults {
  const _SearchResults({required this.cars, required this.entries});

  final List<_SearchResult> cars;
  final List<_SearchResult> entries;

  bool get isEmpty => cars.isEmpty && entries.isEmpty;

  factory _SearchResults.fromCars(
    List<Car> cars,
    String currency,
    String query,
  ) {
    final normalized = query.toLowerCase();
    final money = NumberFormat.simpleCurrency(name: currency);
    final date = DateFormat.yMMMd();

    bool matches(Iterable<Object?> values) {
      return values
          .whereType<Object>()
          .map((value) => value.toString().toLowerCase())
          .any((value) => value.contains(normalized));
    }

    final carResults = <_SearchResult>[
      for (final car in cars)
        if (matches([
          car.name,
          car.manufacture,
          car.model,
          car.licensePlate,
          car.yearOfManufacture,
          car.fuelType?.name,
        ]))
          _SearchResult(
            icon: Icons.directions_car_filled_rounded,
            color: AppColors.brandPrimary,
            title: car.name,
            subtitle:
                '${car.manufacture} ${car.model} • ${car.licensePlate.isEmpty ? car.yearOfManufacture : car.licensePlate}',
            route: '/car/${car.id}',
          ),
    ];

    final entryResults = <_SearchResult>[
      for (final car in cars) ...[
        for (final entry in car.fuel)
          if (matches([
            'fuel',
            car.name,
            date.format(entry.date),
            entry.liters,
            entry.totalCost,
            money.format(entry.totalCost),
            entry.fuelType.name,
          ]))
            _SearchResult(
              icon: Icons.local_gas_station_rounded,
              color: AppColors.success,
              title: 'Fuel entry',
              subtitle: '${car.name} • ${date.format(entry.date)}',
              trailing: money.format(entry.totalCost),
              route: '/car/${car.id}',
            ),
        for (final entry in car.insuranceDatas)
          if (matches([
            'insurance',
            car.name,
            date.format(entry.startDate),
            date.format(entry.endDate),
            entry.premiumAmount,
            money.format(entry.premiumAmount),
          ]))
            _SearchResult(
              icon: Icons.description_outlined,
              color: AppColors.info,
              title: 'Insurance',
              subtitle: '${car.name} • ${date.format(entry.startDate)}',
              trailing: money.format(entry.premiumAmount),
              route: '/car/${car.id}',
            ),
        for (final entry in car.inspectionDatas)
          if (matches([
            'inspection',
            car.name,
            date.format(entry.date),
            entry.amount,
            money.format(entry.amount ?? 0),
          ]))
            _SearchResult(
              icon: Icons.fact_check_outlined,
              color: AppColors.warning,
              title: 'Inspection',
              subtitle: '${car.name} • ${date.format(entry.date)}',
              trailing: money.format(entry.amount ?? 0),
              route: '/car/${car.id}',
            ),
        for (final entry in car.taxDatas)
          if (matches([
            'tax',
            car.name,
            date.format(entry.date),
            entry.amount,
            money.format(entry.amount),
          ]))
            _SearchResult(
              icon: Icons.paid_outlined,
              color: const Color(0xFF06B6D4),
              title: 'Vehicle tax',
              subtitle: '${car.name} • ${date.format(entry.date)}',
              trailing: money.format(entry.amount),
              route: '/car/${car.id}',
            ),
        for (final entry in car.repairDatas)
          if (matches([
            'repair',
            car.name,
            entry.description,
            date.format(entry.date),
            entry.amount,
            money.format(entry.amount),
          ]))
            _SearchResult(
              icon: Icons.build_rounded,
              color: const Color(0xFF8B5CF6),
              title: entry.description.isEmpty ? 'Repair' : entry.description,
              subtitle: '${car.name} • ${date.format(entry.date)}',
              trailing: money.format(entry.amount),
              route: '/car/${car.id}',
            ),
        for (final entry in car.fineDatas)
          if (matches([
            'fine',
            car.name,
            date.format(entry.date),
            entry.amount,
            money.format(entry.amount),
          ]))
            _SearchResult(
              icon: Icons.report_gmailerrorred_rounded,
              color: AppColors.danger,
              title: 'Fine',
              subtitle: '${car.name} • ${date.format(entry.date)}',
              trailing: money.format(entry.amount),
              route: '/car/${car.id}',
            ),
      ],
    ];

    return _SearchResults(
      cars: carResults.take(8).toList(),
      entries: entryResults.take(16).toList(),
    );
  }
}

class _SearchResult {
  const _SearchResult({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.route,
    this.trailing,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String route;
  final String? trailing;
}
