import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
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
                      _labelForFuelType(localizations, widget.lockedFuelType!),
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
                        controller: _litersController,
                        decoration: InputDecoration(
                          labelText: amountLabel,
                          prefixIcon: Icon(
                            isElectric
                                ? Icons.bolt_outlined
                                : Icons.water_drop_outlined,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (_) => _tryAutoCalculate(),
                        validator: (v) =>
                            _validateDouble(localizations, v, amountLabel),
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
                        onChanged: (_) => _tryAutoCalculate(),
                        validator: (v) =>
                            _validateDouble(localizations, v, priceLabel),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _totalCostController,
                  decoration: InputDecoration(
                    labelText: localizations.fuel_total_cost_label,
                    prefixIcon: const Icon(Icons.euro_rounded),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => _tryAutoCalculate(),
                  validator: (v) => _validateDouble(
                    localizations,
                    v,
                    localizations.fuel_total_cost_label,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${localizations.date}: ${dateFormat.format(_date)}',
                        style: theme.textTheme.bodyMedium,
                      ),
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
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w600,
                        ),
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
                      textStyle: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w700,
                      ),
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
    );
  }

  double? _tryParsePositive(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return null;
    final parsed = double.tryParse(v.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) return null;
    return parsed;
  }

  void _tryAutoCalculate() {
    if (_isAutoUpdating) return;

    final litersRaw = _litersController.text;
    final priceRaw = _pricePerLiterController.text;
    final totalRaw = _totalCostController.text;

    final liters = _tryParsePositive(litersRaw);
    final price = _tryParsePositive(priceRaw);
    final total = _tryParsePositive(totalRaw);

    final litersEmpty = litersRaw.trim().isEmpty;
    final priceEmpty = priceRaw.trim().isEmpty;
    final totalEmpty = totalRaw.trim().isEmpty;

    final validCount =
        (liters != null ? 1 : 0) +
        (price != null ? 1 : 0) +
        (total != null ? 1 : 0);
    if (validCount < 2) return;
    if (validCount == 3) return;

    _isAutoUpdating = true;
    try {
      if (totalEmpty && liters != null && price != null) {
        _totalCostController.text = (liters * price).toStringAsFixed(2);
      } else if (priceEmpty && liters != null && total != null) {
        _pricePerLiterController.text = (total / liters).toStringAsFixed(3);
      } else if (litersEmpty && price != null && total != null) {
        _litersController.text = (total / price).toStringAsFixed(3);
      }
    } finally {
      _isAutoUpdating = false;
    }
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

    final liters = double.parse(_litersController.text.replaceAll(',', '.'));
    final pricePerLiter = double.parse(
      _pricePerLiterController.text.replaceAll(',', '.'),
    );
    final totalCost = double.parse(
      _totalCostController.text.replaceAll(',', '.'),
    );

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
