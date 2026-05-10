import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_data.freezed.dart';

@freezed
abstract class InspectionData with _$InspectionData {
  const factory InspectionData({
    required DateTime date,
    required bool isPassed,
    double? amount,
    double? mileage,
  }) = _InspectionData;
}
