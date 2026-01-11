import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CarFormFields extends StatelessWidget {
  const CarFormFields({
    super.key,
    required this.nameController,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.licensePlateController,
    required this.imageUrlController,
    required this.textStyle,
    required this.decorationBuilder,
    required this.validateRequired,
    required this.validateYear,
    required this.validateLicensePlate,
    required this.validateImageUrl,
    required this.l10n,
  });

  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController licensePlateController;
  final TextEditingController imageUrlController;

  final TextStyle textStyle;
  final InputDecoration Function(String label) decorationBuilder;

  final String? Function(String? value, String fieldLabel, {int min, int? max})
  validateRequired;

  final String? Function(String? value) validateYear;
  final String? Function(String? value) validateLicensePlate;
  final String? Function(String? value) validateImageUrl;

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
        TextFormField(
          controller: imageUrlController,
          style: textStyle,
          decoration: decorationBuilder(l10n.carData_photoUrl),
          validator: validateImageUrl,
        ),
      ],
    );
  }
}
