import 'package:cars_manager/features/fuel/domain/fuel_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/fuel_entry_item.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cars_manager/presentation/common/widgets/empty_state_widget.dart';

class FuelEntriesSection extends ConsumerWidget {
  final Car car;

  const FuelEntriesSection({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final locale = ref.watch(appSettingsProvider).locale ?? const Locale('en');

    final entries = [...car.fuel]..sort((a, b) => b.date.compareTo(a.date));

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
            ref.read(fuelControllerProvider.notifier).add(entry);
          }
        },
        icon: Icon(
          Icons.add_circle_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          localizations.common_add,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      items: [
        if (entries.isEmpty)
          EmptyStateWidget(
            message: localizations.fuel_entries_empty,
            actionLabel: localizations.common_add,
            icon: Icons.local_gas_station,
            onAction: () async {
              final FuelEntry? entry = await showModalBottomSheet<FuelEntry>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    AddFuelEntryBottomSheet(lockedFuelType: lockedFuelType),
              );

              if (entry != null && context.mounted) {
                ref.read(fuelControllerProvider.notifier).add(entry);
              }
            },
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
