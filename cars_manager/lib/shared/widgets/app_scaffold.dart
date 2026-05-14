import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/features/search/presentation/search_overlay.dart';
import 'package:cars_manager/presentation/common/widgets/car_switcher_header.dart';
import 'package:cars_manager/presentation/widgets/notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Responsive app shell.
///
/// Below 600px it uses a bottom navigation bar; from 600px it switches to a
/// rail, and at 1200px the rail extends into a logo-led desktop sidebar.
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  static List<_AppDestination> _getDestinations(AppLocalizations l10n) => [
    const _AppDestination('/', Icons.dashboard_rounded, 'Home'),
    _AppDestination(
      '/garage',
      Icons.directions_car_filled_rounded,
      l10n.nav_garage,
    ),
    _AppDestination('/analytics', Icons.insights_rounded, l10n.nav_analytics),
    _AppDestination('/settings', Icons.settings_rounded, l10n.settings_title),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = _getDestinations(l10n);

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
          final isRail = constraints.maxWidth >= 600;
          final isSidebar = constraints.maxWidth >= 1200;
          final mobileSelectedIndex = selectedIndex > 2 ? 0 : selectedIndex;

          final mobileDestinations = destinations.take(3).toList();
          final scaffold = Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 16,
              title: const CarSwitcherHeader(),
              actions: [
                IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () => showSearchOverlay(context),
                ),
                const NotificationCenter(),
                IconButton(
                  tooltip: l10n.settings_title,
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => context.go('/settings'),
                ),
              ],
            ),
            body: child,
            bottomNavigationBar: isRail
                ? null
                : NavigationBar(
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
          );

          if (!isRail) {
            return scaffold;
          }

          return Scaffold(
            body: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                      right: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: NavigationRail(
                    selectedIndex: selectedIndex,
                    extended: isSidebar,
                    minExtendedWidth: 220,
                    leading: isSidebar
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                            child: Image.asset(
                              'assets/icons/CarsManagerLogoFull.png',
                              height: 32,
                              fit: BoxFit.contain,
                            ),
                          )
                        : const SizedBox(height: 16),
                    onDestinationSelected: (index) =>
                        context.go(destinations[index].path),
                    destinations: [
                      for (final destination in destinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          label: Text(destination.label),
                        ),
                    ],
                  ),
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
      final carId = vehicleMatch.group(1)!;
      if (location.endsWith('/expenses')) {
        context.go('/car/$carId/expenses');
      } else {
        context.go('/car/$carId/fuel');
      }
      return;
    }

    context.go('/garage/add');
  }
}

class _AppDestination {
  const _AppDestination(this.path, this.icon, this.label);

  final String path;
  final IconData icon;
  final String label;
}
