import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/pages/fuel/view/widgets/entries/add_fuel_entry_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('computes liters from total cost and price per liter', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: AddFuelEntryBottomSheet()),
      ),
    );

    final litersEditableText = tester.widget<EditableText>(
      find.descendant(
        of: find.widgetWithText(TextFormField, 'Liters'),
        matching: find.byType(EditableText),
      ),
    );
    expect(litersEditableText.readOnly, isTrue);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Total cost'),
      '50',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Price / L'),
      '2',
    );
    await tester.pump();

    expect(find.text('25.00'), findsOneWidget);
    expect(find.text('25.00 x 2.000 = 50.00'), findsOneWidget);
  });
}
