import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/widgets/car_switcher_header.dart';
import 'package:cars_manager/presentation/common/widgets/settings.dart';
import 'package:cars_manager/presentation/widgets/notification_center.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Responsive app shell.
///
/// Below 600px it uses a bottom navigation bar; from 600px it switches to a
/// rail, and at 1200px the rail extends into a logo-led desktop sidebar.
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  static List<_AppDestination> _getDestinations(AppLocalizations l10n) => [
    _AppDestination(
      '/garage',
      Icons.directions_car_filled_rounded,
      l10n.nav_garage,
    ),
    _AppDestination('/fuel', Icons.local_gas_station_rounded, l10n.nav_fuel),
    _AppDestination('/expenses', Icons.payments_rounded, l10n.nav_expenses),
    _AppDestination('/analytics', Icons.insights_rounded, l10n.nav_analytics),
    _AppDestination(
      '/reminders',
      Icons.notifications_active_rounded,
      l10n.nav_reminders,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = _getDestinations(l10n);

    return LayoutBuilder(
      builder: (context, constraints) {
        final selectedIndex = _selectedIndex(context);
        final isRail = constraints.maxWidth >= 600;
        final isSidebar = constraints.maxWidth >= 1200;

        final scaffold = Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            title: const CarSwitcherHeader(),
            actions: [
              const NotificationCenter(),
              IconButton(
                tooltip: l10n.settings_title,
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => _showSettings(context),
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: isRail
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) =>
                      context.go(destinations[index].path),
                  destinations: [
                    for (final destination in destinations)
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
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final l10n = AppLocalizations.of(context)!;
    final destinations = _getDestinations(l10n);
    final index = destinations.indexWhere(
      (destination) => location.startsWith(destination.path),
    );
    return index == -1 ? 0 : index;
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SettingsContent(scrollController: scrollController),
        ),
      ),
    );
  }
}

class _AppDestination {
  const _AppDestination(this.path, this.icon, this.label);

  final String path;
  final IconData icon;
  final String label;
}
