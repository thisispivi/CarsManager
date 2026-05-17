import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class TrendBadge extends StatelessWidget {
  const TrendBadge({super.key, required this.percent, this.showSign = true});

  final double percent;
  final bool showSign;

  @override
  Widget build(BuildContext context) {
    final isPositive = percent >= 0;
    final color = isPositive ? AppColors.successLight : AppColors.dangerLight;
    final icon = isPositive
        ? Icons.arrow_upward_rounded
        : Icons.arrow_downward_rounded;
    final sign = showSign ? (isPositive ? '+' : '') : '';
    final label = '$sign${percent.toStringAsFixed(1)}%';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
