import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget that displays a section header with a title and an icon.
///
/// This widget is commonly used for indicating the start of a new section
/// throughout the app.
class SectionHeader extends StatelessWidget {
  /// Creates a SectionHeader widget.
  ///
  /// The [title] and [icon] parameters are required.
  /// The [horizontalPadding] and [verticalPadding] parameters are optional
  /// and default to 0.
  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
  });

  /// The title text to display.
  final String title;

  /// The icon widget to display at the start of the header.
  final Widget icon;

  /// The horizontal padding to apply around the header.
  final double horizontalPadding;

  /// The vertical padding to apply around the header.
  final double verticalPadding;

  /// The spacing between the icon and the title.
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
          icon,
          const SizedBox(width: iconTitleSpacing),
          _buildTitleText(context),
        ],
      ),
    );
  }

  /// Builds the title text with appropriate styling.
  Widget _buildTitleText(BuildContext context) {
    return Text(title, style: _getTitleTextStyle(context));
  }

  /// Returns the text style for the title.
  TextStyle _getTitleTextStyle(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
