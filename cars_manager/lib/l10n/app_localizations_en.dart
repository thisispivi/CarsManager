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
  String get carData_name => 'Car Name';

  @override
  String get carData_model => 'Model';

  @override
  String get carData_manufacture => 'Manufacturer';

  @override
  String get carData_yearOfManufacture => 'Year of Manufacture';

  @override
  String get carData_licensePlate => 'License Plate';

  @override
  String get carData_photo => 'Photo';

  @override
  String get carData_fuelType => 'Fuel type';

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
  String unit_km(String length) {
    return '$length km';
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
  String get common_back => 'Back';

  @override
  String get common_overdue => 'Overdue';

  @override
  String get common_noData => 'No data';

  @override
  String common_showAll(int count) {
    return 'Show all $count entries';
  }

  @override
  String get common_showLess => 'Show less';

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
  String get analytics_subtitle => 'Your spending at a glance';

  @override
  String get analytics_totalTracked => 'TOTAL TRACKED';

  @override
  String analytics_vehicleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vehicles',
      one: '$count vehicle',
    );
    return '$_temp0';
  }

  @override
  String get analytics_last12Months => 'last 12 months';

  @override
  String get analytics_emptyTitle => 'No analytics yet';

  @override
  String get analytics_emptySubtitle =>
      'Add a car and start logging fuel or expenses to unlock insights.';

  @override
  String get analytics_costOverview => 'Total cost overview';

  @override
  String get analytics_categoryBreakdown => 'Category breakdown';

  @override
  String get analytics_costPerCar => 'Cost per car';

  @override
  String get analytics_monthlyTrend => 'Monthly trend';

  @override
  String get analytics_tableMonth => 'Month';

  @override
  String get analytics_tableFuel => 'Fuel';

  @override
  String get analytics_tableMaint => 'Maint.';

  @override
  String get analytics_tableFixed => 'Fixed';

  @override
  String get analytics_tableTotal => 'Total';

  @override
  String get analytics_insightAcrossVehicles =>
      'Across every vehicle and category';

  @override
  String get analytics_insightVsLastMonth => 'Compared with last month';

  @override
  String get analytics_insightLargestCategory => 'Largest spend category';

  @override
  String get analytics_insightDeadlines => 'Due in the next 30 days';

  @override
  String get analytics_insightThisMonth => 'This month is active';

  @override
  String get analytics_noUrgentDeadlines => 'No urgent deadlines';

  @override
  String analytics_deadlinesSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'deadlines',
      one: 'deadline',
    );
    return '$count $_temp0 soon';
  }

  @override
  String get analytics_filterAll => 'All cars';

  @override
  String get analytics_noCarSelected =>
      'Select at least one car to view analytics.';

  @override
  String get analytics_noCategoryData => 'No cost categories have data yet.';

  @override
  String get analytics_noSpendYet => 'No spend yet';

  @override
  String get analytics_startLoggingPatterns => 'Start logging to see patterns';

  @override
  String analytics_trackedAmount(String amount) {
    return '$amount tracked';
  }

  @override
  String analytics_deltaPercent(String percent, String direction) {
    return '$percent% $direction';
  }

  @override
  String get analytics_deltaUp => 'up';

  @override
  String get analytics_deltaDown => 'down';

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

  @override
  String get home_welcomeBack => 'Welcome back';

  @override
  String get home_addFirstCar => 'Add your first car';

  @override
  String get home_addFirstCarSubtitle =>
      'Track fuel, expenses, maintenance, and deadlines from one calm dashboard.';

  @override
  String get home_addCar => 'Add Car';

  @override
  String get home_activeCar => 'Active';

  @override
  String get home_switchCar => 'Switch';

  @override
  String get home_quickActions => 'Quick actions';

  @override
  String get home_quickFuel => 'Fuel';

  @override
  String get home_quickExpense => 'Expense';

  @override
  String get home_quickSearch => 'Search';

  @override
  String get home_upcoming => 'Upcoming';

  @override
  String get home_upcomingEmpty => 'No upcoming deadlines yet.';

  @override
  String get home_recentActivity => 'Recent activity';

  @override
  String get home_recentActivityEmpty =>
      'New fuel and expense entries will appear here.';

  @override
  String get home_recentActivitySeeAll => 'See all';

  @override
  String get home_monthlySummary => 'Monthly summary';

  @override
  String get home_monthlySummarySubtitle =>
      'Spent this month across fuel and expenses';

  @override
  String get home_activityFuelEntry => 'Fuel entry';

  @override
  String get home_activityRepair => 'Repair';

  @override
  String get home_activityFine => 'Fine';

  @override
  String get home_activityVehicleTax => 'Vehicle tax';

  @override
  String get home_activityInspection => 'Inspection';

  @override
  String get home_activityInsurance => 'Insurance';

  @override
  String get garage_title => 'My Garage';

  @override
  String garage_subtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vehicles tracked',
      one: '$count vehicle tracked',
    );
    return '$_temp0 with health, fuel, and cost history.';
  }

  @override
  String get garage_empty => 'Your garage is empty';

  @override
  String get garage_activeVehicle => 'Active vehicle';

  @override
  String get garage_dueSoon => 'Due soon';

  @override
  String get garage_fuelEntries => 'Fuel entries';

  @override
  String get garage_expenseEvents => 'Expense events';

  @override
  String get vehicleDetail_notFound => 'Vehicle not found';

  @override
  String get vehicleDetail_notFoundSubtitle =>
      'This car may have been removed from your garage.';

  @override
  String get vehicleDetail_backToGarage => 'Back to Garage';

  @override
  String get vehicleDetail_tabOverview => 'Overview';

  @override
  String get vehicleDetail_tabFuel => 'Fuel';

  @override
  String get vehicleDetail_tabExpenses => 'Expenses';

  @override
  String get vehicleDetail_tabTimeline => 'Timeline';

  @override
  String get vehicleDetail_totalTracked => 'Total tracked';

  @override
  String get vehicleDetail_fuelEntries => 'Fuel entries';

  @override
  String get vehicleDetail_serviceEvents => 'Service events';

  @override
  String get vehicleDetail_costBreakdown => 'Cost breakdown';

  @override
  String vehicleDetail_fuelHistory(String period) {
    return 'Fuel history ($period)';
  }

  @override
  String get vehicleDetail_addFuel => 'Add fuel';

  @override
  String get vehicleDetail_expenseCategories => 'Expense categories';

  @override
  String get vehicleDetail_latestExpenses => 'Latest expenses';

  @override
  String vehicleDetail_latestExpensesFiltered(String category) {
    return 'Latest $category';
  }

  @override
  String get vehicleDetail_addExpense => 'Add expense';

  @override
  String get vehicleDetail_vehicleTimeline => 'Vehicle timeline';

  @override
  String get vehicleDetail_noFuelEntries => 'No fuel entries yet.';

  @override
  String get vehicleDetail_noExpenses => 'No expenses yet.';

  @override
  String vehicleDetail_noExpensesFiltered(String category) {
    return 'No $category expenses yet.';
  }

  @override
  String get vehicleDetail_noData => 'No cost data yet.';

  @override
  String get vehicleDetail_timelineEmpty =>
      'Fuel, service, and payment events will appear here.';

  @override
  String vehicleDetail_showAllEntries(int count) {
    return 'Show all $count entries';
  }

  @override
  String vehicleDetail_showAllExpenses(int count) {
    return 'Show all $count expenses';
  }

  @override
  String vehicleDetail_showAllEvents(int count) {
    return 'Show all $count events';
  }

  @override
  String get vehicleDetail_addExpenseTitle => 'Add expense';

  @override
  String get vehicleDetail_insurance => 'Insurance';

  @override
  String get vehicleDetail_inspection => 'Inspection';

  @override
  String get vehicleDetail_tax => 'Tax';

  @override
  String get vehicleDetail_repair => 'Repair';

  @override
  String get vehicleDetail_fine => 'Fine';

  @override
  String get vehicleDetail_fuel => 'Fuel';

  @override
  String get vehicleDetail_noPlate => 'No plate';

  @override
  String get vehicleDetail_fuelNotSet => 'Fuel not set';

  @override
  String get onboarding_slide1Title => 'Your cars, organized';

  @override
  String get onboarding_slide1Subtitle =>
      'Keep every vehicle, deadline, and key detail in one confident view.';

  @override
  String get onboarding_slide2Title => 'Track every cost';

  @override
  String get onboarding_slide2Subtitle =>
      'Log fuel, insurance, tax, repairs, and fines without digging through menus.';

  @override
  String get onboarding_slide3Title => 'Never miss a deadline';

  @override
  String get onboarding_slide3Subtitle =>
      'See upcoming renewals and service dates before they become urgent.';

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get onboarding_getStarted => 'Get Started';

  @override
  String get onboarding_continue => 'Continue';

  @override
  String get analytics_yearlyCost => 'Yearly cost breakdown';

  @override
  String get analytics_yearlyNoData => 'No data for selected cars.';

  @override
  String get common_next => 'Next';

  @override
  String get common_all => 'All';

  @override
  String get carForm_step_basics => 'Basics';

  @override
  String get carForm_step_details => 'Details';

  @override
  String get carForm_step_photo => 'Photo';

  @override
  String get carForm_step_basicsDesc =>
      'Name the car and add the model information you use to recognize it quickly.';

  @override
  String get carForm_step_detailsDesc =>
      'Add the plate and fuel type so entries can use smarter defaults.';

  @override
  String get carForm_step_photoDesc =>
      'Add a clear photo for the garage and dashboard. You can skip this for now.';

  @override
  String carForm_imagePickerError(String error) {
    return 'Could not open image picker: $error';
  }

  @override
  String get vehicleDetail_totalLiters => 'Total liters';

  @override
  String get vehicleDetail_avgPricePerLiter => 'Avg price/L';

  @override
  String vehicleDetail_categorySummary(String category) {
    return '$category summary';
  }

  @override
  String get common_due => 'Due:';

  @override
  String get common_left => 'left';

  @override
  String get common_addToCalendar => 'Add to calendar';

  @override
  String get settings_subtitle =>
      'Preferences, reminders, data, and app details.';

  @override
  String get settings_theme_subtitle => 'Choose how CarsManager appears.';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_units => 'Units';

  @override
  String get settings_units_subtitle => 'Distance and volume defaults.';

  @override
  String get settings_units_metric => 'Metric';

  @override
  String get settings_units_imperial => 'Imperial';

  @override
  String get settings_currency => 'Currency';

  @override
  String get settings_currency_subtitle =>
      'Used for totals, charts, and exports.';

  @override
  String get settings_notifications => 'Notifications';

  @override
  String get settings_notifications_enableReminders => 'Enable reminders';

  @override
  String get settings_notifications_subtitle =>
      'Surface insurance, inspection, and tax dates.';

  @override
  String get settings_reminder_90days => '90 days';

  @override
  String get settings_reminder_30days => '30 days';

  @override
  String get settings_reminder_7days => '7 days';

  @override
  String get settings_reminder_1day => '1 day';

  @override
  String get settings_exportSubtitle =>
      'Download a CSV snapshot of your garage.';

  @override
  String get settings_resetDataSubtitle =>
      'Delete all cars and entries from this device.';

  @override
  String get settings_about => 'About';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_language_subtitle =>
      'Controls labels, dates, and localized copy.';
}
