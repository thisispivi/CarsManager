import 'package:cars_manager/app/router/routes.dart';
import 'package:cars_manager/features/analytics/presentation/analytics_screen.dart';
import 'package:cars_manager/features/reminders/presentation/reminders_screen.dart';
import 'package:cars_manager/presentation/common/widgets/settings.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/pages/fuel/view/fuel_page.dart';
import 'package:cars_manager/presentation/pages/home/view/home.dart';
import 'package:cars_manager/presentation/pages/payments/view/payments_page.dart';
import 'package:cars_manager/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/garage',
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/garage'),
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/garage',
            name: AppRoutes.garage,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CarsHomePage()),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoutes.garageAdd,
                builder: (context, state) => const CarFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/fuel',
            name: AppRoutes.fuel,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FuelConsumptionPage()),
          ),
          GoRoute(
            path: '/expenses',
            name: AppRoutes.expenses,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: PaymentsPage()),
          ),
          GoRoute(
            path: '/analytics',
            name: AppRoutes.analytics,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AnalyticsScreen()),
          ),
          GoRoute(
            path: '/reminders',
            name: AppRoutes.reminders,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RemindersScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
});

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: SettingsContent()));
  }
}
