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
  /// **'Car Manager'**
  String get appTitle;

  /// Title for the car data section
  ///
  /// In en, this message translates to:
  /// **'Car Data'**
  String get carData_title;

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

  /// Label for the car setup action
  ///
  /// In en, this message translates to:
  /// **'Set Up'**
  String get carData_setUp;

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

  /// Label for the original price field
  ///
  /// In en, this message translates to:
  /// **'Original Price'**
  String get carData_originalPrice;

  /// Label for the production years range field
  ///
  /// In en, this message translates to:
  /// **'Production Years Range'**
  String get carData_productionRangeYears;

  /// Label for the license plate field
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get carData_licensePlate;

  /// Label for the date when the car was acquired
  ///
  /// In en, this message translates to:
  /// **'Acquisition Date'**
  String get carData_acquisitionDate;

  /// Label for the insurance expiration date field
  ///
  /// In en, this message translates to:
  /// **'Insurance Expiration'**
  String get carData_insuranceExpirationDate;

  /// Label for the car inspection date field
  ///
  /// In en, this message translates to:
  /// **'Car Inspection Date'**
  String get carData_carInspectionDate;

  /// Title for the body specifications section
  ///
  /// In en, this message translates to:
  /// **'Body Specifications'**
  String get bodySpecs_title;

  /// Label for the body type field (sedan, SUV, etc.)
  ///
  /// In en, this message translates to:
  /// **'Body Type'**
  String get bodySpecs_type;

  /// Label for the number of doors field
  ///
  /// In en, this message translates to:
  /// **'Doors'**
  String get bodySpecs_doors;

  /// Label for the number of seats field
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get bodySpecs_seats;

  /// Label for the trunk capacity field
  ///
  /// In en, this message translates to:
  /// **'Trunk Capacity'**
  String get bodySpecs_trunkCapacity;

  /// Label for the fuel tank capacity field
  ///
  /// In en, this message translates to:
  /// **'Fuel Tank Capacity'**
  String get bodySpecs_fuelTankCapacity;

  /// Label for the car weight field
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get bodySpecs_weight;

  /// Label for the maximum towing weight field
  ///
  /// In en, this message translates to:
  /// **'Max Towing Weight'**
  String get bodySpecs_maxTowingWeight;

  /// Label for the car length field
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get bodySpecs_length;

  /// Label for the car width field
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get bodySpecs_width;

  /// Label for the car height field
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get bodySpecs_height;

  /// Label for the wheelbase measurement field
  ///
  /// In en, this message translates to:
  /// **'Wheelbase'**
  String get bodySpecs_wheelbase;

  /// Title for the engine specifications section
  ///
  /// In en, this message translates to:
  /// **'Engine Specifications'**
  String get engineSpecs_title;

  /// Label for the engine type field
  ///
  /// In en, this message translates to:
  /// **'Engine Type'**
  String get engineSpecs_type;

  /// Label for the engine displacement field
  ///
  /// In en, this message translates to:
  /// **'Displacement'**
  String get engineSpecs_displacement;

  /// Label for the fuel type field
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get engineSpecs_fuelType;

  /// Label for the maximum power output field
  ///
  /// In en, this message translates to:
  /// **'Maximum Power'**
  String get engineSpecs_maxPower;

  /// Label for the horsepower field
  ///
  /// In en, this message translates to:
  /// **'Horsepower'**
  String get engineSpecs_horsePower;

  /// Label for the engine speed field
  ///
  /// In en, this message translates to:
  /// **'Engine Speed'**
  String get engineSpecs_engineSpeed;

  /// Label for the maximum torque field
  ///
  /// In en, this message translates to:
  /// **'Maximum Torque'**
  String get engineSpecs_maxTorque;

  /// Label for the drive type field (FWD, RWD, AWD, etc.)
  ///
  /// In en, this message translates to:
  /// **'Drive Type'**
  String get engineSpecs_driveType;

  /// Label for the transmission type field
  ///
  /// In en, this message translates to:
  /// **'Transmission Type'**
  String get engineSpecs_transmissionType;

  /// Label for the number of transmission gears field
  ///
  /// In en, this message translates to:
  /// **'Number of Gears'**
  String get engineSpecs_gears;

  /// Title for the performance specifications section
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performanceSpecs_title;

  /// Label for the maximum speed field
  ///
  /// In en, this message translates to:
  /// **'Maximum Speed'**
  String get performanceSpecs_maxSpeed;

  /// Label for the acceleration time from 0 to 100 km/h
  ///
  /// In en, this message translates to:
  /// **'0-100 km/h'**
  String get performanceSpecs_zeroToHundred;

  /// Label for the CO₂ emissions field
  ///
  /// In en, this message translates to:
  /// **'CO₂ Emissions'**
  String get performanceSpecs_co2Emissions;

  /// Label for the emission standard field (Euro 6, etc.)
  ///
  /// In en, this message translates to:
  /// **'Emission Standard'**
  String get performanceSpecs_emissionStandard;

  /// Title for the fuel consumption section
  ///
  /// In en, this message translates to:
  /// **'Fuel Consumption'**
  String get fuelConsumption_title;

  /// Label for the urban fuel consumption field
  ///
  /// In en, this message translates to:
  /// **'Urban Consumption'**
  String get fuelConsumption_urban;

  /// Label for the extra-urban (highway) fuel consumption field
  ///
  /// In en, this message translates to:
  /// **'Extra-Urban Consumption'**
  String get fuelConsumption_extraUrban;

  /// Label for the combined fuel consumption field
  ///
  /// In en, this message translates to:
  /// **'Combined Consumption'**
  String get fuelConsumption_combined;

  /// Label for 4-cylinder inline engine type
  ///
  /// In en, this message translates to:
  /// **'4-cylinder inline'**
  String get engineType_fourCylinderInline;

  /// Label for 6-cylinder inline engine type
  ///
  /// In en, this message translates to:
  /// **'6-cylinder inline'**
  String get engineType_sixCylinderInline;

  /// Label for V6 engine type
  ///
  /// In en, this message translates to:
  /// **'V6'**
  String get engineType_v6;

  /// Label for V8 engine type
  ///
  /// In en, this message translates to:
  /// **'V8'**
  String get engineType_v8;

  /// Label for V12 engine type
  ///
  /// In en, this message translates to:
  /// **'V12'**
  String get engineType_v12;

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

  /// Label for front-wheel drive type
  ///
  /// In en, this message translates to:
  /// **'Front-wheel drive'**
  String get driveType_fwd;

  /// Label for rear-wheel drive type
  ///
  /// In en, this message translates to:
  /// **'Rear-wheel drive'**
  String get driveType_rwd;

  /// Label for all-wheel drive type
  ///
  /// In en, this message translates to:
  /// **'All-wheel drive'**
  String get driveType_awd;

  /// Label for 4-wheel drive type
  ///
  /// In en, this message translates to:
  /// **'4-wheel drive'**
  String get driveType_fourWheelDrive;

  /// Label for manual transmission type
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get transmissionType_manual;

  /// Label for automatic transmission type
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get transmissionType_automatic;

  /// Label for semi-automatic transmission type
  ///
  /// In en, this message translates to:
  /// **'Semi-automatic'**
  String get transmissionType_semiAutomatic;

  /// Weight in kilograms
  ///
  /// In en, this message translates to:
  /// **'{weight} kg'**
  String unit_kg(String weight);

  /// Volume in liters
  ///
  /// In en, this message translates to:
  /// **'{volume} L'**
  String unit_l(String volume);

  /// Length in meters
  ///
  /// In en, this message translates to:
  /// **'{length} m'**
  String unit_m(String length);

  /// Length in kilometers
  ///
  /// In en, this message translates to:
  /// **'{length} km'**
  String unit_km(String length);

  /// Fuel consumption in liters per 100 kilometers
  ///
  /// In en, this message translates to:
  /// **'{consumption} L/100km'**
  String unit_l_per_100km(String consumption);

  /// CO₂ emissions in grams per kilometer
  ///
  /// In en, this message translates to:
  /// **'{emission} g/km'**
  String unit_g_per_km(String emission);

  /// Speed in kilometers per hour
  ///
  /// In en, this message translates to:
  /// **'{speed} km/h'**
  String unit_kmh(String speed);

  /// Time in seconds
  ///
  /// In en, this message translates to:
  /// **'{time} s'**
  String unit_s(String time);

  /// Torque in Newton-meters
  ///
  /// In en, this message translates to:
  /// **'{torque} Nm'**
  String unit_nm(String torque);

  /// Engine speed in revolutions per minute
  ///
  /// In en, this message translates to:
  /// **'{speed} rpm'**
  String unit_rpm(String speed);

  /// Power in horsepower
  ///
  /// In en, this message translates to:
  /// **'{power} hp'**
  String unit_hp(String power);

  /// Power in kilowatts
  ///
  /// In en, this message translates to:
  /// **'{power} kW'**
  String unit_kw(String power);

  /// Engine displacement in cubic centimeters
  ///
  /// In en, this message translates to:
  /// **'{displacement} cc'**
  String unit_cc(String displacement);

  /// Volume in cubic decimeters (liters)
  ///
  /// In en, this message translates to:
  /// **'{volume} dm³'**
  String unit_dm3(String volume);

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

  /// Label for the dark mode theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeSelector_dark_mode;

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
