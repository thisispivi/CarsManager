import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NotificationCenter extends ConsumerWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = _ReminderNotification.fromCars(
      ref.watch(carsControllerProvider),
    );
    final urgentCount = reminders
        .where((item) => item.daysRemaining <= 30)
        .length;

    return IconButton(
      tooltip: 'Notifications',
      icon: Badge(
        isLabelVisible: urgentCount > 0,
        label: Text('$urgentCount'),
        child: const Icon(Icons.notifications_none_rounded),
      ),
      onPressed: () => _showNotifications(context, reminders),
    );
  }

  Future<void> _showNotifications(
    BuildContext context,
    List<_ReminderNotification> reminders,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 700) {
      return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.72,
          maxChildSize: 0.92,
          builder: (context, scrollController) => _NotificationsPanel(
            reminders: reminders,
            scrollController: scrollController,
          ),
        ),
      );
    }

    return showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
          child: _NotificationsPanel(reminders: reminders),
        ),
      ),
    );
  }
}

class _NotificationsPanel extends StatelessWidget {
  const _NotificationsPanel({required this.reminders, this.scrollController});

  final List<_ReminderNotification> reminders;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notifications',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Mark all read'),
                  ),
                  IconButton(
                    tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: reminders.isEmpty
                  ? const _EmptyNotifications()
                  : ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      itemCount: reminders.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        return _NotificationTile(reminder: reminders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.reminder});

  final _ReminderNotification reminder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor(reminder.daysRemaining);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: () {
          Navigator.of(context).pop();
          context.go('/car/${reminder.carId}');
        },
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                foregroundColor: color,
                child: Icon(reminder.icon),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${reminder.carName} • ${DateFormat.yMMMd().format(reminder.dueDate)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _DueBadge(daysRemaining: reminder.daysRemaining, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _DueBadge extends StatelessWidget {
  const _DueBadge({required this.daysRemaining, required this.color});

  final int daysRemaining;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final label = daysRemaining < 0
        ? 'Overdue'
        : daysRemaining == 0
        ? 'Today'
        : '${daysRemaining}d';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 44,
              color: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              "You're all caught up",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Upcoming vehicle deadlines will appear here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderNotification {
  const _ReminderNotification({
    required this.carId,
    required this.carName,
    required this.title,
    required this.icon,
    required this.dueDate,
    required this.daysRemaining,
  });

  final String carId;
  final String carName;
  final String title;
  final IconData icon;
  final DateTime dueDate;
  final int daysRemaining;

  static List<_ReminderNotification> fromCars(List<Car> cars) {
    final reminders = <_ReminderNotification>[
      for (final car in cars) ...[
        if (car.nextInsuranceExpirationDate != null)
          _ReminderNotification(
            carId: car.id,
            carName: car.name,
            title: 'Insurance renewal',
            icon: Icons.description_outlined,
            dueDate: car.nextInsuranceExpirationDate!,
            daysRemaining: _daysUntil(car.nextInsuranceExpirationDate!),
          ),
        if (car.nextInspectionDate != null)
          _ReminderNotification(
            carId: car.id,
            carName: car.name,
            title: 'Inspection',
            icon: Icons.fact_check_outlined,
            dueDate: car.nextInspectionDate!,
            daysRemaining: _daysUntil(car.nextInspectionDate!),
          ),
        if (car.nextTaxDueDate != null)
          _ReminderNotification(
            carId: car.id,
            carName: car.name,
            title: 'Vehicle tax',
            icon: Icons.paid_outlined,
            dueDate: car.nextTaxDueDate!,
            daysRemaining: _daysUntil(car.nextTaxDueDate!),
          ),
      ],
    ]..sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));

    return reminders.take(12).toList();
  }

  static int _daysUntil(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final normalizedDue = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return normalizedDue.difference(today).inDays;
  }
}

Color _statusColor(int daysRemaining) {
  if (daysRemaining < 0) return AppColors.danger;
  if (daysRemaining <= 30) return AppColors.warning;
  return AppColors.success;
}
