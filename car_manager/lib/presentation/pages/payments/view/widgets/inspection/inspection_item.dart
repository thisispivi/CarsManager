import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/inspection_data.dart';
import 'package:car_manager/presentation/common/widgets/row_with_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class InspectionItem extends StatelessWidget {
  final InspectionData inspection;
  final Locale locale;

  const InspectionItem({
    super.key,
    required this.inspection,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    return RowWithLeadingIcon(
      icon: SvgPicture.asset(
        "assets/icons/inspection.svg",
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      title: "${localizations.date}: ${dateFormat.format(inspection.date)}",
      subtitles: [
        inspection.amount != null
            ? "${localizations.payments_inspectionsData_amount}: ${localizations.unit_currency(numberFormat.format(inspection.amount), "€", " ")}"
            : null,
        "${localizations.payments_inspectionsData_status}: ${inspection.isPassed ? localizations.payments_inspectionsData_status_passed : localizations.payments_inspectionsData_status_failed} • ${localizations.payments_inspectionsData_mileage}: ${localizations.unit_km(numberFormat.format(inspection.mileage))}",
      ],
    );
  }
}
