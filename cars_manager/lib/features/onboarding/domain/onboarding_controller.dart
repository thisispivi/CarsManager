import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingControllerProvider =
    AsyncNotifierProvider<OnboardingController, bool>(OnboardingController.new);

class OnboardingController extends AsyncNotifier<bool> {
  static const _hasSeenOnboardingKey = 'hasSeenOnboarding';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  Future<void> complete() async {
    state = const AsyncData(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
  }
}
