class FineData {
  final DateTime date;
  final double amount;
  final FineType type;

  FineData({required this.date, required this.amount, required this.type});
}

enum FineType { speeding, parking, redLight, other }
