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
  String get fuelType_petrol => 'Benzina';

  @override
  String get fuelType_diesel => 'Diesel';

  @override
  String get fuelType_electric => 'Elettrica';

  @override
  String get fuelType_hybrid => 'Ibrida';

  @override
  String get fuelType_lpg => 'GPL';

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
  String unit_currency(String amount, String currency, String space) {
    return '$amount$space$currency';
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
  String get payments_inspectionsData_mileage => 'Chilometri';

  @override
  String get payments_insuranceData_title => 'Dati Assicurazione';

  @override
  String get payments_insuranceData_nextDue => 'Scadenza Assicurazione';

  @override
  String get payments_insuranceData_policyNumber => 'Numero';

  @override
  String get payments_insuranceData_provider => 'Fornitore';

  @override
  String get payments_taxesData_title => 'Dati Bollo';

  @override
  String get payments_taxesData_nextDue => 'Prossimo Bollo';

  @override
  String get payments_expenseDistribution_title => 'Distribuzione Spese';

  @override
  String get payments_expensesByYear_title => 'Spese per Anno';

  @override
  String get payments_inspectionData_shortTitle => 'Revisione';

  @override
  String get payments_insuranceData_shortTitle => 'Assicurazione';

  @override
  String get payments_taxData_shortTitle => 'Bollo';

  @override
  String get payments_repairsData_title => 'Dati Riparazioni';

  @override
  String get payments_repairsData_shortTitle => 'Riparazioni';

  @override
  String get amount => 'Importo';

  @override
  String get themeSelector_title => 'Tema';

  @override
  String get themeSelector_dark_mode => 'Modalità Scura';

  @override
  String get fineType_speeding => 'Eccesso di Velocità';

  @override
  String get fineType_parking => 'Parcheggio';

  @override
  String get fineType_redLight => 'Semaforo Rosso';

  @override
  String get fineType_other => 'Other';

  @override
  String get payments_finesData_type => 'Tipo';

  @override
  String get payments_finesData_title => 'Dati Multe';

  @override
  String get payments_fineData_shortTitle => 'Multa';

  @override
  String get total => 'Totale';

  @override
  String get common_add => 'Aggiungi';

  @override
  String get common_pick => 'Scegli';

  @override
  String get common_delete => 'Elimina';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_optional => 'opzionale';

  @override
  String get common_start => 'Inizio';

  @override
  String get common_end => 'Fine';

  @override
  String get common_description => 'Descrizione';

  @override
  String get common_notes => 'Note';

  @override
  String common_addEntity(String entity) {
    return 'Aggiungi $entity';
  }

  @override
  String get common_actions => 'Azioni';

  @override
  String get common_deleted => 'Eliminato';

  @override
  String get common_deleteConfirmTitle => 'Eliminare elemento?';

  @override
  String get common_deleteConfirmBody =>
      'Questa azione non può essere annullata.';

  @override
  String get fuel_entries_title => 'Rifornimenti';

  @override
  String get fuel_entries_empty =>
      'Nessun rifornimento. Tocca Aggiungi per crearne uno.';

  @override
  String get fuel_addEntry_title => 'Aggiungi rifornimento';

  @override
  String get fuel_fuelType_label => 'Tipo di carburante';

  @override
  String get fuel_amount_liters_label => 'Litri';

  @override
  String get fuel_amount_kwh_label => 'kWh';

  @override
  String get fuel_price_per_l_label => 'Prezzo / L';

  @override
  String get fuel_price_per_kwh_label => 'Prezzo / kWh';

  @override
  String get fuel_total_cost_label => 'Costo totale';

  @override
  String get fuel_expenseDistribution_title => 'Distribuzione spese carburante';

  @override
  String get fuel_expensesByYear_title => 'Spese carburante per anno';

  @override
  String get fuel_avgPriceByYear_title => 'Prezzo medio per unità per anno';

  @override
  String get fuel_amountByYear_title => 'Quantità totale per anno';

  @override
  String validation_required(String field) {
    return '$field è obbligatorio';
  }

  @override
  String validation_number_gt_zero(String field) {
    return '$field deve essere un numero > 0';
  }

  @override
  String validation_number_gte_zero(String field) {
    return '$field deve essere un numero ≥ 0';
  }
}
