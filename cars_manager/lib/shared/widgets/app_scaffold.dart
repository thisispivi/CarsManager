import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/core/responsive/screen_size.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/onboarding/domain/onboarding_controller.dart';
import 'package:cars_manager/features/search/presentation/search_overlay.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Responsive app shell.
///
/// Below 600px it uses a bottom navigation bar; from 600px it switches to a
/// rail, and at 1200px the rail extends into a logo-led desktop sidebar.
class AppScaffold extends ConsumerWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  static List<_AppDestination> _getDestinations(AppLocalizations l10n) => [
    const _AppDestination('/', Icons.home_rounded, 'Home'),
    _AppDestination(
      '/garage',
      Icons.directions_car_filled_rounded,
      l10n.nav_garage,
    ),
    _AppDestination('/analytics', Icons.bar_chart_rounded, l10n.nav_analytics),
    _AppDestination('/settings', Icons.settings_rounded, l10n.settings_title),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = _getDestinations(l10n);
    final location = GoRouterState.of(context).uri.path;
    final hasSeenOnboarding = ref.watch(onboardingControllerProvider);

    final shouldShowOnboardingOnly =
        location == '/' && hasSeenOnboarding.valueOrNull == false;

    if (shouldShowOnboardingOnly) {
      return child;
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () =>
            showSearchOverlay(context),
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): () =>
            showSearchOverlay(context),
        const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
            _handleCreateShortcut(context),
        const SingleActivator(LogicalKeyboardKey.keyN, meta: true): () =>
            _handleCreateShortcut(context),
        const SingleActivator(LogicalKeyboardKey.digit1, control: true): () =>
            context.go('/'),
        const SingleActivator(LogicalKeyboardKey.digit2, control: true): () =>
            context.go('/garage'),
        const SingleActivator(LogicalKeyboardKey.digit3, control: true): () =>
            context.go('/analytics'),
        const SingleActivator(LogicalKeyboardKey.digit1, meta: true): () =>
            context.go('/'),
        const SingleActivator(LogicalKeyboardKey.digit2, meta: true): () =>
            context.go('/garage'),
        const SingleActivator(LogicalKeyboardKey.digit3, meta: true): () =>
            context.go('/analytics'),
        const SingleActivator(LogicalKeyboardKey.comma, control: true): () =>
            context.go('/settings'),
        const SingleActivator(LogicalKeyboardKey.comma, meta: true): () =>
            context.go('/settings'),
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final selectedIndex = _selectedIndex(context);
          final screenSize = screenSizeForWidth(constraints.maxWidth);
          final isRail = !screenSize.isCompact;
          final isSidebar = screenSize.isDesktop;
          final mobileSelectedIndex = selectedIndex.clamp(0, 3);

          final mobileDestinations = destinations;
          final scaffold = Scaffold(
            body: child,
            bottomNavigationBar: isRail
                ? null
                : DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: NavigationBar(
                      selectedIndex: mobileSelectedIndex,
                      onDestinationSelected: (index) =>
                          context.go(mobileDestinations[index].path),
                      destinations: [
                        for (final destination in mobileDestinations)
                          NavigationDestination(
                            icon: Icon(destination.icon),
                            label: destination.label,
                          ),
                      ],
                    ),
                  ),
          );

          if (!isRail) {
            return scaffold;
          }

          return Scaffold(
            body: Row(
              children: [
                if (isSidebar)
                  _DesktopSidebar(
                    selectedIndex: selectedIndex,
                    destinations: destinations,
                  )
                else
                  _NavigationRailShell(
                    selectedIndex: selectedIndex,
                    destinations: destinations,
                    extended: screenSize == ScreenSize.expanded,
                  ),
                Expanded(child: scaffold),
              ],
            ),
          );
        },
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final l10n = AppLocalizations.of(context)!;
    final destinations = _getDestinations(l10n);
    if (location.startsWith('/car/')) return 1;
    final index = destinations.indexWhere((destination) {
      if (destination.path == '/') {
        return location == '/';
      }
      return location.startsWith(destination.path);
    });
    return index == -1 ? 0 : index;
  }

  void _handleCreateShortcut(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final vehicleMatch = RegExp(r'^/car/([^/]+)').firstMatch(location);
    if (vehicleMatch != null) {
      // On vehicle detail: jump to fuel tab so user can add an entry
      context.go('/car/${vehicleMatch.group(1)!}/fuel');
      return;
    }
    // Everywhere else: go to garage where the FAB is available
    context.go('/garage');
  }
}

class _NavigationRailShell extends StatelessWidget {
  const _NavigationRailShell({
    required this.selectedIndex,
    required this.destinations,
    required this.extended,
  });

  final int selectedIndex;
  final List<_AppDestination> destinations;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: NavigationRail(
        selectedIndex: selectedIndex,
        extended: extended,
        minExtendedWidth: 196,
        leading: const SizedBox(height: 16),
        onDestinationSelected: (index) => context.go(destinations[index].path),
        destinations: [
          for (final destination in destinations)
            NavigationRailDestination(
              icon: Icon(destination.icon),
              label: Text(destination.label),
            ),
        ],
      ),
    );
  }
}

class _DesktopSidebar extends ConsumerWidget {
  const _DesktopSidebar({
    required this.selectedIndex,
    required this.destinations,
  });

  final int selectedIndex;
  final List<_AppDestination> destinations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cars = ref.watch(carsControllerProvider);
    final activeCar = ref.watch(activeCarProvider);

    return Container(
      width: 252,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.35 : 0.5,
        ),
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, AppSpacing.xl),
                child: Image.asset(
                  'assets/icons/CarsManagerLogoFull.png',
                  height: 34,
                  alignment: Alignment.centerLeft,
                ),
              ),
              _SidebarCarSwitcher(cars: cars, activeCarId: activeCar?.id),
              const SizedBox(height: AppSpacing.xl),
              for (var i = 0; i < destinations.length; i++) ...[
                _SidebarDestinationTile(
                  destination: destinations[i],
                  selected: selectedIndex == i,
                  onTap: () => context.go(destinations[i].path),
                ),
                if (i == 2) const _SidebarDivider(),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarCarSwitcher extends ConsumerWidget {
  const _SidebarCarSwitcher({required this.cars, required this.activeCarId});

  final List<Car> cars;
  final String? activeCarId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (cars.isEmpty) {
      return OutlinedButton.icon(
        onPressed: () => context.go('/garage/add'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Car'),
      );
    }
    final selectedCarId = cars.any((car) => car.id == activeCarId)
        ? activeCarId
        : cars.first.id;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.colorScheme.outline, width: 0.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCarId,
          isExpanded: true,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          icon: const Icon(Icons.expand_more_rounded),
          items: [
            for (final car in cars)
              DropdownMenuItem<String>(
                value: car.id,
                child: Row(
                  children: [
                    const Icon(Icons.directions_car_filled_rounded, size: 18),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        car.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          onChanged: (id) {
            if (id == null) return;
            ref.read(activeCarControllerProvider.notifier).select(id);
            context.go('/car/$id');
          },
        ),
      ),
    );
  }
}

class _SidebarDestinationTile extends StatelessWidget {
  const _SidebarDestinationTile({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final _AppDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: selected
            ? theme.colorScheme.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Icon(destination.icon, color: color, size: 22),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    destination.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: color,
                      fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarDivider extends StatelessWidget {
  const _SidebarDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Divider(color: Theme.of(context).dividerColor),
    );
  }
}

class _AppDestination {
  const _AppDestination(this.path, this.icon, this.label);

  final String path;
  final IconData icon;
  final String label;
}
