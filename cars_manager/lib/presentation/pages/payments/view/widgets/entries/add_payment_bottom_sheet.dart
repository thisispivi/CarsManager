import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/presentation/common/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum PaymentEntryType { insurance, inspection, tax, repair, fine }

class AddPaymentBottomSheet extends StatefulWidget {
  const AddPaymentBottomSheet({
    super.key,
    required this.type,
    this.initialData,
  });

  final PaymentEntryType type;
  final Object? initialData;

  @override
  State<AddPaymentBottomSheet> createState() => _AddPaymentBottomSheetState();
}

class _AddPaymentBottomSheetState extends State<AddPaymentBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _date = DateTime.now();

  final _insuranceCompanyController = TextEditingController();
  final _policyNumberController = TextEditingController();
  DateTime _insuranceStart = DateTime.now();
  DateTime _insuranceEnd = DateTime.now().add(const Duration(days: 365));

  final _mileageController = TextEditingController();
  bool _inspectionPassed = true;

  FineType _fineType = FineType.other;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialData;
    if (initial == null) return;

    switch (widget.type) {
      case PaymentEntryType.insurance:
        final data = initial as InsuranceData;
        _amountController.text = data.premiumAmount.toString();
        _insuranceCompanyController.text = data.insuranceCompany;
        _policyNumberController.text = data.policyNumber;
        _insuranceStart = data.startDate;
        _insuranceEnd = data.endDate;
        return;
      case PaymentEntryType.inspection:
        final data = initial as InspectionData;
        _date = data.date;
        _inspectionPassed = data.isPassed;
        _amountController.text = data.amount?.toString() ?? '';
        _mileageController.text = data.mileage?.toString() ?? '';
        return;
      case PaymentEntryType.tax:
        final data = initial as TaxData;
        _date = data.date;
        _amountController.text = data.amount.toString();
        return;
      case PaymentEntryType.repair:
        final data = initial as RepairData;
        _date = data.date;
        _amountController.text = data.amount.toString();
        _descriptionController.text = data.description;
        return;
      case PaymentEntryType.fine:
        final data = initial as FineData;
        _date = data.date;
        _amountController.text = data.amount.toString();
        _fineType = data.type;
        return;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _insuranceCompanyController.dispose();
    _policyNumberController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd MMM yyyy');

    final isEdit = widget.initialData != null;

    final entityTitle = switch (widget.type) {
      PaymentEntryType.insurance =>
        localizations.payments_insuranceData_shortTitle,
      PaymentEntryType.inspection =>
        localizations.payments_inspectionData_shortTitle,
      PaymentEntryType.tax => localizations.payments_taxData_shortTitle,
      PaymentEntryType.repair => localizations.payments_repairsData_shortTitle,
      PaymentEntryType.fine => localizations.payments_fineData_shortTitle,
    };

    final title = isEdit
        ? localizations.common_editEntity(entityTitle)
        : localizations.common_addEntity(entityTitle);

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
                if (widget.type == PaymentEntryType.insurance) ...[
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: localizations.amount,
                      prefixIcon: const Icon(Icons.euro_rounded),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => _validateRequiredPositive(
                      v,
                      localizations.amount,
                      localizations,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _insuranceCompanyController,
                    decoration: InputDecoration(
                      labelText: localizations.payments_insuranceData_provider,
                      prefixIcon: const Icon(Icons.apartment_rounded),
                    ),
                    validator: (v) => _validateRequiredText(
                      v,
                      localizations.payments_insuranceData_provider,
                      localizations,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _policyNumberController,
                    decoration: InputDecoration(
                      labelText:
                          localizations.payments_insuranceData_policyNumber,
                      prefixIcon: const Icon(Icons.badge_outlined),
                    ),
                    validator: (v) => _validateRequiredText(
                      v,
                      localizations.payments_insuranceData_policyNumber,
                      localizations,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${localizations.common_start}: ${dateFormat.format(_insuranceStart)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final selected = await showCustomDatePicker(
                            context: context,
                            initialDate: _insuranceStart,
                          );
                          if (selected != null) {
                            setState(() {
                              _insuranceStart = selected;
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${localizations.common_end}: ${dateFormat.format(_insuranceEnd)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final selected = await showCustomDatePicker(
                            context: context,
                            initialDate: _insuranceEnd,
                          );
                          if (selected != null) {
                            setState(() {
                              _insuranceEnd = selected;
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
                ] else if (widget.type == PaymentEntryType.inspection) ...[
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
                  const SizedBox(height: 10),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      localizations.payments_inspectionsData_status_passed,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: _inspectionPassed,
                    onChanged: (v) {
                      setState(() {
                        _inspectionPassed = v;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            labelText:
                                '${localizations.amount} (${localizations.common_optional})',
                            prefixIcon: const Icon(Icons.euro_rounded),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (v) => _validateOptionalNonNegative(
                            v,
                            localizations.amount,
                            localizations,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _mileageController,
                          decoration: InputDecoration(
                            labelText:
                                '${localizations.payments_inspectionsData_mileage} (${localizations.common_optional})',
                            prefixIcon: const Icon(Icons.speed_rounded),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (v) => _validateOptionalNonNegative(
                            v,
                            localizations.payments_inspectionsData_mileage,
                            localizations,
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else if (widget.type == PaymentEntryType.fine) ...[
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: localizations.amount,
                      prefixIcon: const Icon(Icons.euro_rounded),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => _validateRequiredPositive(
                      v,
                      localizations.amount,
                      localizations,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<FineType>(
                    initialValue: _fineType,
                    decoration: InputDecoration(
                      labelText: localizations.payments_finesData_type,
                      prefixIcon: const Icon(Icons.report_outlined),
                    ),
                    items: FineType.values
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(_labelForFineType(t, localizations)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        _fineType = v;
                      });
                    },
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
                ] else ...[
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: localizations.amount,
                      prefixIcon: const Icon(Icons.euro_rounded),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => _validateRequiredPositive(
                      v,
                      localizations.amount,
                      localizations,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: widget.type == PaymentEntryType.tax
                          ? '${localizations.common_notes} (${localizations.common_optional})'
                          : localizations.common_description,
                      prefixIcon: const Icon(Icons.notes_rounded),
                    ),
                    validator: widget.type == PaymentEntryType.repair
                        ? (v) => _validateRequiredText(
                            v,
                            localizations.common_description,
                            localizations,
                          )
                        : null,
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
                ],

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

  String? _validateRequiredPositive(
    String? value,
    String field,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.validation_required(field);
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return localizations.validation_number_gt_zero(field);
    }
    return null;
  }

  String? _validateOptionalNonNegative(
    String? value,
    String field,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0) {
      return localizations.validation_number_gte_zero(field);
    }
    return null;
  }

  String? _validateRequiredText(
    String? value,
    String field,
    AppLocalizations localizations,
  ) {
    if (value == null || value.trim().isEmpty) {
      return localizations.validation_required(field);
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amountText = _amountController.text.trim();

    switch (widget.type) {
      case PaymentEntryType.insurance:
        final amount = double.parse(amountText.replaceAll(',', '.'));
        Navigator.of(context).pop(
          InsuranceData(
            insuranceCompany: _insuranceCompanyController.text.trim(),
            policyNumber: _policyNumberController.text.trim(),
            startDate: _insuranceStart,
            endDate: _insuranceEnd,
            premiumAmount: amount,
          ),
        );
        return;
      case PaymentEntryType.tax:
        final amount = double.parse(amountText.replaceAll(',', '.'));
        Navigator.of(context).pop(TaxData(date: _date, amount: amount));
        return;
      case PaymentEntryType.repair:
        final amount = double.parse(amountText.replaceAll(',', '.'));
        Navigator.of(context).pop(
          RepairData(
            date: _date,
            amount: amount,
            description: _descriptionController.text.trim(),
          ),
        );
        return;
      case PaymentEntryType.fine:
        final amount = double.parse(amountText.replaceAll(',', '.'));
        Navigator.of(
          context,
        ).pop(FineData(date: _date, amount: amount, type: _fineType));
        return;
      case PaymentEntryType.inspection:
        final amount = amountText.isEmpty
            ? null
            : double.parse(amountText.replaceAll(',', '.'));
        final mileageText = _mileageController.text.trim();
        final mileage = mileageText.isEmpty
            ? null
            : double.parse(mileageText.replaceAll(',', '.'));
        Navigator.of(context).pop(
          InspectionData(
            date: _date,
            isPassed: _inspectionPassed,
            amount: amount,
            mileage: mileage,
          ),
        );
        return;
    }
  }
}

String _labelForFineType(FineType type, AppLocalizations localizations) {
  switch (type) {
    case FineType.speeding:
      return localizations.fineType_speeding;
    case FineType.parking:
      return localizations.fineType_parking;
    case FineType.redLight:
      return localizations.fineType_redLight;
    case FineType.other:
      return localizations.fineType_other;
  }
}
