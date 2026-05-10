import 'package:cars_manager/features/analytics/data/models/active_car_analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ActiveCarAnalytics serializes to and from JSON', () {
    const analytics = ActiveCarAnalytics(
      totalExpenses: 1200,
      fuelEntryCount: 8,
      vehicleName: 'Roadster',
    );

    final json = analytics.toJson();
    final parsed = ActiveCarAnalytics.fromJson(json);

    expect(parsed, analytics);
    expect(json['totalExpenses'], 1200);
    expect(json['fuelEntryCount'], 8);
    expect(json['vehicleName'], 'Roadster');
  });
}
