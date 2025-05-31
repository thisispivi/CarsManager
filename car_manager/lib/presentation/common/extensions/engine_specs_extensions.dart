import '../../../models/engine_specs.dart';
import 'package:car_manager/l10n/app_localizations.dart';

extension EngineTypeExtension on EngineType {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case EngineType.fourCylinderInline:
        return l10n.engineType_fourCylinderInline;
      case EngineType.sixCylinderInline:
        return l10n.engineType_sixCylinderInline;
      case EngineType.v6:
        return l10n.engineType_v6;
      case EngineType.v8:
        return l10n.engineType_v8;
      case EngineType.v12:
        return l10n.engineType_v12;
    }
  }
}

extension FuelTypeExtension on FuelType {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case FuelType.petrol:
        return l10n.fuelType_petrol;
      case FuelType.diesel:
        return l10n.fuelType_diesel;
      case FuelType.electric:
        return l10n.fuelType_electric;
      case FuelType.hybrid:
        return l10n.fuelType_hybrid;
    }
  }
}

extension DriveTypeExtension on DriveType {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case DriveType.fwd:
        return l10n.driveType_fwd;
      case DriveType.rwd:
        return l10n.driveType_rwd;
      case DriveType.awd:
        return l10n.driveType_awd;
      case DriveType.fourWheelDrive:
        return l10n.driveType_fourWheelDrive;
    }
  }
}

extension TransmissionTypeExtension on TransmissionType {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case TransmissionType.manual:
        return l10n.transmissionType_manual;
      case TransmissionType.automatic:
        return l10n.transmissionType_automatic;
      case TransmissionType.semiAutomatic:
        return l10n.transmissionType_semiAutomatic;
    }
  }
}
