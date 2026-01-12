import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:flutter/material.dart';

class CarFormFields extends StatelessWidget {
  const CarFormFields({
    super.key,
    required this.nameController,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.licensePlateController,
    required this.fuelType,
    required this.onFuelTypeChanged,
    required this.textStyle,
    required this.decorationBuilder,
    required this.validateRequired,
    required this.validateYear,
    required this.validateLicensePlate,
    required this.l10n,
  });

  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController licensePlateController;

  final FuelType? fuelType;
  final ValueChanged<FuelType?> onFuelTypeChanged;

  final TextStyle textStyle;
  final InputDecoration Function(String label) decorationBuilder;

  final String? Function(String? value, String fieldLabel, {int min, int? max})
  validateRequired;

  final String? Function(String? value) validateYear;
  final String? Function(String? value) validateLicensePlate;

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          style: textStyle,
          decoration: decorationBuilder(l10n.carData_name),
          validator: (v) =>
              validateRequired(v, l10n.carData_name, min: 2, max: 40),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: brandController,
          style: textStyle,
          decoration: decorationBuilder(l10n.carData_manufacture),
          validator: (v) =>
              validateRequired(v, l10n.carData_manufacture, min: 2, max: 40),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: modelController,
          style: textStyle,
          decoration: decorationBuilder(l10n.carData_model),
          validator: (v) =>
              validateRequired(v, l10n.carData_model, min: 1, max: 40),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: yearController,
          style: textStyle,
          keyboardType: TextInputType.number,
          decoration: decorationBuilder(l10n.carData_yearOfManufacture),
          validator: validateYear,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: licensePlateController,
          style: textStyle,
          decoration: decorationBuilder(l10n.carData_licensePlate),
          validator: validateLicensePlate,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<FuelType>(
          initialValue: fuelType,
          decoration: decorationBuilder(l10n.carData_fuelType),
          items: FuelType.values
              .map(
                (t) => DropdownMenuItem(
                  value: t,
                  child: Text(_labelForFuelType(l10n, t), style: textStyle),
                ),
              )
              .toList(),
          onChanged: onFuelTypeChanged,
          validator: (v) {
            if (v == null) {
              return l10n.validation_required(l10n.carData_fuelType);
            }
            return null;
          },
        ),
      ],
    );
  }
}

String _labelForFuelType(AppLocalizations l10n, FuelType fuelType) {
  switch (fuelType) {
    case FuelType.petrol:
      return l10n.fuelType_petrol;
    case FuelType.diesel:
      return l10n.fuelType_diesel;
    case FuelType.lpg:
      return l10n.fuelType_lpg;
    case FuelType.electric:
      return l10n.fuelType_electric;
    case FuelType.hybrid:
      return l10n.fuelType_hybrid;
  }
}
