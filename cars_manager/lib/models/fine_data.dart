import 'package:freezed_annotation/freezed_annotation.dart';

part 'fine_data.freezed.dart';

enum FineType { speeding, parking, redLight, other }

@freezed
abstract class FineData with _$FineData {
  const factory FineData({
    required DateTime date,
    required double amount,
    required FineType type,
  }) = _FineData;
}
