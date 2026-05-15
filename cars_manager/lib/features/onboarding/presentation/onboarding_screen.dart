import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/onboarding/domain/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    _OnboardingPageData(
      icon: Icons.directions_car_filled_rounded,
      title: 'Your cars, organized',
      subtitle:
          'Keep every vehicle, deadline, and key detail in one confident view.',
    ),
    _OnboardingPageData(
      icon: Icons.receipt_long_rounded,
      title: 'Track every cost',
      subtitle:
          'Log fuel, insurance, tax, repairs, and fines without digging through menus.',
    ),
    _OnboardingPageData(
      icon: Icons.notifications_active_rounded,
      title: 'Never miss a deadline',
      subtitle:
          'See upcoming renewals and service dates before they become urgent.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() {
    return ref.read(onboardingControllerProvider.notifier).complete();
  }

  void _next() {
    if (_page == _pages.length - 1) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: AppAnimations.durationNormal,
      curve: AppAnimations.curveDefault,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                ),
                child: TextButton(
                  onPressed: _finish,
                  child: const Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  return _OnboardingPage(data: _pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < _pages.length; i++)
                        AnimatedContainer(
                          duration: AppAnimations.durationFast,
                          curve: AppAnimations.curveDefault,
                          width: i == _page ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: i == _page
                                ? AppColors.brandPrimary
                                : theme.colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(
                        _page == _pages.length - 1 ? 'Get Started' : 'Continue',
                      ),
                    ),
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

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/CarsManagerLogoFull.png',
            height: 42,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Container(
                width: 156,
                height: 156,
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                  boxShadow: Theme.of(context).brightness == Brightness.light
                      ? AppShadows.brandGlow(AppColors.brandPrimary)
                      : null,
                ),
                child: Icon(data.icon, color: Colors.white, size: 72),
              )
              .animate()
              .fadeIn(duration: 300.ms)
              .scale(
                begin: const Offset(0.96, 0.96),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: AppAnimations.curveDefault,
              ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 120.ms, duration: 260.ms)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 260.ms,
                curve: AppAnimations.curveDefault,
              ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
