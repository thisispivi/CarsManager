import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/car_form/view/widgets/car_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarFormPage extends StatefulWidget {
  final Car? initialCar;

  const CarFormPage({super.key, this.initialCar});

  @override
  State<CarFormPage> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _licensePlateController;
  late final TextEditingController _imageUrlController;

  late DateTime _insuranceExpirationDate;

  TextStyle get _textStyle =>
      GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w500);

  InputDecoration _decor(BuildContext context, String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    labelStyle: GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    errorStyle: GoogleFonts.spaceGrotesk(fontSize: 12),
    helperStyle: GoogleFonts.spaceGrotesk(fontSize: 12),
  );

  String? _validateRequired(
    String? rawValue,
    String fieldLabel,
    AppLocalizations l10n, {
    int min = 1,
    int? max,
  }) {
    final value = (rawValue ?? '').trim();
    if (value.isEmpty) return l10n.validation_required(fieldLabel);
    if (value.length < min) {
      return l10n.validation_minLength(fieldLabel, min);
    }
    if (max != null && value.length > max) {
      return l10n.validation_maxLength(fieldLabel, max);
    }
    return null;
  }

  String? _validateYear(String? rawValue, AppLocalizations l10n) {
    final year = int.tryParse((rawValue ?? '').trim());
    final now = DateTime.now().year;
    if (year == null) return l10n.validation_invalidYear;
    if (year < 1886 || year > now + 1) {
      return l10n.validation_yearBetween(1886, now + 1);
    }
    return null;
  }

  String? _validateLicensePlate(String? rawValue, AppLocalizations l10n) {
    final raw = (rawValue ?? '').trim();
    if (raw.isEmpty) {
      return l10n.validation_required(l10n.carData_licensePlate);
    }
    final value = raw.toUpperCase();
    final ok = RegExp(r'^[A-Z0-9][A-Z0-9 \-]{2,11}$').hasMatch(value);
    if (!ok) return l10n.validation_licensePlateInvalid;
    return null;
  }

  String? _validateImageUrl(String? rawValue, AppLocalizations l10n) {
    final value = (rawValue ?? '').trim();
    if (value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    final okScheme =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!okScheme) return l10n.validation_urlInvalid;
    return null;
  }

  @override
  void initState() {
    super.initState();

    final car = widget.initialCar;

    _nameController = TextEditingController(text: car?.name ?? '');
    _brandController = TextEditingController(text: car?.manufacture ?? '');
    _modelController = TextEditingController(text: car?.model ?? '');
    _yearController = TextEditingController(
      text: car?.yearOfManufacture != null && car!.yearOfManufacture != 0
          ? car.yearOfManufacture.toString()
          : '',
    );
    _licensePlateController = TextEditingController(
      text: car?.licensePlate ?? '',
    );
    _imageUrlController = TextEditingController(text: car?.imageUrl ?? '');

    _insuranceExpirationDate = car?.insuranceExpirationDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _licensePlateController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String _generateCarId() => DateTime.now().microsecondsSinceEpoch.toString();

  void _save(AppLocalizations l10n) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final pickedDay = DateTime(
      _insuranceExpirationDate.year,
      _insuranceExpirationDate.month,
      _insuranceExpirationDate.day,
    );
    if (pickedDay.isBefore(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.validation_dateNotPast,
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
          ),
        ),
      );
      return;
    }

    final existing = widget.initialCar;
    final year = int.tryParse(_yearController.text.trim()) ?? 0;

    final car = Car(
      id: existing?.id ?? _generateCarId(),
      name: _nameController.text.trim(),
      model: _modelController.text.trim(),
      manufacture: _brandController.text.trim(),
      yearOfManufacture: year,
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
      imageAlignment: existing?.imageAlignment,
      licensePlate: _licensePlateController.text.trim().toUpperCase(),
      insuranceExpirationDate: _insuranceExpirationDate,
      fuelType: existing?.fuelType,
      fuel: existing?.fuel,
      inspectionDatas: existing?.inspectionDatas,
      insuranceDatas: existing?.insuranceDatas,
      taxDatas: existing?.taxDatas,
      repairDatas: existing?.repairDatas,
      fineDatas: existing?.fineDatas,
    );

    Navigator.of(context).pop(car);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.initialCar != null;

    final title = isEdit
        ? l10n.common_editEntity(l10n.cars_car_shortTitle)
        : l10n.common_addEntity(l10n.cars_car_shortTitle);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: l10n.common_save,
            onPressed: () => _save(l10n),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.only(top: 16),
              children: [
                CarFormFields(
                  nameController: _nameController,
                  brandController: _brandController,
                  modelController: _modelController,
                  yearController: _yearController,
                  licensePlateController: _licensePlateController,
                  imageUrlController: _imageUrlController,
                  textStyle: _textStyle,
                  decorationBuilder: (label) => _decor(context, label),
                  validateRequired: (v, fieldLabel, {min = 1, int? max}) =>
                      _validateRequired(
                        v,
                        fieldLabel,
                        l10n,
                        min: min,
                        max: max,
                      ),
                  validateYear: (v) => _validateYear(v, l10n),
                  validateLicensePlate: (v) => _validateLicensePlate(v, l10n),
                  validateImageUrl: (v) => _validateImageUrl(v, l10n),
                  l10n: l10n,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
