import 'package:cars_manager/core/theme/design_tokens.dart';
import 'package:cars_manager/shared/widgets/status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildPill(StatusLevel status, String label) => MaterialApp(
    home: Scaffold(
      body: Center(
        child: StatusPill(status: status, label: label),
      ),
    ),
  );

  testWidgets('StatusPill renders label text', (tester) async {
    await tester.pumpWidget(buildPill(StatusLevel.ok, 'On time'));
    expect(find.text('On time'), findsOneWidget);
  });

  testWidgets('ok status uses success color', (tester) async {
    await tester.pumpWidget(buildPill(StatusLevel.ok, 'OK'));
    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, AppColors.success);
  });

  testWidgets('upcoming status uses warning color', (tester) async {
    await tester.pumpWidget(buildPill(StatusLevel.upcoming, 'Soon'));
    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, AppColors.warning);
  });

  testWidgets('overdue status uses danger color', (tester) async {
    await tester.pumpWidget(buildPill(StatusLevel.overdue, 'Late'));
    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, AppColors.danger);
  });
}
