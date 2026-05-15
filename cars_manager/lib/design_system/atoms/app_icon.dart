import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.color, this.size = 20});

  final IconData icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }
}
