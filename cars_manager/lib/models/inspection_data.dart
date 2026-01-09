class InspectionData {
  final DateTime date;
  final bool isPassed;
  final double? amount;
  final double? mileage;

  InspectionData({
    required this.date,
    required this.isPassed,
    this.amount,
    this.mileage,
  });
}
