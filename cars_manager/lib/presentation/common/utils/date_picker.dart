import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  int firstYear = 2000,
  int durationInDays = 3650,
  double maxHeight = 560,
  double maxWidth = 560,
}) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(firstYear),
    lastDate: DateTime.now().add(Duration(days: durationInDays)),
    builder: (context, child) {
      final base = Theme.of(context);
      return Theme(
        data: base.copyWith(
          textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme),
          primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(
            base.primaryTextTheme,
          ),
          colorScheme: base.colorScheme,
          dialogTheme: base.dialogTheme.copyWith(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
            child: child!,
          ),
        ),
      );
    },
  );

  return picked;
}
