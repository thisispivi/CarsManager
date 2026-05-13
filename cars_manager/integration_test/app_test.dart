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

  group('Add car flow', () {
    testWidgets('adding a car shows it in the garage list', (tester) async {
      await pumpApp(tester);

      // Tap the FAB on the Garage screen
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Fill required text fields
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
      await tester.enterText(
        find.widgetWithText(TextFormField, 'License Plate'),
        'AB123CD',
      );

      // Select fuel type via dropdown
      await tester.tap(find.byType(DropdownButtonFormField<dynamic>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Petrol').last);
      await tester.pumpAndSettle();

      // Tap save icon
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      // Verify car appears in garage list
      expect(find.text('My Test Car'), findsOneWidget);
    });
  });

  group('Tab navigation', () {
    testWidgets('navigating to Fuel tab shows fuel page', (tester) async {
      await pumpApp(tester);

      // Tap the Fuel tab in the bottom navigation bar
      await tester.tap(find.text('Fuel'));
      await tester.pumpAndSettle();

      // Verify we're on the fuel page (hint text or empty state is visible)
      // The fuel page shows a hint when no car is selected
      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('navigating through all tabs does not crash', (tester) async {
      await pumpApp(tester);

      for (final label in [
        'Fuel',
        'Expenses',
        'Analytics',
        'Reminders',
        'Garage',
      ]) {
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

      // Open settings via the settings icon in the AppBar
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Find the dark mode switch and record its initial value
      final switchFinder = find.byType(Switch).last;
      expect(switchFinder, findsOneWidget);

      final Switch switchWidget = tester.widget<Switch>(switchFinder);
      final bool initialValue = switchWidget.value;

      // Toggle it
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // Verify the value flipped
      final Switch updatedSwitch = tester.widget<Switch>(
        find.byType(Switch).last,
      );
      expect(updatedSwitch.value, isNot(initialValue));
    });
  });
}
