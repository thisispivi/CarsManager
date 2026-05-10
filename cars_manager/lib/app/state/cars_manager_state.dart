import 'dart:ui' as ui;

import 'package:cars_manager/core/services/notification_service.dart';
import 'package:cars_manager/core/services/preferences_service.dart';
import 'package:cars_manager/data/cars_data.dart';
import 'package:cars_manager/l10n/l10n.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:flutter/material.dart';

class CarsManagerState extends ChangeNotifier {
  CarsManagerState()
    : _cars = List<Car>.from(loadedCars),
      _activeCarId = loadedActiveCarId {
    _notificationPreferences.init();
    _locale = _resolveInitialLocale();
    _themeMode = _resolveInitialThemeMode();
    _notificationsEnabled = loadedNotificationsEnabled ?? true;
    _units = loadedUnits ?? 'metric';
    _currency = loadedCurrency ?? 'EUR';

    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
  }

  final List<Car> _cars;
  final PreferencesService _notificationPreferences = PreferencesService();
  String? _activeCarId;

  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.dark;
  bool _notificationsEnabled = true;
  String _units = 'metric';
  String _currency = 'EUR';

  Locale _resolveInitialLocale() {
    final stored = loadedLocaleCode?.trim();
    if (stored != null && stored.isNotEmpty) {
      final candidate = Locale(stored);
      if (L10n.locals.any((l) => l.languageCode == candidate.languageCode)) {
        return candidate;
      }
    }

    final systemLocale = ui.PlatformDispatcher.instance.locale;
    if (L10n.locals.contains(systemLocale)) {
      return systemLocale;
    }

    final languageLocale = Locale(systemLocale.languageCode);
    if (L10n.locals.any(
      (locale) => locale.languageCode == systemLocale.languageCode,
    )) {
      return languageLocale;
    }

    return const Locale('en');
  }

