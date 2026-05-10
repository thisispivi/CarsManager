import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_car_analytics.freezed.dart';
part 'active_car_analytics.g.dart';

@freezed
abstract class ActiveCarAnalytics with _$ActiveCarAnalytics {
  const factory ActiveCarAnalytics({
    required int totalExpenses,
    required int fuelEntryCount,
    String? vehicleName,
  }) = _ActiveCarAnalytics;

  factory ActiveCarAnalytics.fromJson(Map<String, dynamic> json) =>
      _$ActiveCarAnalyticsFromJson(json);
}
