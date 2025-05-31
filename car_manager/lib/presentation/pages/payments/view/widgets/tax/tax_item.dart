import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/tax_data.dart';
import 'package:car_manager/presentation/common/widgets/row_with_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaxItem extends StatelessWidget {
  final TaxData tax;
  final Locale locale;

  const TaxItem({super.key, required this.tax, required this.locale});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    return RowWithLeadingIcon(
      icon: Icon(
        Icons.paid_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: "${localizations.date}: ${dateFormat.format(tax.date)}",
      subtitles: [
        "${localizations.amount}: ${localizations.unit_currency(numberFormat.format(tax.amount), "€")}",
      ],
    );
  }
}
