import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
    this.selected = false,
  });

  final String label;
  final Color? color;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    final scheme = Theme.of(context).colorScheme;

    final bgColor = selected
        ? effectiveColor.withValues(alpha: 0.10)
        : Theme.of(context).cardColor;
    final fgColor = selected ? effectiveColor : scheme.onSurfaceVariant;
    final borderColor = selected
        ? effectiveColor.withValues(alpha: 0.30)
        : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.durationFast,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}
