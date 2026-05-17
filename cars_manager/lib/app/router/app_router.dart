import 'package:cars_manager/app/router/routes.dart';
import 'package:cars_manager/features/analytics/presentation/analytics_screen.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/onboarding/presentation/onboarding_gate.dart';
import 'package:cars_manager/features/vehicle_detail/presentation/vehicle_detail_screen.dart';
import 'package:cars_manager/presentation/pages/car_form/view/car_form_page.dart';
import 'package:cars_manager/presentation/common/widgets/settings.dart';
import 'package:cars_manager/presentation/pages/home/view/home.dart';
import 'package:cars_manager/shared/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: AppRoutes.home,
            pageBuilder: (context, state) => _FadeTransitionPage(
              child: Title(
                title: 'Home - Cars Manager',
                color: const Color(0xFF0062CC),
                child: const OnboardingGate(),
              ),
            ),
          ),
          GoRoute(
            path: '/garage',
            name: AppRoutes.garage,
            pageBuilder: (context, state) => _FadeTransitionPage(
              child: Title(
                title: 'Garage - Cars Manager',
                color: const Color(0xFF0062CC),
                child: const CarsHomePage(),
              ),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoutes.garageAdd,
                builder: (context, state) => const CarFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/car/:id',
            name: AppRoutes.vehicleDetail,
            pageBuilder: (context, state) => _FadeTransitionPage(
              child: Title(
                title: 'Vehicle - Cars Manager',
                color: const Color(0xFF0062CC),
                child: VehicleDetailScreen(carId: state.pathParameters['id']!),
              ),
            ),
            routes: [
              GoRoute(
                path: 'fuel',
                name: AppRoutes.vehicleFuel,
                pageBuilder: (context, state) => _FadeTransitionPage(
                  child: Title(
                    title: 'Fuel - Cars Manager',
                    color: const Color(0xFF0062CC),
                    child: VehicleDetailScreen(
                      carId: state.pathParameters['id']!,
                      initialTabIndex: 1,
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: 'expenses',
                name: AppRoutes.vehicleExpenses,
                pageBuilder: (context, state) => _FadeTransitionPage(
                  child: Title(
                    title: 'Expenses - Cars Manager',
                    color: const Color(0xFF0062CC),
                    child: VehicleDetailScreen(
                      carId: state.pathParameters['id']!,
                      initialTabIndex: 2,
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: 'timeline',
                name: AppRoutes.vehicleTimeline,
                pageBuilder: (context, state) => _FadeTransitionPage(
                  child: Title(
                    title: 'Timeline - Cars Manager',
                    color: const Color(0xFF0062CC),
                    child: VehicleDetailScreen(
                      carId: state.pathParameters['id']!,
                      initialTabIndex: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/fuel',
            name: AppRoutes.fuel,
            redirect: (context, state) {
              final activeCar = ref.read(activeCarProvider);
              return activeCar == null ? '/' : '/car/${activeCar.id}/fuel';
            },
          ),
          GoRoute(
            path: '/expenses',
            name: AppRoutes.expenses,
            redirect: (context, state) {
              final activeCar = ref.read(activeCarProvider);
              return activeCar == null ? '/' : '/car/${activeCar.id}/expenses';
            },
          ),
          GoRoute(
            path: '/analytics',
            name: AppRoutes.analytics,
            pageBuilder: (context, state) => _FadeTransitionPage(
              child: Title(
                title: 'Analytics - Cars Manager',
                color: const Color(0xFF0062CC),
                child: const AnalyticsScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/reminders',
            name: AppRoutes.reminders,
            redirect: (context, state) => '/',
          ),
          GoRoute(
            path: '/settings',
            name: AppRoutes.settings,
            pageBuilder: (context, state) => _FadeTransitionPage(
              child: Title(
                title: 'Settings - Cars Manager',
                color: const Color(0xFF0062CC),
                child: const SettingsContent(showCloseButton: false),
              ),
            ),
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
