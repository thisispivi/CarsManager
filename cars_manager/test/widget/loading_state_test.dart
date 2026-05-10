import 'package:cars_manager/shared/widgets/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoadingState renders without error', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: LoadingState())),
    );

    expect(find.byType(LoadingState), findsOneWidget);
  });

  testWidgets('LoadingState uses provided height', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: LoadingState(height: 200))),
    );

    final container = tester.widget<Container>(find.byType(Container).first);
    expect(container.constraints?.maxHeight, 200);
  });
}
