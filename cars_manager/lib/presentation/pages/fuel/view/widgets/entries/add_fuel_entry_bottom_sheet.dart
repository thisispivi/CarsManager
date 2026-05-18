import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/presentation/common/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFuelEntryBottomSheet extends StatefulWidget {
  final FuelType? lockedFuelType;
  final FuelEntry? initialEntry;

  const AddFuelEntryBottomSheet({
    super.key,
    this.lockedFuelType,
    this.initialEntry,
  });

  @override
  State<AddFuelEntryBottomSheet> createState() =>
      _AddFuelEntryBottomSheetState();
}

class _AddFuelEntryBottomSheetState extends State<AddFuelEntryBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  FuelType _fuelType = FuelType.diesel;
  final _litersController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _pricePerLiterController = TextEditingController();

  DateTime _date = DateTime.now();

  bool _isAutoUpdating = false;
  String? _calculationText;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialEntry;
    if (initial != null) {
      _fuelType = initial.fuelType;
      _litersController.text = initial.liters.toString();
      _pricePerLiterController.text = initial.pricePerLiter.toString();
      _totalCostController.text = initial.totalCost.toString();
      _date = initial.date;
      _updateCalculationText();
    }

    if (widget.lockedFuelType != null) {
      _fuelType = widget.lockedFuelType!;
    }
  }

  @override
  void dispose() {
    _litersController.dispose();
    _totalCostController.dispose();
    _pricePerLiterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isEdit = widget.initialEntry != null;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('dd MMM yyyy');

    final isElectric = _fuelType == FuelType.electric;
    final amountLabel = isElectric
        ? localizations.fuel_amount_kwh_label
        : localizations.fuel_amount_liters_label;
    final priceLabel = isElectric
        ? localizations.fuel_price_per_kwh_label
        : localizations.fuel_price_per_l_label;

    final title = isEdit
        ? localizations.common_editEntity(localizations.fuel_entry_shortTitle)
        : localizations.fuel_addEntry_title;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.bottomSheetHorizontalPadding,
          vertical: AppDimensions.bottomSheetVerticalPadding,
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (widget.lockedFuelType != null)
                    InputDecorator(
                      decoration: InputDecoration(
                        labelText: localizations.fuel_fuelType_label,
                        prefixIcon: const Icon(Icons.local_gas_station),
                      ),
                      child: Text(
                        _labelForFuelType(
                          localizations,
                          widget.lockedFuelType!,
                        ),
                      ),
                    )
                  else
                    DropdownButtonFormField<FuelType>(
                      initialValue: _fuelType,
                      decoration: InputDecoration(
                        labelText: localizations.fuel_fuelType_label,
                        prefixIcon: const Icon(Icons.local_gas_station),
                      ),
                      items: FuelType.values
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(_labelForFuelType(localizations, t)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          _fuelType = v;
                        });
                      },
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _totalCostController,
                          decoration: InputDecoration(
                            labelText: localizations.fuel_total_cost_label,
                            prefixIcon: const Icon(Icons.euro_rounded),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _recalculateAmountFromCost(),
                          validator: (v) => _validateDouble(
                            localizations,
                            v,
                            localizations.fuel_total_cost_label,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _pricePerLiterController,
                          decoration: InputDecoration(
                            labelText: priceLabel,
                            prefixIcon: const Icon(Icons.price_change_rounded),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _recalculateAmountFromCost(),
                          validator: (v) =>
                              _validateDouble(localizations, v, priceLabel),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _litersController,
                    decoration: InputDecoration(
                      labelText: amountLabel,
                      prefixIcon: Icon(
                        isElectric
                            ? Icons.bolt_outlined
                            : Icons.water_drop_outlined,
                      ),
                    ),
                    readOnly: true,
                    validator: (v) =>
                        _validateDouble(localizations, v, amountLabel),
                  ),
                  if (_calculationText != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      _calculationText!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${localizations.date}: ${dateFormat.format(_date)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            final yesterday = DateTime.now().subtract(
                              const Duration(days: 1),
                            );
                            _date = DateTime(
                              yesterday.year,
                              yesterday.month,
                              yesterday.day,
                            );
                          });
                        },
                        child: const Text('Yesterday'),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final selected = await showCustomDatePicker(
                            context: context,
                            initialDate: _date,
                          );
                          if (selected != null) {
                            setState(() {
                              _date = selected;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: Text(
                          localizations.common_pick,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.check),
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      label: Text(
                        isEdit
                            ? localizations.common_save
                            : localizations.common_add,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double? _tryParsePositive(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return null;
    final parsed = double.tryParse(v.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) return null;
    return parsed;
  }

  void _recalculateAmountFromCost() {
    if (_isAutoUpdating) return;

    final total = _tryParsePositive(_totalCostController.text);
    final price = _tryParsePositive(_pricePerLiterController.text);

    if (total == null || price == null) {
      _updateCalculationText();
      return;
    }

    _isAutoUpdating = true;
    try {
      _litersController.text = (total / price).toStringAsFixed(2);
    } finally {
      _isAutoUpdating = false;
    }
    _updateCalculationText();
  }

  void _updateCalculationText() {
    final amount = _tryParsePositive(_litersController.text);
    final price = _tryParsePositive(_pricePerLiterController.text);
    final total = _tryParsePositive(_totalCostController.text);

    setState(() {
      if (amount == null || price == null || total == null) {
        _calculationText = null;
        return;
      }
      _calculationText =
          '${amount.toStringAsFixed(2)} x ${price.toStringAsFixed(3)} = ${total.toStringAsFixed(2)}';
    });
  }

  String? _validateDouble(
    AppLocalizations localizations,
    String? value,
    String label,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.validation_required(label);
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return localizations.validation_number_gt_zero(label);
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pricePerLiter = _tryParsePositive(_pricePerLiterController.text);
    final totalCost = _tryParsePositive(_totalCostController.text);
    if (pricePerLiter == null || totalCost == null) {
      return;
    }
    final liters = totalCost / pricePerLiter;

    final entry = FuelEntry(
      fuelType: _fuelType,
      liters: liters,
      totalCost: totalCost,
      pricePerLiter: pricePerLiter,
      date: _date,
    );

    Navigator.of(context).pop(entry);
  }
}

String _labelForFuelType(AppLocalizations localizations, FuelType fuelType) {
  switch (fuelType) {
    case FuelType.petrol:
      return localizations.fuelType_petrol;
    case FuelType.diesel:
      return localizations.fuelType_diesel;
    case FuelType.lpg:
      return localizations.fuelType_lpg;
    case FuelType.electric:
      return localizations.fuelType_electric;
    case FuelType.hybrid:
      return localizations.fuelType_hybrid;
  }
}