  ThemeMode _resolveInitialThemeMode() {
    final stored = loadedThemeMode?.trim();
    switch (stored) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
    }
    return ThemeMode.dark;
  }

  List<Car> get cars => List.unmodifiable(_cars);
  String? get activeCarId => _activeCarId;

  Car? get activeCar {
    final id = _activeCarId;
    if (id == null) return null;
    for (final c in _cars) {
      if (c.id == id) return c;
    }
    return null;
  }

  bool get hasActiveCar => activeCar != null;

  Locale? get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get units => _units;
  String get currency => _currency;

  void setActiveCar(String carId) {
    _activeCarId = carId;
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addCar(Car car, {bool setActive = true}) {
    _cars.add(car);
    if (setActive) {
      _activeCarId = car.id;
    }
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
    _syncNotificationsFor(car);
  }

  void updateCar(Car updated) {
    final index = _cars.indexWhere((c) => c.id == updated.id);
    if (index == -1) return;
    _cars[index] = updated;
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
    _syncNotificationsFor(updated);
  }

  void removeCar(String carId) {
    _cars.removeWhere((c) => c.id == carId);
    if (_activeCarId == carId) {
      _activeCarId = _cars.isNotEmpty ? _cars.first.id : null;
    }
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();

    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();

    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void setUnits(String units) {
    _units = units;
    notifyListeners();
    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void setCurrency(String currency) {
    _currency = currency;
    notifyListeners();
    setLoadedPreferences(
      localeCode: _locale?.languageCode,
      themeMode: _themeMode.name,
      notificationsEnabled: _notificationsEnabled,
      units: _units,
      currency: _currency,
    );
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  Future<void> resetAllData() async {
    _cars.clear();
    _activeCarId = null;
    notifyListeners();
    await saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addFuelEntry(FuelEntry entry) {
    _updateActiveCar((car) => car.copyWith(fuel: [...car.fuel, entry]));
  }

  void updateFuelEntry({
    required FuelEntry oldEntry,
    required FuelEntry entry,
  }) {
    _updateActiveCar((car) {
      final index = car.fuel.indexOf(oldEntry);
      if (index == -1) return car;
      final updated = [...car.fuel];
      updated[index] = entry;
      return car.copyWith(fuel: updated);
    });
  }

  void removeFuelEntry(FuelEntry entry) {
    _updateActiveCar((car) => car.copyWith(fuel: [...car.fuel]..remove(entry)));
  }

  void addInsurancePayment(InsuranceData data) {
    _updateActiveCar(
      (car) => car.copyWith(insuranceDatas: [...car.insuranceDatas, data]),
      syncNotifications: true,
    );
  }

  void removeInsurancePayment(InsuranceData data) {
    _updateActiveCar(
      (car) =>
          car.copyWith(insuranceDatas: [...car.insuranceDatas]..remove(data)),
    );
  }

  void updateInsurancePayment({
    required InsuranceData oldData,
    required InsuranceData data,
  }) {
    _updateActiveCar((car) {
      final index = car.insuranceDatas.indexOf(oldData);
      if (index == -1) return car;
      final updated = [...car.insuranceDatas];
      updated[index] = data;
      return car.copyWith(insuranceDatas: updated);
    }, syncNotifications: true);
  }

  void addTaxPayment(TaxData data) {
    _updateActiveCar(
      (car) => car.copyWith(taxDatas: [...car.taxDatas, data]),
      syncNotifications: true,
    );
  }

  void removeTaxPayment(TaxData data) {
    _updateActiveCar(
      (car) => car.copyWith(taxDatas: [...car.taxDatas]..remove(data)),
    );
  }

  void updateTaxPayment({required TaxData oldData, required TaxData data}) {
    _updateActiveCar((car) {
      final index = car.taxDatas.indexOf(oldData);
      if (index == -1) return car;
      final updated = [...car.taxDatas];
      updated[index] = data;
      return car.copyWith(taxDatas: updated);
    }, syncNotifications: true);
  }

  void addRepairPayment(RepairData data) {
    _updateActiveCar(
      (car) => car.copyWith(repairDatas: [...car.repairDatas, data]),
    );
  }

  void removeRepairPayment(RepairData data) {
    _updateActiveCar(
      (car) => car.copyWith(repairDatas: [...car.repairDatas]..remove(data)),
    );
  }

  void updateRepairPayment({
    required RepairData oldData,
    required RepairData data,
  }) {
    _updateActiveCar((car) {
      final index = car.repairDatas.indexOf(oldData);
      if (index == -1) return car;
      final updated = [...car.repairDatas];
      updated[index] = data;
      return car.copyWith(repairDatas: updated);
    });
  }

  void addInspectionPayment(InspectionData data) {
    _updateActiveCar(
      (car) => car.copyWith(inspectionDatas: [...car.inspectionDatas, data]),
      syncNotifications: true,
    );
  }

  void removeInspectionPayment(InspectionData data) {
    _updateActiveCar(
      (car) =>
          car.copyWith(inspectionDatas: [...car.inspectionDatas]..remove(data)),
    );
  }

  void updateInspectionPayment({
    required InspectionData oldData,
    required InspectionData data,
  }) {
    _updateActiveCar((car) {
      final index = car.inspectionDatas.indexOf(oldData);
      if (index == -1) return car;
      final updated = [...car.inspectionDatas];
      updated[index] = data;
      return car.copyWith(inspectionDatas: updated);
    }, syncNotifications: true);
  }

  void addFinePayment(FineData data) {
    _updateActiveCar(
      (car) => car.copyWith(fineDatas: [...car.fineDatas, data]),
    );
  }

  void removeFinePayment(FineData data) {
    _updateActiveCar(
      (car) => car.copyWith(fineDatas: [...car.fineDatas]..remove(data)),
    );
  }

  void updateFinePayment({required FineData oldData, required FineData data}) {
    _updateActiveCar((car) {
      final index = car.fineDatas.indexOf(oldData);
      if (index == -1) return car;
      final updated = [...car.fineDatas];
      updated[index] = data;
      return car.copyWith(fineDatas: updated);
    });
  }

  void _updateActiveCar(
    Car Function(Car) transform, {
    bool notify = true,
    bool syncNotifications = false,
  }) {
    final car = activeCar;
    if (car == null) return;
    final updated = transform(car);
    final index = _cars.indexWhere((c) => c.id == car.id);
    if (index == -1) return;
    _cars[index] = updated;
    if (notify) notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
    if (syncNotifications) _syncNotificationsFor(updated);
  }

  void _syncNotificationsFor(Car car) {
    if (!_notificationsEnabled) return;
    NotificationService().scheduleCarReminders(
      car: car,
      prefs: _notificationPreferences,
    );
  }
}
