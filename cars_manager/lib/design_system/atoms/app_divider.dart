import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.height = 1, this.indent, this.endIndent});

  final double height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: 1,
      indent: indent,
      endIndent: endIndent,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
