// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CarsManager';

  @override
  String get carData_title => 'Car Data';

  @override
  String get carData_name => 'Car Name';

  @override
  String get carData_model => 'Model';

  @override
  String get carData_setUp => 'Set Up';

  @override
  String get carData_manufacture => 'Manufacturer';

  @override
  String get carData_yearOfManufacture => 'Year of Manufacture';

  @override
  String get carData_originalPrice => 'Original Price';

  @override
  String get carData_productionRangeYears => 'Production Years Range';

  @override
  String get carData_licensePlate => 'License Plate';

  @override
  String get carData_acquisitionDate => 'Acquisition Date';

  @override
  String get carData_photoUrl => 'Photo URL';

  @override
  String get carData_photo => 'Photo';

  @override
  String get carData_fuelType => 'Fuel type';

  @override
  String get carData_carInspectionDate => 'Car Inspection Date';

  @override
  String get cars_car_shortTitle => 'Car';

  @override
  String get fuel_entry_shortTitle => 'Fuel entry';

  @override
  String get cars_emptyState => 'No cars yet. Tap + to add one.';

  @override
  String get cars_removeConfirmTitle => 'Remove car?';

  @override
  String cars_removeConfirmBody(String name) {
    return 'Remove \"$name\" from your collection?';
  }

  @override
  String get cars_noCarsLeftTitle => 'No cars left';

  @override
  String get cars_noCarsLeftBody => 'Please add a new car to continue.';

  @override
  String get cars_activeRemoved => 'Active car removed. Please select another.';

  @override
  String get payments_selectCarHint => 'Select a car to view payments.';

  @override
  String get fuel_selectCarHint => 'Select a car to view fuel data.';

  @override
  String get stats_selectCarHint => 'Select a car to view stats.';

  @override
  String get fuelType_petrol => 'Petrol';

  @override
  String get fuelType_diesel => 'Diesel';

  @override
  String get fuelType_electric => 'Electric';

  @override
  String get fuelType_hybrid => 'Hybrid';

  @override
  String get fuelType_lpg => 'LPG';

  @override
  String get driveType_fwd => 'Front-wheel drive';

  @override
  String get driveType_rwd => 'Rear-wheel drive';

  @override
  String get driveType_awd => 'All-wheel drive';

  @override
  String get driveType_fourWheelDrive => '4-wheel drive';

  @override
  String get transmissionType_manual => 'Manual';

  @override
  String get transmissionType_automatic => 'Automatic';

  @override
  String get transmissionType_semiAutomatic => 'Semi-automatic';

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
    return '$speed rpm';
  }

  @override
  String unit_hp(String power) {
    return '$power hp';
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
  String get settings_title => 'Settings';

  @override
  String get common_close => 'Close';

  @override
  String get language_name_en => 'English';

  @override
  String get language_name_it => 'Italian';

  @override
  String get language_selector_title => 'Language';

  @override
  String get payments_inspectionsData_title => 'Inspections Data';

  @override
  String get payments_inspectionsData_empty =>
      'No inspection entries yet. Tap Add to create one.';

  @override
  String get payments_inspectionsData_nextDue => 'Next Inspection Due';

  @override
  String get days => 'days';

  @override
  String get date => 'Date';

  @override
  String get payments_inspectionsData_status => 'Status';

  @override
  String get payments_inspectionsData_status_passed => 'Passed';

  @override
  String get payments_inspectionsData_status_failed => 'Failed';

  @override
  String get payments_inspectionsData_mileage => 'Mileage';

  @override
  String get payments_insuranceData_title => 'Insurance Data';

  @override
  String get payments_insuranceData_empty =>
      'No insurance entries yet. Tap Add to create one.';

  @override
  String get payments_insuranceData_nextDue => 'Next Insurance Due';

  @override
  String get payments_insuranceData_policyNumber => 'Number';

  @override
  String get payments_insuranceData_provider => 'Provider';

  @override
  String get payments_taxesData_title => 'Tax Data';

  @override
  String get payments_taxesData_empty =>
      'No tax entries yet. Tap Add to create one.';

  @override
  String get payments_taxesData_nextDue => 'Next Tax Due';

  @override
  String get payments_expenseDistribution_title => 'Expense Distribution';

  @override
  String get payments_expensesByYear_title => 'Expenses by Year';

  @override
  String get payments_inspectionData_shortTitle => 'Inspection';

  @override
  String get payments_insuranceData_shortTitle => 'Insurance';

  @override
  String get payments_taxData_shortTitle => 'Tax';

  @override
  String get payments_repairsData_title => 'Repairs Data';

  @override
  String get payments_repairsData_empty =>
      'No repair entries yet. Tap Add to create one.';

  @override
  String get payments_repairsData_shortTitle => 'Repair';

  @override
  String get amount => 'Amount';

  @override
  String get themeSelector_title => 'Theme';

  @override
  String get themeSelector_dark_mode => 'Dark Mode';

  @override
  String get fineType_speeding => 'Speeding';

  @override
  String get fineType_parking => 'Parking';

  @override
  String get fineType_redLight => 'Red Light Violation';

  @override
  String get fineType_other => 'Other';

  @override
  String get payments_finesData_type => 'Type';

  @override
  String get payments_finesData_title => 'Fines Data';

  @override
  String get payments_finesData_empty =>
      'No fine entries yet. Tap Add to create one.';

  @override
  String get payments_fines_chart_countByYear_title => 'Fines per year';

  @override
  String get payments_fines_chart_amountByYear_title =>
      'Total fine amount by year';

  @override
  String get payments_fines_chart_byType_title => 'Fines by type';

  @override
  String get payments_fineData_shortTitle => 'Fine';

  @override
  String get total => 'Total';

  @override
  String get common_add => 'Add';

  @override
  String get common_edit => 'Edit';

  @override
  String get common_save => 'Save';

  @override
  String get common_ok => 'OK';

  @override
  String get common_pick => 'Pick';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_optional => 'optional';

  @override
  String get common_start => 'Start';

  @override
  String get common_end => 'End';

  @override
  String get common_description => 'Description';

  @override
  String get common_notes => 'Notes';

  @override
  String common_addEntity(String entity) {
    return 'Add $entity';
  }

  @override
  String common_editEntity(String entity) {
    return 'Edit $entity';
  }

  @override
  String get common_actions => 'Actions';

  @override
  String get common_deleted => 'Deleted';

  @override
  String get common_deleteConfirmTitle => 'Delete entry?';

  @override
  String get common_deleteConfirmBody => 'This action cannot be undone.';

  @override
  String get fuel_entries_title => 'Fuel Entries';

  @override
  String get fuel_entries_empty =>
      'No fuel entries yet. Tap Add to create one.';

  @override
  String get fuel_addEntry_title => 'Add Fuel Entry';

  @override
  String get fuel_fuelType_label => 'Fuel type';

  @override
  String get fuel_amount_liters_label => 'Liters';

  @override
  String get fuel_amount_kwh_label => 'kWh';

  @override
  String get fuel_price_per_l_label => 'Price / L';

  @override
  String get fuel_price_per_kwh_label => 'Price / kWh';

  @override
  String get fuel_total_cost_label => 'Total cost';

  @override
  String get fuel_expenseDistribution_title => 'Fuel Expense Distribution';

  @override
  String get fuel_expensesByYear_title => 'Fuel Expenses by Year';

  @override
  String get fuel_avgPriceByYear_title => 'Avg price per unit by Year';

  @override
  String get fuel_amountByYear_title => 'Total amount by Year';

  @override
  String validation_required(String field) {
    return '$field is required';
  }

  @override
  String validation_minLength(String field, int min) {
    return '$field must be at least $min characters';
  }

  @override
  String validation_maxLength(String field, int max) {
    return '$field must be at most $max characters';
  }

  @override
  String get validation_invalidYear => 'Please enter a valid year';

  @override
  String validation_yearBetween(int min, int max) {
    return 'Year must be between $min and $max';
  }

  @override
  String get validation_licensePlateInvalid => 'License plate looks invalid';

  @override
  String get validation_urlInvalid => 'Please enter a valid http(s) URL';

  @override
  String get validation_dateNotPast =>
      'Insurance expiration date cannot be in the past.';

  @override
  String validation_number_gt_zero(String field) {
    return '$field must be a number > 0';
  }

  @override
  String validation_number_gte_zero(String field) {
    return '$field must be a number ≥ 0';
  }

  @override
  String get nav_garage => 'Garage';

  @override
  String get nav_fuel => 'Fuel';

  @override
  String get nav_expenses => 'Expenses';

  @override
  String get nav_analytics => 'Analytics';

  @override
  String get nav_reminders => 'Reminders';

  @override
  String get nav_reminders_title => 'Reminders';

  @override
  String get nav_switchCar => 'Switch Car';

  @override
  String get analytics_title => 'Analytics';

  @override
  String get analytics_totalExpenses => 'Total expenses';

  @override
  String get analytics_fuelEntries => 'Fuel entries';

  @override
  String get analytics_trackedVehicle => 'Tracked vehicle';

  @override
  String get analytics_exportCsv => 'Export CSV';

  @override
  String analytics_exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get settings_preferences => 'Preferences';

  @override
  String get settings_dataManagement => 'Data Management';

  @override
  String get settings_exportBackup => 'Export Data / Backup';

  @override
  String get settings_resetData => 'Reset All Data';

  @override
  String get settings_resetDataConfirm =>
      'This will delete all your cars and entries. This action cannot be undone.';

  @override
  String get settings_resetDataTitle => 'Reset All Data?';

  @override
  String get reminders_noReminders => 'No due dates yet';

  @override
  String get reminders_insurance => 'Insurance';

  @override
  String get reminders_inspection => 'Inspection';

  @override
  String get reminders_tax => 'Tax';

  @override
  String get settings_testNotification => 'Test Notification';
}
