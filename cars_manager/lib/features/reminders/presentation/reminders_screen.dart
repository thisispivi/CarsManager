import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
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
        _ReminderItem(
          label: l10n.reminders_insurance,
          dueDate: dueDate,
          icon: Icons.shield_rounded,
        ),
      if (car.nextInspectionDate case final DateTime dueDate)
        _ReminderItem(
          label: l10n.reminders_inspection,
          dueDate: dueDate,
          icon: Icons.fact_check_rounded,
        ),
      if (car.nextTaxDueDate case final DateTime dueDate)
        _ReminderItem(
          label: l10n.reminders_tax,
          dueDate: dueDate,
          icon: Icons.receipt_long_rounded,
        ),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          l10n.nav_reminders_title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (reminders.isEmpty)
          EmptyState(
            icon: Icons.event_available_rounded,
            title: l10n.reminders_noReminders,
          )
        else
          ...reminders.map(
            (reminder) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _ReminderCard(reminder: reminder),
            ),
          ),
      ],
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder});

  final _ReminderItem reminder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor(reminder.dueDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final normalizedDue = DateTime(
      reminder.dueDate.year,
      reminder.dueDate.month,
      reminder.dueDate.day,
    );
    final daysRemaining = normalizedDue.difference(today).inDays;
    final daysText = daysRemaining < 0
        ? 'Overdue'
        : daysRemaining == 0
        ? 'Today'
        : '${daysRemaining}d';
    final dateText = MaterialLocalizations.of(
      context,
    ).formatMediumDate(reminder.dueDate);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: theme.colorScheme.outline, width: 0.5),
        boxShadow: theme.brightness == Brightness.light ? AppShadows.sm : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(reminder.icon, size: 20, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              daysText,
              style: theme.textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _statusColor(DateTime dueDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final normalizedDue = DateTime(dueDate.year, dueDate.month, dueDate.day);
  final daysRemaining = normalizedDue.difference(today).inDays;

  if (daysRemaining < 0) return AppColors.dangerLight;
  if (daysRemaining <= 30) return AppColors.warnLight;
  return AppColors.successLight;
}

class _ReminderItem {
  const _ReminderItem({
    required this.label,
    required this.dueDate,
    required this.icon,
  });

  final String label;
  final DateTime dueDate;
  final IconData icon;
}
