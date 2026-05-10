import 'package:cars_manager/features/analytics/domain/analytics_provider.dart';
import 'package:cars_manager/features/expenses/domain/expenses_notifier.dart';
import 'package:cars_manager/features/fuel/domain/fuel_notifier.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generated feature providers expose empty initial app state', () {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(carsProvider), isEmpty);
    expect(container.read(activeCarProvider), isNull);
    expect(container.read(fuelEntriesProvider), isEmpty);
    expect(container.read(expensesProvider).taxes, isEmpty);
    expect(container.read(activeCarAnalyticsProvider).totalExpenses, 0);
    expect(container.read(appSettingsProvider).currency, 'EUR');
  });
}
