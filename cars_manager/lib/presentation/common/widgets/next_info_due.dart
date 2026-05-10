import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NextInfoDue extends StatelessWidget {
  final String title;
  final DateTime nextDueDate;
  final int daysRemaining;
  final String daysLabel;
  static const double horizontalMargin = 16.0;

  const NextInfoDue({
    super.key,
    required this.title,
    required this.nextDueDate,
    required this.daysRemaining,
    required this.daysLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat('d MMM y', locale.toString());

    final pillColor = dueDateColorForDays(daysRemaining);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: horizontalMargin),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title:',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textScaler: MediaQuery.textScalerOf(context),
                ),
                const SizedBox(height: 3),
                Text(
                  'Due: ${dateFormat.format(nextDueDate)}',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  textScaler: MediaQuery.textScalerOf(context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: pillColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$daysRemaining $daysLabel left',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textScaler: MediaQuery.textScalerOf(context),
            ),
          ),
        ],
      ),
    );
  }
}
