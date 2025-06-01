import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/fine_data.dart';
import 'package:car_manager/presentation/common/extensions/fine_data_exxtensions.dart';
import 'package:car_manager/presentation/common/widgets/row_with_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class FineItem extends StatelessWidget {
  final FineData fine;
  final Locale locale;

  const FineItem({super.key, required this.fine, required this.locale});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    return RowWithLeadingIcon(
      icon: SvgPicture.asset(
        "assets/icons/fine.svg",
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      title: "${localizations.date}: ${dateFormat.format(fine.date)}",
      subtitles: [
        "${localizations.payments_finesData_type}: ${fine.type.localized(AppLocalizations.of(context)!)} • ${localizations.amount}: ${localizations.unit_currency(numberFormat.format(fine.amount), "€", " ")}",
      ],
    );
  }
}
