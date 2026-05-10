import 'package:freezed_annotation/freezed_annotation.dart';

part 'repair_data.freezed.dart';

@freezed
abstract class RepairData with _$RepairData {
  const factory RepairData({
    required DateTime date,
    required double amount,
    required String description,
  }) = _RepairData;
}
