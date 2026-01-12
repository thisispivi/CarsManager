import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/widgets/entry_actions.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cars_manager/main.dart';

class FuelEntryItem extends StatelessWidget {
  final FuelEntry entry;
  final Locale locale;
  final bool isLast;
  final FuelType? lockedFuelType;

  const FuelEntryItem({
    super.key,
    required this.entry,
    required this.locale,
    required this.lockedFuelType,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat('dd MMM yyyy', locale.toString());

    final isElectric = entry.fuelType == FuelType.electric;
    final amountUnit = isElectric ? 'kWh' : 'L';
    final priceUnit = isElectric ? '€/kWh' : '€/L';
    final amountIcon = isElectric
        ? Icons.bolt_outlined
        : Icons.water_drop_outlined;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onLongPress: () {
        showEntryActionsSheet(
          context: context,
          onEdit: () async {
            final updated = await showModalBottomSheet<FuelEntry>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddFuelEntryBottomSheet(
                lockedFuelType: lockedFuelType,
                initialEntry: entry,
              ),
            );

            if (updated != null && context.mounted) {
              Provider.of<CarsManagerState>(
                context,
                listen: false,
              ).updateFuelEntry(oldEntry: entry, entry: updated);
            }
          },
          onDelete: () {
            Provider.of<CarsManagerState>(
              context,
              listen: false,
            ).removeFuelEntry(entry);
          },
        );
      },
      child: Container(
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
                      dateFormat.format(entry.date),
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
                          numberFormat.format(entry.totalCost),
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
                      icon: Icons.local_gas_station,
                      value: _labelForFuelType(localizations, entry.fuelType),
                      colorScheme: colorScheme,
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      icon: amountIcon,
                      value: '${numberFormat.format(entry.liters)} $amountUnit',
                      colorScheme: colorScheme,
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      icon: Icons.price_change_rounded,
                      value:
                          '${numberFormat.format(entry.pricePerLiter)} $priceUnit',
                      colorScheme: colorScheme,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _labelForFuelType(AppLocalizations localizations, FuelType fuelType) {
  switch (fuelType) {
    case FuelType.petrol:
      return localizations.fuelType_petrol;
    case FuelType.diesel:
      return localizations.fuelType_diesel;
    case FuelType.lpg:
      return localizations.fuelType_lpg;
    case FuelType.electric:
      return localizations.fuelType_electric;
    case FuelType.hybrid:
      return localizations.fuelType_hybrid;
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
