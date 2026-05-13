import 'package:cars_manager/app/router/routes.dart';
import 'package:cars_manager/features/analytics/presentation/analytics_screen.dart';
import 'package:cars_manager/features/reminders/presentation/reminders_screen.dart';
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
                const _FadeTransitionPage(child: CarsHomePage()),
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
                const _FadeTransitionPage(child: FuelConsumptionPage()),
          ),
          GoRoute(
            path: '/expenses',
            name: AppRoutes.expenses,
            pageBuilder: (context, state) =>
                const _FadeTransitionPage(child: PaymentsPage()),
          ),
          GoRoute(
            path: '/analytics',
            name: AppRoutes.analytics,
            pageBuilder: (context, state) =>
                const _FadeTransitionPage(child: AnalyticsScreen()),
          ),
          GoRoute(
            path: '/reminders',
            name: AppRoutes.reminders,
            pageBuilder: (context, state) =>
                const _FadeTransitionPage(child: RemindersScreen()),
          ),
        ],
      ),
    ],
  );
});

class _FadeTransitionPage extends CustomTransitionPage<void> {
  const _FadeTransitionPage({required super.child})
    : super(
        transitionsBuilder: _transitionsBuilder,
        transitionDuration: const Duration(milliseconds: 180),
      );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: child,
    );
  }
}
