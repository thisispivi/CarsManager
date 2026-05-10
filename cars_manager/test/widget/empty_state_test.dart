import 'package:cars_manager/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyState renders title and icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(
            icon: Icons.directions_car_outlined,
            title: 'No cars yet',
          ),
        ),
      ),
    );

    expect(find.text('No cars yet'), findsOneWidget);
    expect(find.byIcon(Icons.directions_car_outlined), findsOneWidget);
  });

  testWidgets('EmptyState shows subtitle when provided', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(
            icon: Icons.info_outline,
            title: 'Empty',
            subtitle: 'Add something to continue',
          ),
        ),
      ),
    );

    expect(find.text('Add something to continue'), findsOneWidget);
  });

  testWidgets('EmptyState shows no action button without actionLabel', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyState(icon: Icons.star, title: 'Empty'),
        ),
      ),
    );

    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(TextButton), findsNothing);
  });

  testWidgets('EmptyState calls onAction when button is tapped', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyState(
            icon: Icons.add,
            title: 'Empty',
            actionLabel: 'Add',
            onAction: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add'));
    expect(tapped, isTrue);
  });
}
