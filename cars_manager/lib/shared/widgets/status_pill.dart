import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

enum StatusLevel { ok, upcoming, overdue }

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status, required this.label});

  final StatusLevel status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (status) {
      StatusLevel.ok => (AppColors.success, Icons.check_circle_outline),
      StatusLevel.upcoming => (AppColors.warning, Icons.schedule_outlined),
      StatusLevel.overdue => (AppColors.danger, Icons.warning_amber_outlined),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
