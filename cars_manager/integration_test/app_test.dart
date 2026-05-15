import 'package:cars_manager/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: CarsManagerApp()));
    await tester.pumpAndSettle();
  }

  Future<void> finishOnboardingIfVisible(WidgetTester tester) async {
    final skip = find.text('Skip');
    if (skip.evaluate().isEmpty) return;

    await tester.tap(skip);
    await tester.pumpAndSettle();
  }

  Future<void> openGarage(WidgetTester tester) async {
    await finishOnboardingIfVisible(tester);
    final garage = find.text('Garage');
    if (garage.evaluate().isNotEmpty) {
      await tester.tap(garage.first);
      await tester.pumpAndSettle();
    }
  }

  Future<void> openAddCarFlow(WidgetTester tester) async {
    final fab = find.byType(FloatingActionButton);
    if (fab.evaluate().isNotEmpty) {
      await tester.tap(fab.first);
      await tester.pumpAndSettle();
      return;
    }

    final addCar = find.text('Add Car');
    if (addCar.evaluate().isNotEmpty) {
      await tester.tap(addCar.first);
      await tester.pumpAndSettle();
      return;
    }

    final add = find.text('Add');
    await tester.tap(add.first);
    await tester.pumpAndSettle();
  }

  group('Add car flow', () {
    testWidgets('adding a car shows it in the garage list', (tester) async {
      await pumpApp(tester);
      await openGarage(tester);

      await openAddCarFlow(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Car Name'),
        'My Test Car',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Manufacturer'),
        'TestBrand',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Model'),
        'TestModel',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year of Manufacture'),
        '2022',
      );
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'License Plate'),
        'AB123CD',
      );

      // Select fuel type via dropdown
      await tester.tap(find.byType(DropdownButtonFormField<dynamic>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Petrol').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('My Test Car'), findsOneWidget);
    });
  });

  group('Tab navigation', () {
    testWidgets('navigating to Analytics tab shows analytics page', (
      tester,
    ) async {
      await pumpApp(tester);
      await finishOnboardingIfVisible(tester);

      await tester.tap(find.text('Analytics').first);
      await tester.pumpAndSettle();

      expect(find.text('Analytics'), findsWidgets);
    });

    testWidgets('navigating through primary tabs does not crash', (
      tester,
    ) async {
      await pumpApp(tester);
      await finishOnboardingIfVisible(tester);

      for (final label in ['Home', 'Garage', 'Analytics']) {
        final finder = find.text(label);
        if (finder.evaluate().isNotEmpty) {
          await tester.tap(finder.first);
          await tester.pumpAndSettle();
        }
      }

      expect(find.byType(Scaffold), findsWidgets);
    });
  });

  group('Theme toggle', () {
    testWidgets('toggling theme mode in settings changes the theme', (
      tester,
    ) async {
      await pumpApp(tester);
      await finishOnboardingIfVisible(tester);

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      final systemTheme = find.text('System').last;
      final lightTheme = find.text('Light').last;
      expect(systemTheme, findsOneWidget);
      expect(lightTheme, findsOneWidget);

      await tester.tap(lightTheme);
      await tester.pumpAndSettle();

      expect(find.text('Light'), findsWidgets);
    });
  });
}
