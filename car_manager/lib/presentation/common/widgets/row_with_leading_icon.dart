import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget that displays a row with a leading icon, a title, and optional subtitles.
///
/// This widget is commonly used for displaying information with an icon throughout the app.
class RowWithLeadingIcon extends StatelessWidget {
  /// Creates a RowWithLeadingIcon widget.
  ///
  /// The [icon], [title], and [subtitles] parameters are required.
  const RowWithLeadingIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitles,
  });

  /// The icon widget to display at the leading position.
  final Widget icon;

  /// The title text to display.
  final String title;

  /// The list of subtitle texts to display under the title.
  /// Null values in this list will be filtered out.
  final List<String?> subtitles;

  /// The horizontal padding for the row.
  static const double horizontalPadding = 32.0;

  /// The size of the icon container.
  static const double iconSize = 48.0;

  /// Returns a filtered list of subtitles with null values removed.
  List<String> get filteredSubtitles =>
      subtitles.where((subtitle) => subtitle != null).cast<String>().toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconContainer(context),
          const SizedBox(width: 16),
          _buildTextContent(context),
        ],
      ),
    );
  }

  /// Builds the container for the icon with appropriate styling.
  Widget _buildIconContainer(BuildContext context) {
    return Container(
      height: iconSize,
      width: iconSize,
      margin: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: icon),
    );
  }

  /// Builds the column containing the title and subtitles.
  Widget _buildTextContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(colorScheme),
          const SizedBox(height: 4),
          ..._buildSubtitles(colorScheme),
        ],
      ),
    );
  }

  /// Builds the title text widget with appropriate styling.
  Widget _buildTitle(ColorScheme colorScheme) {
    return Text(
      title,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
    );
  }

  /// Builds a list of subtitle text widgets from the filtered subtitles.
  List<Widget> _buildSubtitles(ColorScheme colorScheme) {
    return filteredSubtitles
        .map(
          (subtitle) => Text(
            subtitle,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        )
        .toList();
  }
}
