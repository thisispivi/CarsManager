// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Gestore Auto';

  @override
  String get carData_title => 'Dati Auto';

  @override
  String get carData_name => 'Nome Auto';

  @override
  String get carData_model => 'Modello';

  @override
  String get carData_setUp => 'Configura';

  @override
  String get carData_manufacture => 'Costruttore';

  @override
  String get carData_yearOfManufacture => 'Anno di Produzione';

  @override
  String get carData_originalPrice => 'Prezzo Originale';

  @override
  String get carData_productionRangeYears => 'Periodo di Produzione';

  @override
  String get carData_licensePlate => 'Targa';

  @override
  String get carData_acquisitionDate => 'Data di Acquisizione';

  @override
  String get carData_insuranceExpirationDate => 'Scadenza Assicurazione';

  @override
  String get carData_carInspectionDate => 'Data Revisione';

  @override
  String get bodySpecs_title => 'Specifiche Carrozzeria';

  @override
  String get bodySpecs_type => 'Tipo di Carrozzeria';

  @override
  String get bodySpecs_doors => 'Porte';

  @override
  String get bodySpecs_seats => 'Posti';

  @override
  String get bodySpecs_trunkCapacity => 'Capacità Bagagliaio';

  @override
  String get bodySpecs_fuelTankCapacity => 'Capacità Serbatoio';

  @override
  String get bodySpecs_weight => 'Peso';

  @override
  String get bodySpecs_maxTowingWeight => 'Peso Massimo Trainabile';

  @override
  String get bodySpecs_length => 'Lunghezza';

  @override
  String get bodySpecs_width => 'Larghezza';

  @override
  String get bodySpecs_height => 'Altezza';

  @override
  String get bodySpecs_wheelbase => 'Passo';

  @override
  String get engineSpecs_title => 'Specifiche Motore';

  @override
  String get engineSpecs_type => 'Tipo di Motore';

  @override
  String get engineSpecs_displacement => 'Cilindrata';

  @override
  String get engineSpecs_fuelType => 'Tipo di Carburante';

  @override
  String get engineSpecs_maxPower => 'Potenza Massima';

  @override
  String get engineSpecs_horsePower => 'Cavalli';

  @override
  String get engineSpecs_engineSpeed => 'Regime Motore';

  @override
  String get engineSpecs_maxTorque => 'Coppia Massima';

  @override
  String get engineSpecs_driveType => 'Tipo di Trazione';

  @override
  String get engineSpecs_transmissionType => 'Tipo di Trasmissione';

  @override
  String get engineSpecs_gears => 'Numero di Marce';

  @override
  String get performanceSpecs_title => 'Prestazioni';

  @override
  String get performanceSpecs_maxSpeed => 'Velocità Massima';

  @override
  String get performanceSpecs_zeroToHundred => '0-100 km/h';

  @override
  String get performanceSpecs_co2Emissions => 'Emissioni CO₂';

  @override
  String get performanceSpecs_emissionStandard => 'Normativa Emissioni';

  @override
  String get fuelConsumption_title => 'Consumo Carburante';

  @override
  String get fuelConsumption_urban => 'Consumo Urbano';

  @override
  String get fuelConsumption_extraUrban => 'Consumo Extraurbano';

  @override
  String get fuelConsumption_combined => 'Consumo Combinato';

  @override
  String get engineType_fourCylinderInline => '4 cilindri in linea';

  @override
  String get engineType_sixCylinderInline => '6 cilindri in linea';

  @override
  String get engineType_v6 => 'V6';

  @override
  String get engineType_v8 => 'V8';

  @override
  String get engineType_v12 => 'V12';

  @override
  String get fuelType_petrol => 'Benzina';

  @override
  String get fuelType_diesel => 'Diesel';

  @override
  String get fuelType_electric => 'Elettrica';

  @override
  String get fuelType_hybrid => 'Ibrida';

  @override
  String get driveType_fwd => 'Trazione anteriore';

  @override
  String get driveType_rwd => 'Trazione posteriore';

  @override
  String get driveType_awd => 'Trazione integrale';

  @override
  String get driveType_fourWheelDrive => 'Trazione 4x4';

  @override
  String get transmissionType_manual => 'Manuale';

  @override
  String get transmissionType_automatic => 'Automatica';

  @override
  String get transmissionType_semiAutomatic => 'Semi-automatica';

  @override
  String unit_kg(String weight) {
    return '$weight kg';
  }

  @override
  String unit_l(String volume) {
    return '$volume L';
  }

  @override
  String unit_m(String length) {
    return '$length m';
  }

  @override
  String unit_km(String length) {
    return '$length km';
  }

  @override
  String unit_l_per_100km(String consumption) {
    return '$consumption L/100km';
  }

  @override
  String unit_g_per_km(String emission) {
    return '$emission g/km';
  }

  @override
  String unit_kmh(String speed) {
    return '$speed km/h';
  }

  @override
  String unit_s(String time) {
    return '$time s';
  }

  @override
  String unit_nm(String torque) {
    return '$torque Nm';
  }

  @override
  String unit_rpm(String speed) {
    return '$speed giri/min';
  }

  @override
  String unit_hp(String power) {
    return '$power CV';
  }

  @override
  String unit_kw(String power) {
    return '$power kW';
  }

  @override
  String unit_cc(String displacement) {
    return '$displacement cc';
  }

  @override
  String unit_dm3(String volume) {
    return '$volume dm³';
  }

  @override
  String unit_currency(String amount, String currency) {
    return '$amount $currency';
  }

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get language_selector_title => 'Lingua';

  @override
  String get payments_inspectionsData_title => 'Dati Revisioni';

  @override
  String get payments_inspectionsData_nextDue => 'Prossima Revisione';

  @override
  String get days => 'giorni';

  @override
  String get date => 'Data';

  @override
  String get payments_inspectionsData_status => 'Stato';

  @override
  String get payments_inspectionsData_status_passed => 'Superata';

  @override
  String get payments_inspectionsData_status_failed => 'Non Superata';

  @override
  String get payments_inspectionsData_mileage => 'Chilometraggio';

  @override
  String get payments_inspectionsData_amount => 'Importo';

  @override
  String get payments_insuranceData_title => 'Dati Assicurazione';

  @override
  String get payments_insuranceData_nextDue => 'Scadenza Assicurazione';

  @override
  String get payments_insuranceData_policyNumber => 'Numero';

  @override
  String get payments_insuranceData_provider => 'Fornitore';

  @override
  String get payments_insuranceData_policyAmount => 'Importo';

  @override
  String get themeSelector_title => 'Tema';

  @override
  String get themeSelector_dark_mode => 'Modalità Scura';
}
