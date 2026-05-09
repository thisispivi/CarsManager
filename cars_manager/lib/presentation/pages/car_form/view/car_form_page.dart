import 'dart:convert';
import 'dart:typed_data';

import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/pages/car_form/view/widgets/car_form_fields.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as fp;
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

  late DateTime _insuranceExpirationDate;

  FuelType? _fuelType;
  Uint8List? _imageOriginalBytes;
  Uint8List? _imageCroppedBytes;

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

    _insuranceExpirationDate = car?.insuranceExpirationDate ?? DateTime.now();

    _fuelType = car?.fuelType;

    final originalB64 = car?.imageOriginalBase64;
    if (originalB64 != null && originalB64.trim().isNotEmpty) {
      _imageOriginalBytes = base64Decode(originalB64);
    }

    final croppedB64 = car?.imageBase64;
    if (croppedB64 != null && croppedB64.trim().isNotEmpty) {
      _imageCroppedBytes = base64Decode(croppedB64);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _licensePlateController.dispose();
    super.dispose();
  }

  String _generateCarId() => DateTime.now().microsecondsSinceEpoch.toString();

  void _save(AppLocalizations l10n) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_fuelType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.validation_required(l10n.carData_fuelType),
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
          ),
        ),
      );
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

    final String? imageOriginalBase64 = _imageOriginalBytes != null
        ? base64Encode(_imageOriginalBytes!)
        : existing?.imageOriginalBase64;
    final String? imageBase64 = _imageCroppedBytes != null
        ? base64Encode(_imageCroppedBytes!)
        : existing?.imageBase64;

    final car = Car(
      id: existing?.id ?? _generateCarId(),
      name: _nameController.text.trim(),
      model: _modelController.text.trim(),
      manufacture: _brandController.text.trim(),
      yearOfManufacture: year,
      imageUrl: existing?.imageUrl,
      imageBase64: imageBase64,
      imageOriginalBase64: imageOriginalBase64,
      imageAlignment: existing?.imageAlignment ?? Alignment.center,
      licensePlate: _licensePlateController.text.trim().toUpperCase(),
      insuranceExpirationDate: _insuranceExpirationDate,
      fuelType: _fuelType,
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
                _CarImagePickerCard(
                  imageUrl: widget.initialCar?.imageUrl,
                  imageBase64: _imageCroppedBytes == null
                      ? widget.initialCar?.imageBase64
                      : base64Encode(_imageCroppedBytes!),
                  onPick: _pickAndCropImage,
                  onRemove: () {
                    setState(() {
                      _imageOriginalBytes = null;
                      _imageCroppedBytes = null;
                    });
                  },
                  onReCrop: _imageOriginalBytes == null
                      ? null
                      : () async {
                          final cropped = await _cropImage(
                            originalBytes: _imageOriginalBytes!,
                          );
                          if (cropped == null) return;
                          setState(() {
                            _imageCroppedBytes = cropped;
                          });
                        },
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                CarFormFields(
                  nameController: _nameController,
                  brandController: _brandController,
                  modelController: _modelController,
                  yearController: _yearController,
                  licensePlateController: _licensePlateController,
                  fuelType: _fuelType,
                  onFuelTypeChanged: (v) {
                    setState(() {
                      _fuelType = v;
                    });
                  },
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
                  l10n: l10n,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndCropImage() async {
    final result = await fp.FilePicker.pickFiles(type: fp.FileType.image);

    final bytes = result?.files.single.bytes;
    if (bytes == null) return;

    final cropped = await _cropImage(originalBytes: bytes);
    if (cropped == null) return;

    setState(() {
      _imageOriginalBytes = bytes;
      _imageCroppedBytes = cropped;
    });
  }

  Future<Uint8List?> _cropImage({required Uint8List originalBytes}) {
    return showModalBottomSheet<Uint8List>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ImageCropBottomSheet(imageBytes: originalBytes),
    );
  }
}

class _CarImagePickerCard extends StatelessWidget {
  final String? imageUrl;
  final String? imageBase64;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  final VoidCallback? onReCrop;
  final AppLocalizations l10n;

  const _CarImagePickerCard({
    required this.imageUrl,
    required this.imageBase64,
    required this.onPick,
    required this.onRemove,
    required this.onReCrop,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final hasImage =
        (imageBase64 != null && imageBase64!.trim().isNotEmpty) ||
        (imageUrl != null && imageUrl!.trim().isNotEmpty);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.carData_photo,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: cs.primary,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageRect(
                aspectRatio: 16 / 9,
                imageUrl: imageUrl,
                imageBase64: imageBase64,
                imageAlignment: Alignment.center,
                backgroundColor: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.zero,
                primaryColor: cs.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilledButton.tonalIcon(
                onPressed: onPick,
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(
                  l10n.common_pick,
                  style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
                ),
              ),
              if (hasImage)
                FilledButton.tonalIcon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  label: Text(
                    l10n.common_delete,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              if (onReCrop != null)
                FilledButton.tonalIcon(
                  onPressed: onReCrop,
                  icon: const Icon(Icons.crop),
                  label: Text(
                    l10n.common_edit,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageCropBottomSheet extends StatefulWidget {
  final Uint8List imageBytes;

  const _ImageCropBottomSheet({required this.imageBytes});

  @override
  State<_ImageCropBottomSheet> createState() => _ImageCropBottomSheetState();
}

class _ImageCropBottomSheetState extends State<_ImageCropBottomSheet> {
  final CropController _controller = CropController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.common_edit,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.common_close,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Crop(
                  image: widget.imageBytes,
                  controller: _controller,
                  aspectRatio: 1,
                  withCircleUi: false,
                  baseColor: theme.colorScheme.surface,
                  maskColor: Colors.black.withValues(alpha: 0.4),
                  onCropped: (result) {
                    if (result is CropSuccess) {
                      Navigator.of(context).pop(result.croppedImage);
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n.common_cancel,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        _controller.crop();
                      },
                      child: Text(
                        l10n.common_save,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
