import 'package:cars_manager/shared/widgets/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ErrorState shows message and error icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ErrorState(message: 'Network error')),
      ),
    );

    expect(find.text('Network error'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('ErrorState without onRetry shows no retry button', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ErrorState(message: 'Oops')),
      ),
    );

    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('ErrorState with onRetry shows retry button and calls it', (
    tester,
  ) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorState(message: 'Failed', onRetry: () => retried = true),
        ),
      ),
    );

    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });
}
