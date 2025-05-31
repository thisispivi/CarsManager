import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';

class NextInspectionInfo extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const NextInspectionInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');
    final dateFormat = DateFormat.yMMMd(locale.toString());

    final nextInspectionDate = car.getNextInspectionDate();
    final daysUntilNext = car.getDaysUntilNextInspection().toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${localizations.payments_inspectionsData_nextDue}: ",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text:
                  "${dateFormat.format(nextInspectionDate)} ($daysUntilNext ${localizations.days})",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        softWrap: true,
        textScaler: MediaQuery.textScalerOf(context),
      ),
    );
  }
}
