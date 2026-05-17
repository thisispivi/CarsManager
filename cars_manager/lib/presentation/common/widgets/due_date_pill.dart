import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueDatePill extends StatelessWidget {
  final IconData? icon;
  final Widget? leading;
  final String tooltip;
  final DateTime? dueDate;
  final int? daysRemaining;
  final String daysLabel;
  final String? datePattern;

  /// When true, a small glowing dot is rendered to the right of the pill.
  final bool showGlowBullet;

  const DueDatePill({
    super.key,
    this.icon,
    this.leading,
    required this.tooltip,
    required this.dueDate,
    required this.daysRemaining,
    required this.daysLabel,
    this.datePattern,
    this.showGlowBullet = false,
  }) : assert(icon != null || leading != null);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;
    final format = DateFormat(datePattern ?? 'd MMM', locale.toString());

    final int safeDays = daysRemaining ?? -1;
    final Color color = statusColorForDaysOf(context, safeDays);

    final String dateText = dueDate == null
        ? '—'
        : '${l10n.common_due} ${format.format(dueDate!)}';
    // Show actual days count, including negatives
    final String trailing = daysRemaining == null
        ? ''
        : ' · $safeDays $daysLabel';

    final pill = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textScaler: MediaQuery.textScalerOf(context),
          ),
          if (showGlowBullet) ...[
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.7),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );

    return Tooltip(message: tooltip, child: pill);
  }
}
