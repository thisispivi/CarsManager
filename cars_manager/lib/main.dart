import 'dart:ui' as ui;
import 'package:cars_manager/core/theme/app_theme.dart';
import 'package:cars_manager/data/car_data.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/l10n/l10n.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/models/fine_data.dart';
import 'package:cars_manager/models/fuel_entry.dart';
import 'package:cars_manager/models/inspection_data.dart';
import 'package:cars_manager/models/insurance_data.dart';
import 'package:cars_manager/models/repair_data.dart';
import 'package:cars_manager/models/tax_data.dart';
import 'package:cars_manager/pages/car_stats.dart';
import 'package:cars_manager/pages/home.dart';
import 'package:cars_manager/pages/settings.dart';
import 'package:cars_manager/presentation/pages/fuel/view/fuel_page.dart';
import 'package:cars_manager/presentation/pages/payments/view/payments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCarData();
  runApp(CarsManager());
}

class CarsManager extends StatelessWidget {
  const CarsManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarsManagerState(),
      child: Consumer<CarsManagerState>(
        builder: (context, state, child) => MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          locale: state.locale,
          theme: AppTheme.getLightTheme(),
          darkTheme: AppTheme.getDarkTheme(),
          themeMode: state.themeMode,
          home: const CarDashboardPage(),
          supportedLocales: L10n.locals,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}

class CarsManagerState extends ChangeNotifier {
  CarsManagerState()
    : _cars = List<Car>.from(loadedCars),
      _activeCarId = loadedActiveCarId {
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    if (L10n.locals.contains(systemLocale)) {
      _locale = systemLocale;
    } else {
      final languageLocale = Locale(systemLocale.languageCode);
      if (L10n.locals.any(
        (locale) => locale.languageCode == systemLocale.languageCode,
      )) {
        _locale = languageLocale;
      } else {
        _locale = const Locale('en');
      }
    }
  }

  final List<Car> _cars;
  String? _activeCarId;

  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.dark;

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
  }

  void updateCar(Car updated) {
    final index = _cars.indexWhere((c) => c.id == updated.id);
    if (index == -1) return;
    _cars[index] = updated;
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
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
  }

  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  void addFuelEntry(FuelEntry entry) {
    final car = activeCar;
    if (car == null) return;
    (car.fuel ??= []).add(entry);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeFuelEntry(FuelEntry entry) {
    final car = activeCar;
    if (car == null) return;
    car.fuel?.remove(entry);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addInsurancePayment(InsuranceData data) {
    final car = activeCar;
    if (car == null) return;
    (car.insuranceDatas ??= []).add(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeInsurancePayment(InsuranceData data) {
    final car = activeCar;
    if (car == null) return;
    car.insuranceDatas?.remove(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addTaxPayment(TaxData data) {
    final car = activeCar;
    if (car == null) return;
    (car.taxDatas ??= []).add(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeTaxPayment(TaxData data) {
    final car = activeCar;
    if (car == null) return;
    car.taxDatas?.remove(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addRepairPayment(RepairData data) {
    final car = activeCar;
    if (car == null) return;
    (car.repairDatas ??= []).add(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeRepairPayment(RepairData data) {
    final car = activeCar;
    if (car == null) return;
    car.repairDatas?.remove(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addInspectionPayment(InspectionData data) {
    final car = activeCar;
    if (car == null) return;
    (car.inspectionDatas ??= []).add(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeInspectionPayment(InspectionData data) {
    final car = activeCar;
    if (car == null) return;
    car.inspectionDatas?.remove(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void addFinePayment(FineData data) {
    final car = activeCar;
    if (car == null) return;
    (car.fineDatas ??= []).add(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }

  void removeFinePayment(FineData data) {
    final car = activeCar;
    if (car == null) return;
    car.fineDatas?.remove(data);
    notifyListeners();
    saveCarData(cars: _cars, activeCarId: _activeCarId);
  }
}

class CarDashboardPage extends StatefulWidget {
  const CarDashboardPage({super.key});

  @override
  State<CarDashboardPage> createState() => _CarDashboardPageState();
}

class _CarDashboardPageState extends State<CarDashboardPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<CarsManagerState>(
      builder: (context, state, child) {
        final l10n = AppLocalizations.of(context)!;
        final activeCar = state.activeCar;

        final Widget page;
        switch (_selectedIndex) {
          case 0:
            page = const CarsHomePage();
            break;
          case 1:
            page = const FuelConsumptionPage();
            break;
          case 2:
            page = const PaymentsPage();
            break;
          default:
            page = const CarStatsPage();
            break;
        }

        return Scaffold(
          key: _scaffoldKey,
          endDrawer: const SettingsDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            title: Row(
              children: [
                Text(l10n.appTitle),
                const SizedBox(width: 12),

                if (activeCar != null)
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          backgroundImage:
                              (activeCar.imageUrl != null &&
                                  activeCar.imageUrl!.isNotEmpty)
                              ? NetworkImage(activeCar.imageUrl!)
                              : null,
                          child:
                              (activeCar.imageUrl == null ||
                                  activeCar.imageUrl!.isEmpty)
                              ? Icon(
                                  Icons.directions_car,
                                  size: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            activeCar.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: l10n.settings_title,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
          body: Container(
            color: Theme.of(context).colorScheme.surface,
            child: page,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 4.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).navigationBarTheme.backgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedFontSize: 14,
              iconSize: 26,
              unselectedFontSize: 12,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_rounded),
                  label: 'Garage',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_gas_station),
                  label: 'Fuel',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.payment),
                  label: 'Payments',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
