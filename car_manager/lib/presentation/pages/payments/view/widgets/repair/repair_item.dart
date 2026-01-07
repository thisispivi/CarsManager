import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/repair_data.dart';
import 'package:car_manager/presentation/common/widgets/row_with_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepairItem extends StatelessWidget {
  final RepairData repair;
  final Locale locale;

  const RepairItem({super.key, required this.repair, required this.locale});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    final description = repair.description.trim();

    return RowWithLeadingIcon(
      icon: Icon(
        Icons.handyman_outlined,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: "${localizations.date}: ${dateFormat.format(repair.date)}",
      subtitles: [
        if (description.isNotEmpty) description,
        "${localizations.amount}: ${localizations.unit_currency(numberFormat.format(repair.amount), "€", " ")}",
      ],
    );
  }
}
