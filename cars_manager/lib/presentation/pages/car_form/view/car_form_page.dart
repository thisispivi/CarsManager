import 'dart:convert';
import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/core/utils/app_snack_bar.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/presentation/pages/car_form/view/image_file_reader.dart';
import 'package:cars_manager/presentation/common/widgets/image_rect.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart' as fp;

class CarFormPage extends StatefulWidget {
  final Car? initialCar;

  const CarFormPage({super.key, this.initialCar});

  @override
  State<CarFormPage> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final _formKey = GlobalKey<FormState>();
  static const _lastStep = 2;

  late final TextEditingController _nameController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _licensePlateController;

  late DateTime _insuranceExpirationDate;

  FuelType? _fuelType;
  Uint8List? _imageOriginalBytes;
  Uint8List? _imageCroppedBytes;
  int _step = 0;

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
      try {
        _imageOriginalBytes = base64Decode(originalB64);
      } on FormatException {
        _imageOriginalBytes = null;
      }
    }

    final croppedB64 = car?.imageBase64;
    if (croppedB64 != null && croppedB64.trim().isNotEmpty) {
      try {
        _imageCroppedBytes = base64Decode(croppedB64);
      } on FormatException {
        _imageCroppedBytes = null;
      }
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
    if (!_validateAll(l10n)) {
      return;
    }

    if (_fuelType == null) {
      AppSnackBar.show(
        context,
        l10n.validation_required(l10n.carData_fuelType),
        isError: true,
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
      fuel: existing?.fuel ?? [],
      inspectionDatas: existing?.inspectionDatas ?? [],
      insuranceDatas: existing?.insuranceDatas ?? [],
      taxDatas: existing?.taxDatas ?? [],
      repairDatas: existing?.repairDatas ?? [],
      fineDatas: existing?.fineDatas ?? [],
    );

    Navigator.of(context).pop(car);
  }

  void _next(AppLocalizations l10n) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_step == _lastStep) {
      _save(l10n);
      return;
    }
    setState(() => _step += 1);
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _step -= 1);
  }

  bool _validateAll(AppLocalizations l10n) {
    final basicsError =
        _validateRequired(
          _nameController.text,
          l10n.carData_name,
          l10n,
          min: 2,
          max: 40,
        ) ??
        _validateRequired(
          _brandController.text,
          l10n.carData_manufacture,
          l10n,
          min: 2,
          max: 40,
        ) ??
        _validateRequired(
          _modelController.text,
          l10n.carData_model,
          l10n,
          max: 40,
        ) ??
        _validateYear(_yearController.text, l10n);
    if (basicsError != null) {
      setState(() => _step = 0);
      _showValidationError(basicsError);
      return false;
    }

    final detailsError =
        _validateLicensePlate(_licensePlateController.text, l10n) ??
        (_fuelType == null
            ? l10n.validation_required(l10n.carData_fuelType)
            : null);
    if (detailsError != null) {
      setState(() => _step = 1);
      _showValidationError(detailsError);
      return false;
    }

    return _formKey.currentState?.validate() ?? true;
  }

  void _showValidationError(String message) {
    AppSnackBar.show(context, message, isError: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.initialCar != null;

    final title = isEdit
        ? l10n.common_editEntity(l10n.cars_car_shortTitle)
        : l10n.common_addEntity(l10n.cars_car_shortTitle);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(title, style: textTheme.titleLarge)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 600 ? 40.0 : 24.0;
            final fieldTextStyle = textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            );
            final maxWidth = constraints.maxWidth >= 900
                ? 720.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          AppSpacing.lg,
                          horizontalPadding,
                          AppSpacing.md,
                        ),
                        child: _CarFormProgress(step: _step),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: AppAnimations.durationNormal,
                          switchInCurve: AppAnimations.curveDefault,
                          switchOutCurve: Curves.easeInCubic,
                          child: ListView(
                            key: ValueKey(_step),
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              AppSpacing.md,
                              horizontalPadding,
                              AppSpacing.xl,
                            ),
                            children: [
                              _StepIntro(
                                title: switch (_step) {
                                  0 => 'Basics',
                                  1 => 'Details',
                                  _ => 'Photo',
                                },
                                subtitle: switch (_step) {
                                  0 =>
                                    'Name the car and add the model information you use to recognize it quickly.',
                                  1 =>
                                    'Add the plate and fuel type so entries can use smarter defaults.',
                                  _ =>
                                    'Add a clear photo for the garage and dashboard. You can skip this for now.',
                                },
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              if (_step == 0)
                                _BasicsStep(
                                  nameController: _nameController,
                                  brandController: _brandController,
                                  modelController: _modelController,
                                  yearController: _yearController,
                                  textStyle:
                                      fieldTextStyle ?? const TextStyle(),
                                  l10n: l10n,
                                  validateRequired:
                                      (value, field, {min = 1, int? max}) =>
                                          _validateRequired(
                                            value,
                                            field,
                                            l10n,
                                            min: min,
                                            max: max,
                                          ),
                                  validateYear: (value) =>
                                      _validateYear(value, l10n),
                                )
                              else if (_step == 1)
                                _DetailsStep(
                                  licensePlateController:
                                      _licensePlateController,
                                  fuelType: _fuelType,
                                  onFuelTypeChanged: (value) {
                                    setState(() => _fuelType = value);
                                  },
                                  textStyle:
                                      fieldTextStyle ?? const TextStyle(),
                                  l10n: l10n,
                                  validateLicensePlate: (value) =>
                                      _validateLicensePlate(value, l10n),
                                )
                              else
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          AppSpacing.md,
                          horizontalPadding,
                          AppSpacing.lg,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _back,
                                child: Text(
                                  _step == 0 ? l10n.common_cancel : 'Back',
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: FilledButton(
                                onPressed: () => _next(l10n),
                                child: Text(
                                  _step == _lastStep
                                      ? l10n.common_save
                                      : 'Next',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickAndCropImage() async {
    try {
      final result = await fp.FilePicker.pickFiles(
        type: fp.FileType.image,
        withData: true,
      );

      final file = result?.files.single;
      if (file == null) return;

      Uint8List? bytes = file.bytes;
      if (bytes == null && file.path != null && !kIsWeb) {
        bytes = await readImageFileBytes(file.path!);
      }
      if (bytes == null || !mounted) return;

      final cropped = await _cropImage(originalBytes: bytes);
      if (cropped == null || !mounted) return;

      setState(() {
        _imageOriginalBytes = bytes;
        _imageCroppedBytes = cropped;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open image picker: $e')),
      );
    }
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

class _CarFormProgress extends StatelessWidget {
  const _CarFormProgress({required this.step});

  final int step;

  static const _labels = ['Basics', 'Details', 'Photo'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < _labels.length; i++) ...[
              _StepDot(
                label: _labels[i],
                isActive: i == step,
                isDone: i < step,
              ),
              if (i != _labels.length - 1)
                Expanded(
                  child: AnimatedContainer(
                    duration: AppAnimations.durationFast,
                    height: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    color: i < step
                        ? AppColors.accentLight
                        : theme.colorScheme.outline,
                  ),
                ),
            ],
          ],
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  final String label;
  final bool isActive;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final color = isActive || isDone
        ? AppColors.accentLight
        : Theme.of(context).colorScheme.onSurfaceVariant;
    return Column(
      children: [
        AnimatedContainer(
          duration: AppAnimations.durationFast,
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: (isActive || isDone)
                ? AppColors.accentLight.withValues(alpha: 0.12)
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: Icon(
            isDone ? Icons.check_rounded : Icons.circle,
            size: isDone ? 18 : 8,
            color: color,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _StepIntro extends StatelessWidget {
  const _StepIntro({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _BasicsStep extends StatelessWidget {
  const _BasicsStep({
    required this.nameController,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.textStyle,
    required this.l10n,
    required this.validateRequired,
    required this.validateYear,
  });

  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextStyle textStyle;
  final AppLocalizations l10n;
  final String? Function(String? value, String fieldLabel, {int min, int? max})
  validateRequired;
  final String? Function(String? value) validateYear;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          style: textStyle,
          decoration: InputDecoration(labelText: l10n.carData_name),
          validator: (value) =>
              validateRequired(value, l10n.carData_name, min: 2, max: 40),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextFormField(
          controller: brandController,
          style: textStyle,
          decoration: InputDecoration(labelText: l10n.carData_manufacture),
          validator: (value) => validateRequired(
            value,
            l10n.carData_manufacture,
            min: 2,
            max: 40,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextFormField(
          controller: modelController,
          style: textStyle,
          decoration: InputDecoration(labelText: l10n.carData_model),
          validator: (value) =>
              validateRequired(value, l10n.carData_model, max: 40),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextFormField(
          controller: yearController,
          style: textStyle,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.carData_yearOfManufacture,
          ),
          validator: validateYear,
        ),
      ],
    );
  }
}

class _DetailsStep extends StatelessWidget {
  const _DetailsStep({
    required this.licensePlateController,
    required this.fuelType,
    required this.onFuelTypeChanged,
    required this.textStyle,
    required this.l10n,
    required this.validateLicensePlate,
  });

  final TextEditingController licensePlateController;
  final FuelType? fuelType;
  final ValueChanged<FuelType?> onFuelTypeChanged;
  final TextStyle textStyle;
  final AppLocalizations l10n;
  final String? Function(String? value) validateLicensePlate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: licensePlateController,
          style: textStyle,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            labelText: l10n.carData_licensePlate,
            prefixIcon: const Icon(Icons.confirmation_number_outlined),
          ),
          validator: validateLicensePlate,
        ),
        const SizedBox(height: AppSpacing.lg),
        DropdownButtonFormField<FuelType>(
          initialValue: fuelType,
          decoration: InputDecoration(
            labelText: l10n.carData_fuelType,
            prefixIcon: const Icon(Icons.local_gas_station_rounded),
          ),
          items: FuelType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(_labelForFuelType(l10n, type), style: textStyle),
                ),
              )
              .toList(),
          onChanged: onFuelTypeChanged,
          validator: (value) {
            if (value == null) {
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
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.primary,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: SizedBox(
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
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
              if (hasImage)
                FilledButton.tonalIcon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  label: Text(
                    l10n.common_delete,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSecondaryContainer,
                    ),
                  ),
                ),
              if (onReCrop != null)
                FilledButton.tonalIcon(
                  onPressed: onReCrop,
                  icon: const Icon(Icons.crop),
                  label: Text(
                    l10n.common_edit,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSecondaryContainer,
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
                      style: theme.textTheme.titleMedium?.copyWith(
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
                        style: theme.textTheme.labelLarge?.copyWith(
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
                        style: theme.textTheme.labelLarge?.copyWith(
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
