import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
  });

  final String title;
  final Widget? icon;
  final double horizontalPadding;
  final double verticalPadding;
  static const double iconTitleSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: iconTitleSpacing),
          _buildTitleText(context),
        ],
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(title, style: _getTitleTextStyle(context));
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
