import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget icon;
  final double? hPadding;
  final double? vPadding;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.hPadding = 0,
    this.vPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding!, vertical: vPadding!),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
