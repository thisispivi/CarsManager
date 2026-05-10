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
        _ReminderItem('Insurance', dueDate),
      if (car.nextInspectionDate case final DateTime dueDate)
        _ReminderItem('Inspection', dueDate),
      if (car.nextTaxDueDate case final DateTime dueDate)
        _ReminderItem('Tax', dueDate),
    ];

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Reminders', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        if (reminders.isEmpty)
          const EmptyState(
            icon: Icons.event_available_rounded,
            title: 'No due dates yet',
            subtitle:
                'Add insurance, inspection, or tax entries to schedule reminders.',
          )
        else
          for (final reminder in reminders)
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_active_rounded),
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

class _ReminderItem {
  const _ReminderItem(this.label, this.dueDate);

  final String label;
  final DateTime dueDate;
}
