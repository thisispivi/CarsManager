import 'package:flutter/material.dart';

class RowWithLeadingIcon extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<String?> subtitles;
  static const double horizontalPadding = 32.0;
  static const double iconSize = 48.0;

  const RowWithLeadingIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitles,
  });
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

  Widget _buildTextContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, colorScheme),
          const SizedBox(height: 4),
          ..._buildSubtitles(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, ColorScheme colorScheme) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
    );
  }

  List<Widget> _buildSubtitles(BuildContext context, ColorScheme colorScheme) {
    return filteredSubtitles
        .map(
          (subtitle) => Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        )
        .toList();
  }
}
