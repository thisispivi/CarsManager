import 'package:cars_manager/features/home/presentation/home_screen.dart';
import 'package:cars_manager/features/onboarding/domain/onboarding_controller.dart';
import 'package:cars_manager/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingGate extends ConsumerWidget {
  const OnboardingGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSeenOnboarding = ref.watch(onboardingControllerProvider);

    return hasSeenOnboarding.when(
      data: (hasSeen) =>
          hasSeen ? const HomeScreen() : const OnboardingScreen(),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => const HomeScreen(),
    );
  }
}
