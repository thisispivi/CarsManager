import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DueDatePill extends StatelessWidget {
  final IconData? icon;
  final Widget? leading;
  final String tooltip;
  final DateTime? dueDate;
  final int? daysRemaining;
  final String daysLabel;
  final String? datePattern;

  const DueDatePill({
    super.key,
    this.icon,
    this.leading,
    required this.tooltip,
    required this.dueDate,
    required this.daysRemaining,
    required this.daysLabel,
    this.datePattern,
  }) : assert(icon != null || leading != null);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final format = DateFormat(datePattern ?? 'd MMM', locale.toString());

    final int safeDays = daysRemaining ?? -1;
    final Color color = dueDateColorForDays(safeDays);

    final String dateText = dueDate == null ? '—' : format.format(dueDate!);
    final String trailing = daysRemaining == null
        ? ''
        : ' · $safeDays $daysLabel';

    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading ?? Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              '$dateText$trailing',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textScaler: MediaQuery.textScalerOf(context),
            ),
          ],
        ),
      ),
    );
  }
}
