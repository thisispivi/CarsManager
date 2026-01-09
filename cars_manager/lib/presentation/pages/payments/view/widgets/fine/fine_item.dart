import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/presentation/common/extensions/fine_data_exxtensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FineItem extends StatelessWidget {
  final FineData fine;
  final Locale locale;
  final bool isLast;

  const FineItem({
    super.key,
    required this.fine,
    required this.locale,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat('dd MMM yyyy', locale.toString());

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    dateFormat.format(fine.date),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.euro_rounded,
                        size: 14,
                        color: colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        numberFormat.format(fine.amount),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                        ),
                        textScaler: MediaQuery.textScalerOf(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                height: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _DetailItem(
                    icon: Icons.warning_amber_rounded,
                    value: fine.type.localized(localizations),
                    colorScheme: colorScheme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final ColorScheme colorScheme;

  const _DetailItem({
    required this.icon,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.primary.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
