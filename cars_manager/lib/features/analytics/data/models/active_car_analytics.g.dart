// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_car_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveCarAnalytics _$ActiveCarAnalyticsFromJson(Map<String, dynamic> json) =>
    _ActiveCarAnalytics(
      totalExpenses: (json['totalExpenses'] as num).toInt(),
      fuelEntryCount: (json['fuelEntryCount'] as num).toInt(),
      vehicleName: json['vehicleName'] as String?,
    );

Map<String, dynamic> _$ActiveCarAnalyticsToJson(_ActiveCarAnalytics instance) =>
    <String, dynamic>{
      'totalExpenses': instance.totalExpenses,
      'fuelEntryCount': instance.fuelEntryCount,
      'vehicleName': instance.vehicleName,
    };
