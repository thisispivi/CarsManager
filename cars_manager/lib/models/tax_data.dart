import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_data.freezed.dart';

@freezed
abstract class TaxData with _$TaxData {
  const factory TaxData({required DateTime date, required double amount}) =
      _TaxData;
}
