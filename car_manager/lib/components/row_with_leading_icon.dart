import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: iconSize,
            width: iconSize,
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 48, 54, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                ...filteredSubtitles.map(
                  (subtitle) => Text(
                    subtitle,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
