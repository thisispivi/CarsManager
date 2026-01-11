import 'package:cars_manager/models/car.dart';
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

  InputDecoration _decor(String label) => InputDecoration(
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
    String? v,
    String fieldName, {
    int min = 1,
    int? max,
  }) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Please enter $fieldName';
    if (value.length < min) {
      return '$fieldName must be at least $min characters';
    }
    if (max != null && value.length > max) {
      return '$fieldName must be at most $max characters';
    }
    return null;
  }

  String? _validateYear(String? v) {
    final year = int.tryParse((v ?? '').trim());
    final now = DateTime.now().year;
    if (year == null) return 'Please enter a valid year';
    if (year < 1886 || year > now + 1) {
      return 'Year must be between 1886 and ${now + 1}';
    }
    return null;
  }

  String? _validateLicensePlate(String? v) {
    final raw = (v ?? '').trim();
    if (raw.isEmpty) return 'Please enter a license plate';
    final value = raw.toUpperCase();
    final ok = RegExp(r'^[A-Z0-9][A-Z0-9 \-]{2,11}$').hasMatch(value);
    if (!ok) return 'License plate looks invalid';
    return null;
  }

  String? _validateImageUrl(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    final okScheme =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!okScheme) return 'Please enter a valid http(s) URL';
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

  void _save() {
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
            'Insurance expiration date cannot be in the past.',
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
    final isEdit = widget.initialCar != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit car' : 'Add car',
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: _save)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: EdgeInsets.only(top: 16),
              children: [
                TextFormField(
                  controller: _nameController,
                  style: _textStyle,
                  decoration: _decor('Name'),
                  validator: (v) =>
                      _validateRequired(v, 'a name', min: 2, max: 40),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _brandController,
                  style: _textStyle,
                  decoration: _decor('Brand'),
                  validator: (v) =>
                      _validateRequired(v, 'a brand', min: 2, max: 40),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _modelController,
                  style: _textStyle,
                  decoration: _decor('Model'),
                  validator: (v) =>
                      _validateRequired(v, 'a model', min: 1, max: 40),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _yearController,
                  style: _textStyle,
                  keyboardType: TextInputType.number,
                  decoration: _decor('Year'),
                  validator: _validateYear,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _licensePlateController,
                  style: _textStyle,
                  decoration: _decor('License plate'),
                  validator: _validateLicensePlate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageUrlController,
                  style: _textStyle,
                  decoration: _decor('Photo URL'),
                  validator: _validateImageUrl,
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Insurance expiration date',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  subtitle: Text(
                    '${_insuranceExpirationDate.year.toString().padLeft(4, '0')}-'
                    '${_insuranceExpirationDate.month.toString().padLeft(2, '0')}-'
                    '${_insuranceExpirationDate.day.toString().padLeft(2, '0')}',
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _insuranceExpirationDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        final base = Theme.of(context);
                        return Theme(
                          data: base.copyWith(
                            textTheme: GoogleFonts.spaceGroteskTextTheme(
                              base.textTheme,
                            ),
                            primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(
                              base.primaryTextTheme,
                            ),
                            colorScheme: base.colorScheme,
                            dialogTheme: base.dialogTheme.copyWith(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 560,
                                maxWidth: 560,
                              ),
                              child: child!,
                            ),
                          ),
                        );
                      },
                    );
                    if (picked == null) return;
                    setState(() {
                      _insuranceExpirationDate = picked;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
