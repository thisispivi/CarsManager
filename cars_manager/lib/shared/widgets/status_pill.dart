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
      StatusLevel.ok => (AppColors.successLight, Icons.check_circle_outline),
      StatusLevel.upcoming => (AppColors.warnLight, Icons.schedule_outlined),
      StatusLevel.overdue => (
        AppColors.dangerLight,
        Icons.warning_amber_outlined,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
