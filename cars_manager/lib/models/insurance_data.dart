import 'package:freezed_annotation/freezed_annotation.dart';

part 'insurance_data.freezed.dart';

@freezed
abstract class InsuranceData with _$InsuranceData {
  const factory InsuranceData({
    required String insuranceCompany,
    required String policyNumber,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? extensionDate,
    required double premiumAmount,
  }) = _InsuranceData;
}
