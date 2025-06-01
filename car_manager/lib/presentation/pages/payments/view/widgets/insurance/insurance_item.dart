import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/insurance_data.dart';
import 'package:car_manager/presentation/common/widgets/row_with_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsuranceItem extends StatelessWidget {
  final InsuranceData insurance;
  final Locale locale;

  const InsuranceItem({
    super.key,
    required this.insurance,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    return RowWithLeadingIcon(
      icon: const ImageIcon(AssetImage("assets/icons/insurance.png"), size: 24),
      title:
          "${localizations.payments_insuranceData_provider}: ${insurance.insuranceCompany}",
      subtitles: [
        "${localizations.payments_insuranceData_policyNumber}: ${insurance.policyNumber}",
        "${localizations.amount}: ${localizations.unit_currency(numberFormat.format(insurance.premiumAmount), "€", " ")}",
        "${localizations.date}: ${dateFormat.format(insurance.startDate)} - ${dateFormat.format(insurance.endDate)}",
      ],
    );
  }
}
