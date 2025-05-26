import 'package:car_manager/data/car_data.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/l10n/l10n.dart';
import 'package:car_manager/pages/Home.dart';
import 'package:car_manager/pages/car_stats.dart';
import 'package:car_manager/pages/payments.dart';
import 'package:car_manager/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCarData();
  runApp(CarManager());
}

class CarManager extends StatelessWidget {
  const CarManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarManagerState(),
      child: Consumer<CarManagerState>(
        builder: (context, state, child) => MaterialApp(
          title: 'Car Manager',
          locale: state.locale,
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            colorScheme: ColorScheme.dark(
              surface: Color.fromRGBO(19, 20, 22, 1),
              primary: Color.fromRGBO(255, 255, 255, 1),
              secondary: Color.fromRGBO(158, 171, 184, 1),
              tertiary: Color.fromRGBO(45, 53, 62, 1),
              onSurfaceVariant: Color.fromRGBO(163, 171, 178, 1),
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Color.fromRGBO(30, 33, 36, 1),
              indicatorColor: Color.fromRGBO(30, 33, 36, 1),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            ),
            cardColor: Color.fromRGBO(30, 33, 36, 1),
          ),
          home: DashboardPage(),
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

class CarManagerState extends ChangeNotifier {
  var car = currentCar;

  Locale? _locale;

  CarManagerState() {
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
        _locale = Locale('en');
      }
    }
  }

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = CarStatsPage();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = PaymentsPage();
        break;
      case 4:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: page,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).navigationBarTheme.backgroundColor,
          boxShadow: [
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
          currentIndex: selectedIndex,
          selectedFontSize: 14,
          iconSize: 26,
          unselectedFontSize: 12,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Car Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_gas_station),
              label: 'Fuel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
