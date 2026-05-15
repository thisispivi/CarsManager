import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:flutter/widgets.dart';

class AppSpacer extends StatelessWidget {
  const AppSpacer.vertical(this.size, {super.key}) : axis = Axis.vertical;

  const AppSpacer.horizontal(this.size, {super.key}) : axis = Axis.horizontal;

  final Axis axis;
  final double size;

  const AppSpacer.xs({super.key}) : axis = Axis.vertical, size = AppSpacing.xs;

  const AppSpacer.sm({super.key}) : axis = Axis.vertical, size = AppSpacing.sm;

  const AppSpacer.md({super.key}) : axis = Axis.vertical, size = AppSpacing.md;

  const AppSpacer.lg({super.key}) : axis = Axis.vertical, size = AppSpacing.lg;

  const AppSpacer.xl({super.key}) : axis = Axis.vertical, size = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : 0,
      height: axis == Axis.vertical ? size : 0,
    );
  }
}
