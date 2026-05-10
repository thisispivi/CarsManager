import 'package:cars_manager/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppButton invokes callback', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Save',
            icon: Icons.save_rounded,
            onPressed: () => taps++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    expect(taps, 1);
  });
}
