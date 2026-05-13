import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(activeCarProvider);
    final l10n = AppLocalizations.of(context)!;

    if (car == null) {
      return EmptyState(
        icon: Icons.notifications_active_outlined,
        title: l10n.stats_selectCarHint,
      );
    }

    final reminders = <_ReminderItem>[
      if (car.nextInsuranceExpirationDate case final DateTime dueDate)
        _ReminderItem(l10n.reminders_insurance, dueDate),
      if (car.nextInspectionDate case final DateTime dueDate)
        _ReminderItem(l10n.reminders_inspection, dueDate),
      if (car.nextTaxDueDate case final DateTime dueDate)
        _ReminderItem(l10n.reminders_tax, dueDate),
    ];

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          l10n.nav_reminders_title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        if (reminders.isEmpty)
          EmptyState(
            icon: Icons.event_available_rounded,
            title: l10n.reminders_noReminders,
          )
        else
          for (final reminder in reminders)
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.notifications_active_rounded,
                  color: _statusColor(reminder.dueDate),
                ),
                title: Text(reminder.label),
                subtitle: Text(
                  MaterialLocalizations.of(
                    context,
                  ).formatMediumDate(reminder.dueDate),
                ),
              ),
            ),
      ],
    );
  }
}

Color _statusColor(DateTime dueDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final normalizedDue = DateTime(dueDate.year, dueDate.month, dueDate.day);
  final daysRemaining = normalizedDue.difference(today).inDays;

  if (daysRemaining < 0) return AppColors.danger;
  if (daysRemaining <= 30) return AppColors.warning;
  return AppColors.success;
}

class _ReminderItem {
  const _ReminderItem(this.label, this.dueDate);

  final String label;
  final DateTime dueDate;
}
