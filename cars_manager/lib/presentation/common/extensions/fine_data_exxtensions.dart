import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/l10n/app_localizations.dart';

extension FineTypeExtension on FineType {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case FineType.speeding:
        return l10n.fineType_speeding;
      case FineType.parking:
        return l10n.fineType_parking;
      case FineType.redLight:
        return l10n.fineType_redLight;
      case FineType.other:
        return l10n.fineType_other;
    }
  }
}
