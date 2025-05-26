// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Car Manager';

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
  String get carData_insuranceExpirationDate => 'Insurance Expiration';

  @override
  String get carData_carInspectionDate => 'Car Inspection Date';

  @override
  String get bodySpecs_title => 'Body Specifications';

  @override
  String get bodySpecs_type => 'Body Type';

  @override
  String get bodySpecs_doors => 'Doors';

  @override
  String get bodySpecs_seats => 'Seats';

  @override
  String get bodySpecs_trunkCapacity => 'Trunk Capacity';

  @override
  String get bodySpecs_fuelTankCapacity => 'Fuel Tank Capacity';

  @override
  String get bodySpecs_weight => 'Weight';

  @override
  String get bodySpecs_maxTowingWeight => 'Max Towing Weight';

  @override
  String get bodySpecs_length => 'Length';

  @override
  String get bodySpecs_width => 'Width';

  @override
  String get bodySpecs_height => 'Height';

  @override
  String get bodySpecs_wheelbase => 'Wheelbase';

  @override
  String get engineSpecs_title => 'Engine Specifications';

  @override
  String get engineSpecs_type => 'Engine Type';

  @override
  String get engineSpecs_displacement => 'Displacement';

  @override
  String get engineSpecs_fuelType => 'Fuel Type';

  @override
  String get engineSpecs_maxPower => 'Maximum Power';

  @override
  String get engineSpecs_horsePower => 'Horsepower';

  @override
  String get engineSpecs_engineSpeed => 'Engine Speed';

  @override
  String get engineSpecs_maxTorque => 'Maximum Torque';

  @override
  String get engineSpecs_driveType => 'Drive Type';

  @override
  String get engineSpecs_transmissionType => 'Transmission Type';

  @override
  String get engineSpecs_gears => 'Number of Gears';

  @override
  String get performanceSpecs_title => 'Performance';

  @override
  String get performanceSpecs_maxSpeed => 'Maximum Speed';

  @override
  String get performanceSpecs_zeroToHundred => '0-100 km/h';

  @override
  String get performanceSpecs_co2Emissions => 'CO₂ Emissions';

  @override
  String get performanceSpecs_emissionStandard => 'Emission Standard';

  @override
  String get fuelConsumption_title => 'Fuel Consumption';

  @override
  String get fuelConsumption_urban => 'Urban Consumption';

  @override
  String get fuelConsumption_extraUrban => 'Extra-Urban Consumption';

  @override
  String get fuelConsumption_combined => 'Combined Consumption';

  @override
  String get engineType_fourCylinderInline => '4-cylinder inline';

  @override
  String get engineType_sixCylinderInline => '6-cylinder inline';

  @override
  String get engineType_v6 => 'V6';

  @override
  String get engineType_v8 => 'V8';

  @override
  String get engineType_v12 => 'V12';

  @override
  String get fuelType_petrol => 'Petrol';

  @override
  String get fuelType_diesel => 'Diesel';

  @override
  String get fuelType_electric => 'Electric';

  @override
  String get fuelType_hybrid => 'Hybrid';

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
  String unit_currency(String amount, String currency) {
    return '$amount $currency';
  }

  @override
  String get settings_title => 'Settings';

  @override
  String get language_selector_title => 'Language';
}
