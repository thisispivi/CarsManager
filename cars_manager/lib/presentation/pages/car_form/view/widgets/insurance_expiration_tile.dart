import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InsuranceExpirationTile extends StatelessWidget {
  const InsuranceExpirationTile({
    super.key,
    required this.date,
    required this.onChanged,
  });

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd MMM yyyy');

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        l10n.carData_insuranceExpirationDate,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
      subtitle: Text(
        dateFormat.format(date),
        style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showCustomDatePicker(
          context: context,
          initialDate: date,
        );
        if (picked == null) return;
        onChanged(picked);
      },
    );
  }
}
