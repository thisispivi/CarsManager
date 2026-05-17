import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'CarsManager'**
  String get appTitle;

  /// Label for the car name field
  ///
  /// In en, this message translates to:
  /// **'Car Name'**
  String get carData_name;

  /// Label for the car model field
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get carData_model;

  /// Label for the car manufacturer field
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get carData_manufacture;

  /// Label for the manufacturing year field
  ///
  /// In en, this message translates to:
  /// **'Year of Manufacture'**
  String get carData_yearOfManufacture;

  /// Label for the license plate field
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get carData_licensePlate;

  /// Label for the car photo field
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get carData_photo;

  /// Label for the car fuel type field
  ///
  /// In en, this message translates to:
  /// **'Fuel type'**
  String get carData_fuelType;

  /// Short entity name for a car
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get cars_car_shortTitle;

  /// Short entity name for a fuel entry
  ///
  /// In en, this message translates to:
  /// **'Fuel entry'**
  String get fuel_entry_shortTitle;

  /// Empty state message on the cars home page
  ///
  /// In en, this message translates to:
  /// **'No cars yet. Tap + to add one.'**
  String get cars_emptyState;

  /// Title for the car removal confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Remove car?'**
  String get cars_removeConfirmTitle;

  /// Body for the car removal confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from your collection?'**
  String cars_removeConfirmBody(String name);

  /// Title shown after removing the last car
  ///
  /// In en, this message translates to:
  /// **'No cars left'**
  String get cars_noCarsLeftTitle;

  /// Body shown after removing the last car
  ///
  /// In en, this message translates to:
  /// **'Please add a new car to continue.'**
  String get cars_noCarsLeftBody;

  /// Snackbar shown when the active car is removed
  ///
  /// In en, this message translates to:
  /// **'Active car removed. Please select another.'**
  String get cars_activeRemoved;

  /// Empty state text when no car is selected on payments
  ///
  /// In en, this message translates to:
  /// **'Select a car to view payments.'**
  String get payments_selectCarHint;

  /// Empty state text when no car is selected on fuel
  ///
  /// In en, this message translates to:
  /// **'Select a car to view fuel data.'**
  String get fuel_selectCarHint;

  /// Empty state text when no car is selected on stats
  ///
  /// In en, this message translates to:
  /// **'Select a car to view stats.'**
  String get stats_selectCarHint;

  /// Label for petrol/gasoline fuel type
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get fuelType_petrol;

  /// Label for diesel fuel type
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get fuelType_diesel;

  /// Label for electric power type
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get fuelType_electric;

  /// Label for hybrid power type
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get fuelType_hybrid;

  /// Label for LPG fuel type
  ///
  /// In en, this message translates to:
  /// **'LPG'**
  String get fuelType_lpg;

  /// Length in kilometers
  ///
  /// In en, this message translates to:
  /// **'{length} km'**
  String unit_km(String length);

  /// Amount in specified currency
  ///
  /// In en, this message translates to:
  /// **'{amount}{space}{currency}'**
  String unit_currency(String amount, String currency, String space);

  /// Title for the settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Generic close action label
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_close;

  /// Language name for English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_name_en;

  /// Language name for Italian
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get language_name_it;

  /// Title for the language selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_selector_title;

  /// Title for the inspections data section in payments
  ///
  /// In en, this message translates to:
  /// **'Inspections Data'**
  String get payments_inspectionsData_title;

  /// Empty state message when there are no inspection entries in payments
  ///
  /// In en, this message translates to:
  /// **'No inspection entries yet. Tap Add to create one.'**
  String get payments_inspectionsData_empty;

  /// Label for the next inspection date field in payments
  ///
  /// In en, this message translates to:
  /// **'Next Inspection Due'**
  String get payments_inspectionsData_nextDue;

  /// Label for the number of days until the next inspection is due
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// Label for the date of the next inspection
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for the status of the next inspection (e.g., due, overdue)
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get payments_inspectionsData_status;

  /// Label for the status indicating the inspection has been passed
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get payments_inspectionsData_status_passed;

  /// Label for the status indicating the inspection has not been passed
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get payments_inspectionsData_status_failed;

  /// Label for the mileage at which the next inspection is due
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get payments_inspectionsData_mileage;

  /// Title for the insurance data section in payments
  ///
  /// In en, this message translates to:
  /// **'Insurance Data'**
  String get payments_insuranceData_title;

  /// Empty state message when there are no insurance entries in payments
  ///
  /// In en, this message translates to:
  /// **'No insurance entries yet. Tap Add to create one.'**
  String get payments_insuranceData_empty;

  /// Label for the next insurance due date field in payments
  ///
  /// In en, this message translates to:
  /// **'Next Insurance Due'**
  String get payments_insuranceData_nextDue;

  /// Label for the insurance policy number field
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get payments_insuranceData_policyNumber;

  /// Label for the insurance provider field
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get payments_insuranceData_provider;

  /// Title for the car tax data section
  ///
  /// In en, this message translates to:
  /// **'Tax Data'**
  String get payments_taxesData_title;

  /// Empty state message when there are no tax entries in payments
  ///
  /// In en, this message translates to:
  /// **'No tax entries yet. Tap Add to create one.'**
  String get payments_taxesData_empty;

  /// Label for the next tax due date field in payments
  ///
  /// In en, this message translates to:
  /// **'Next Tax Due'**
  String get payments_taxesData_nextDue;

  /// Title for the expense distribution section
  ///
  /// In en, this message translates to:
  /// **'Expense Distribution'**
  String get payments_expenseDistribution_title;

  /// Title for the expenses by year chart section
  ///
  /// In en, this message translates to:
  /// **'Expenses by Year'**
  String get payments_expensesByYear_title;

  /// Short title for the inspections data section in payments
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get payments_inspectionData_shortTitle;

  /// Short title for the insurance data section in payments
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get payments_insuranceData_shortTitle;

  /// Short title for the tax data section in payments
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get payments_taxData_shortTitle;

  /// Title for the repairs (mechanic) data section in payments
  ///
  /// In en, this message translates to:
  /// **'Repairs Data'**
  String get payments_repairsData_title;

  /// Empty state message when there are no repair entries in payments
  ///
  /// In en, this message translates to:
  /// **'No repair entries yet. Tap Add to create one.'**
  String get payments_repairsData_empty;

  /// Short title for the repairs data section in payments
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get payments_repairsData_shortTitle;

  /// Label for the insurance policy amount field
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Title for the theme selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSelector_title;

  /// Label for the speeding fine type
  ///
  /// In en, this message translates to:
  /// **'Speeding'**
  String get fineType_speeding;

  /// Label for the parking fine type
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get fineType_parking;

  /// Label for the red light violation fine type
  ///
  /// In en, this message translates to:
  /// **'Red Light Violation'**
  String get fineType_redLight;

  /// Label for other types of fines
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get fineType_other;

  /// Label for the type of fine in payments
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get payments_finesData_type;

  /// Title for the fines data section in payments
  ///
  /// In en, this message translates to:
  /// **'Fines Data'**
  String get payments_finesData_title;

  /// Empty state message when there are no fine entries in payments
  ///
  /// In en, this message translates to:
  /// **'No fine entries yet. Tap Add to create one.'**
  String get payments_finesData_empty;

  /// Title for the fines count by year chart
  ///
  /// In en, this message translates to:
  /// **'Fines per year'**
  String get payments_fines_chart_countByYear_title;

  /// Title for the total fine amount by year chart
  ///
  /// In en, this message translates to:
  /// **'Total fine amount by year'**
  String get payments_fines_chart_amountByYear_title;

  /// Title for the fines by type chart
  ///
  /// In en, this message translates to:
  /// **'Fines by type'**
  String get payments_fines_chart_byType_title;

  /// Short title for the fines data section in payments
  ///
  /// In en, this message translates to:
  /// **'Fine'**
  String get payments_fineData_shortTitle;

  /// Label for the total amount in payments
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Generic add action label
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get common_add;

  /// Generic edit action label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// Generic save action label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// Generic OK/confirm action label
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// Generic pick/select action label
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get common_pick;

  /// Generic delete action label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// Generic cancel action label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// Suffix for optional fields
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get common_optional;

  /// Start label
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get common_start;

  /// End label
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get common_end;

  /// Generic description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get common_description;

  /// Generic notes label
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get common_notes;

  /// Add an entity by name
  ///
  /// In en, this message translates to:
  /// **'Add {entity}'**
  String common_addEntity(String entity);

  /// Edit an entity by name
  ///
  /// In en, this message translates to:
  /// **'Edit {entity}'**
  String common_editEntity(String entity);

  /// Title for an actions sheet
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get common_actions;

  /// Snackbar message after deletion
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get common_deleted;

  /// Title for delete confirmation
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get common_deleteConfirmTitle;

  /// Body for delete confirmation
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get common_deleteConfirmBody;

  /// Title for fuel entries section
  ///
  /// In en, this message translates to:
  /// **'Fuel Entries'**
  String get fuel_entries_title;

  /// Empty state for fuel entries
  ///
  /// In en, this message translates to:
  /// **'No fuel entries yet. Tap Add to create one.'**
  String get fuel_entries_empty;

  /// Title for add fuel entry sheet
  ///
  /// In en, this message translates to:
  /// **'Add Fuel Entry'**
  String get fuel_addEntry_title;

  /// Label for fuel type field
  ///
  /// In en, this message translates to:
  /// **'Fuel type'**
  String get fuel_fuelType_label;

  /// Label for fuel amount in liters
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get fuel_amount_liters_label;

  /// Label for fuel amount in kWh
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get fuel_amount_kwh_label;

  /// Label for price per liter
  ///
  /// In en, this message translates to:
  /// **'Price / L'**
  String get fuel_price_per_l_label;

  /// Label for price per kWh
  ///
  /// In en, this message translates to:
  /// **'Price / kWh'**
  String get fuel_price_per_kwh_label;

  /// Label for total cost
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get fuel_total_cost_label;

  /// Title for fuel expenses by year chart
  ///
  /// In en, this message translates to:
  /// **'Fuel Expenses by Year'**
  String get fuel_expensesByYear_title;

  /// Title for fuel average price per unit by year chart
  ///
  /// In en, this message translates to:
  /// **'Avg price per unit by Year'**
  String get fuel_avgPriceByYear_title;

  /// Title for fuel total amount by year chart
  ///
  /// In en, this message translates to:
  /// **'Total amount by Year'**
  String get fuel_amountByYear_title;

  /// Validation message for required field
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String validation_required(String field);

  /// Validation message for minimum string length
  ///
  /// In en, this message translates to:
  /// **'{field} must be at least {min} characters'**
  String validation_minLength(String field, int min);

  /// Validation message for maximum string length
  ///
  /// In en, this message translates to:
  /// **'{field} must be at most {max} characters'**
  String validation_maxLength(String field, int max);

  /// Validation message for an invalid year
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid year'**
  String get validation_invalidYear;

  /// Validation message for a year outside the allowed range
  ///
  /// In en, this message translates to:
  /// **'Year must be between {min} and {max}'**
  String validation_yearBetween(int min, int max);

  /// Validation message for an invalid license plate
  ///
  /// In en, this message translates to:
  /// **'License plate looks invalid'**
  String get validation_licensePlateInvalid;

  /// Validation message for positive numbers
  ///
  /// In en, this message translates to:
  /// **'{field} must be a number > 0'**
  String validation_number_gt_zero(String field);

  /// Validation message for non-negative numbers
  ///
  /// In en, this message translates to:
  /// **'{field} must be a number ≥ 0'**
  String validation_number_gte_zero(String field);

  /// No description provided for @nav_garage.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get nav_garage;

  /// No description provided for @nav_analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get nav_analytics;

  /// No description provided for @nav_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get nav_reminders;

  /// No description provided for @nav_reminders_title.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get nav_reminders_title;

  /// No description provided for @nav_switchCar.
  ///
  /// In en, this message translates to:
  /// **'Switch Car'**
  String get nav_switchCar;

  /// No description provided for @analytics_title.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics_title;

  /// No description provided for @analytics_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your spending at a glance'**
  String get analytics_subtitle;

  /// No description provided for @analytics_totalTracked.
  ///
  /// In en, this message translates to:
  /// **'TOTAL TRACKED'**
  String get analytics_totalTracked;

  /// No description provided for @analytics_vehicleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{# vehicle} other{# vehicles}}'**
  String analytics_vehicleCount(int count);

  /// No description provided for @analytics_last12Months.
  ///
  /// In en, this message translates to:
  /// **'last 12 months'**
  String get analytics_last12Months;

  /// No description provided for @analytics_emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No analytics yet'**
  String get analytics_emptyTitle;

  /// No description provided for @analytics_emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a car and start logging fuel or expenses to unlock insights.'**
  String get analytics_emptySubtitle;

  /// No description provided for @analytics_costOverview.
  ///
  /// In en, this message translates to:
  /// **'Total cost overview'**
  String get analytics_costOverview;

  /// No description provided for @analytics_categoryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Category breakdown'**
  String get analytics_categoryBreakdown;

  /// No description provided for @analytics_costPerCar.
  ///
  /// In en, this message translates to:
  /// **'Cost per car'**
  String get analytics_costPerCar;

  /// No description provided for @analytics_monthlyTrend.
  ///
  /// In en, this message translates to:
  /// **'Monthly trend'**
  String get analytics_monthlyTrend;

  /// No description provided for @analytics_tableMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get analytics_tableMonth;

  /// No description provided for @analytics_tableFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get analytics_tableFuel;

  /// No description provided for @analytics_tableMaint.
  ///
  /// In en, this message translates to:
  /// **'Maint.'**
  String get analytics_tableMaint;

  /// No description provided for @analytics_tableFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get analytics_tableFixed;

  /// No description provided for @analytics_tableTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get analytics_tableTotal;

  /// No description provided for @analytics_insightAcrossVehicles.
  ///
  /// In en, this message translates to:
  /// **'Across every vehicle and category'**
  String get analytics_insightAcrossVehicles;

  /// No description provided for @analytics_insightVsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Compared with last month'**
  String get analytics_insightVsLastMonth;

  /// No description provided for @analytics_insightLargestCategory.
  ///
  /// In en, this message translates to:
  /// **'Largest spend category'**
  String get analytics_insightLargestCategory;

  /// No description provided for @analytics_insightDeadlines.
  ///
  /// In en, this message translates to:
  /// **'Due in the next 30 days'**
  String get analytics_insightDeadlines;

  /// No description provided for @analytics_insightThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month is active'**
  String get analytics_insightThisMonth;

  /// No description provided for @analytics_noUrgentDeadlines.
  ///
  /// In en, this message translates to:
  /// **'No urgent deadlines'**
  String get analytics_noUrgentDeadlines;

  /// No description provided for @analytics_deadlinesSoon.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, one{deadline} other{deadlines}} soon'**
  String analytics_deadlinesSoon(int count);

  /// No description provided for @analytics_filterAll.
  ///
  /// In en, this message translates to:
  /// **'All cars'**
  String get analytics_filterAll;

  /// No description provided for @analytics_noCarSelected.
  ///
  /// In en, this message translates to:
  /// **'Select at least one car to view analytics.'**
  String get analytics_noCarSelected;

  /// No description provided for @analytics_noCategoryData.
  ///
  /// In en, this message translates to:
  /// **'No cost categories have data yet.'**
  String get analytics_noCategoryData;

  /// No description provided for @analytics_noSpendYet.
  ///
  /// In en, this message translates to:
  /// **'No spend yet'**
  String get analytics_noSpendYet;

  /// No description provided for @analytics_startLoggingPatterns.
  ///
  /// In en, this message translates to:
  /// **'Start logging to see patterns'**
  String get analytics_startLoggingPatterns;

  /// No description provided for @analytics_trackedAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} tracked'**
  String analytics_trackedAmount(String amount);

  /// No description provided for @analytics_deltaPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% {direction}'**
  String analytics_deltaPercent(String percent, String direction);

  /// No description provided for @analytics_deltaUp.
  ///
  /// In en, this message translates to:
  /// **'up'**
  String get analytics_deltaUp;

  /// No description provided for @analytics_deltaDown.
  ///
  /// In en, this message translates to:
  /// **'down'**
  String get analytics_deltaDown;

  /// No description provided for @analytics_exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get analytics_exportCsv;

  /// No description provided for @analytics_exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String analytics_exportFailed(String error);

  /// No description provided for @settings_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settings_preferences;

  /// No description provided for @settings_dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settings_dataManagement;

  /// No description provided for @settings_exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export Data / Backup'**
  String get settings_exportBackup;

  /// No description provided for @settings_resetData.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get settings_resetData;

  /// No description provided for @settings_resetDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will delete all your cars and entries. This action cannot be undone.'**
  String get settings_resetDataConfirm;

  /// No description provided for @settings_resetDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data?'**
  String get settings_resetDataTitle;

  /// No description provided for @reminders_noReminders.
  ///
  /// In en, this message translates to:
  /// **'No due dates yet'**
  String get reminders_noReminders;

  /// No description provided for @reminders_insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get reminders_insurance;

  /// No description provided for @reminders_inspection.
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get reminders_inspection;

  /// No description provided for @reminders_tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get reminders_tax;

  /// No description provided for @settings_testNotification.
  ///
  /// In en, this message translates to:
  /// **'Test Notification'**
  String get settings_testNotification;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
