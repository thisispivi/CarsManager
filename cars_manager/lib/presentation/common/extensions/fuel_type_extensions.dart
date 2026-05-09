import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/fuel_entry.dart';

extension FuelTypeExtension on FuelType {
  String localized(AppLocalizations localizations) {
    switch (this) {
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
}
