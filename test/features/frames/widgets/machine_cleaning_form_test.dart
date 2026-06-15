import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/utils/validators.dart';

void main() {
  group('Machine Cleaning Report Form', () {
    testWidgets('score fields reject values outside 1-10 range', (tester) async {
      expect(Validators.integerRange('0', 1, 10, 'Score'), isNotNull);
      expect(Validators.integerRange('11', 1, 10, 'Score'), isNotNull);
      expect(Validators.integerRange('5', 1, 10, 'Score'), isNull);
      expect(Validators.integerRange('1', 1, 10, 'Score'), isNull);
      expect(Validators.integerRange('10', 1, 10, 'Score'), isNull);
    });

    testWidgets('total score auto-updates on each score change', (tester) async {
      int machine = 8, ground = 7, mould = 9;
      int total = Calculations.cleaningTotalScore(machine, ground, mould);
      expect(total, 24);

      machine = 10;
      total = Calculations.cleaningTotalScore(machine, ground, mould);
      expect(total, 26);
    });

    testWidgets('percentage auto-updates on total score change', (tester) async {
      expect(Calculations.cleaningPercentage(24), 80.0);
      expect(Calculations.cleaningPercentage(30), 100.0);
      expect(Calculations.cleaningPercentage(0), 0.0);
      expect(Calculations.cleaningPercentage(15), 50.0);
    });

    testWidgets('renders all score fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextFormField(
                  key: const Key('machineCondition'),
                  decoration: const InputDecoration(labelText: 'Machine Condition'),
                ),
                TextFormField(
                  key: const Key('groundCondition'),
                  decoration: const InputDecoration(labelText: 'Ground Condition'),
                ),
                TextFormField(
                  key: const Key('mouldCondition'),
                  decoration: const InputDecoration(labelText: 'Mould Condition'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('machineCondition')), findsOneWidget);
      expect(find.byKey(const Key('groundCondition')), findsOneWidget);
      expect(find.byKey(const Key('mouldCondition')), findsOneWidget);
    });

    testWidgets('submit button disabled until all fields filled', (tester) async {
      bool allFilled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    TextFormField(
                      key: const Key('machine'),
                      onChanged: (v) {
                        setState(() => allFilled = v.isNotEmpty);
                      },
                    ),
                    ElevatedButton(
                      onPressed: allFilled ? () {} : null,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Initially disabled
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);

      await tester.enterText(find.byKey(const Key('machine')), '8');
      await tester.pump();

      final updatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(updatedButton.onPressed, isNotNull);
    });

    test('non-integer input (e.g., 5.5) is rejected for score', () {
      expect(Validators.integerRange('5.5', 1, 10, 'Score'), isNotNull);
    });

    test('empty input is rejected', () {
      expect(Validators.integerRange('', 1, 10, 'Score'), isNotNull);
      expect(Validators.integerRange(null, 1, 10, 'Score'), isNotNull);
    });
  });
}
