class InsuranceData {
  String insuranceCompany;
  String policyNumber;
  DateTime startDate;
  DateTime endDate;
  DateTime? extensionDate;
  double premiumAmount;

  InsuranceData({
    required this.insuranceCompany,
    required this.policyNumber,
    required this.startDate,
    required this.endDate,
    this.extensionDate,
    required this.premiumAmount,
  });
}
