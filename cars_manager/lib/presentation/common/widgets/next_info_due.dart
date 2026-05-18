import 'package:cars_manager/core/services/calendar_service.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/utils/due_date_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextInfoDue extends StatelessWidget {
  final String title;
  final DateTime nextDueDate;
  final int daysRemaining;
  final String daysLabel;
  final String? calendarTitle;
  static const double horizontalMargin = 16.0;

  const NextInfoDue({
    super.key,
    required this.title,
    required this.nextDueDate,
    required this.daysRemaining,
    required this.daysLabel,
    this.calendarTitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat('d MMM y', locale.toString());

    final pillColor = statusColorForDaysOf(context, daysRemaining);

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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textScaler: MediaQuery.textScalerOf(context),
                ),
                const SizedBox(height: 3),
                Text(
                  '${l10n.common_due} ${dateFormat.format(nextDueDate)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          Tooltip(
            message: l10n.common_addToCalendar,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                try {
                  final result = await CalendarService.addEvent(
                    title: calendarTitle ?? title,
                    startDate: nextDueDate,
                    endDate: nextDueDate.add(const Duration(days: 1)),
                  );
                  if (!context.mounted) return;
                  AppSnackBar.show(
                    context,
                    result == CalendarAddResult.nativeCalendar
                        ? l10n.calendar_addSuccess
                        : l10n.calendar_addBrowserFallback,
                  );
                } catch (error) {
                  if (!context.mounted) return;
                  AppSnackBar.show(
                    context,
                    l10n.calendar_addFailed('$error'),
                    isError: true,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
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
              '$daysRemaining $daysLabel ${l10n.common_left}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
