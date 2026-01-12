import 'package:cars_manager/main.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/fuel_entry_item.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FuelEntriesSection extends StatelessWidget {
  final Car car;

  const FuelEntriesSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final carsManagerState = Provider.of<CarsManagerState>(
      context,
      listen: false,
    );
    final locale = carsManagerState.locale ?? const Locale('en');

    final entries = [...(car.fuel ?? const <FuelEntry>[])]
      ..sort((a, b) => b.date.compareTo(a.date));

    final lockedFuelType =
        car.fuelType ?? (entries.isNotEmpty ? entries.first.fuelType : null);

    return PaymentSectionCard(
      title: localizations.fuel_entries_title,
      icon: Icon(
        Icons.local_gas_station,
        size: 28,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: TextButton.icon(
        onPressed: () async {
          final FuelEntry? entry = await showModalBottomSheet<FuelEntry>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                AddFuelEntryBottomSheet(lockedFuelType: lockedFuelType),
          );

          if (entry != null && context.mounted) {
            Provider.of<CarsManagerState>(
              context,
              listen: false,
            ).addFuelEntry(entry);
          }
        },
        icon: Icon(
          Icons.add_circle_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          localizations.common_add,
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
      ),
      nextInfoDue: null,
      items: [
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              localizations.fuel_entries_empty,
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
            ),
          )
        else
          ...entries.asMap().entries.map(
            (e) => FuelEntryItem(
              entry: e.value,
              locale: locale,
              isLast: e.key == entries.length - 1,
              lockedFuelType: lockedFuelType,
            ),
          ),
      ],
    );
  }
}
