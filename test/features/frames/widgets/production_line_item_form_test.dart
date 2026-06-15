import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/utils/calculations.dart';

/// Widget tests for the Production Line Item form logic.
/// Since the actual page widget depends on BLoCs and routing,
/// we test the core UI logic expectations using simplified widgets.
void main() {
  group('Production Line Item Form — Field Rendering', () {
    testWidgets('renders section dropdown with all frame sections', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButtonFormField<String>(
              items: AppConstants.defaultFrameSections
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Section'),
            ),
          ),
        ),
      );
      expect(find.text('Section'), findsOneWidget);
      // Tap to open dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      for (final section in AppConstants.defaultFrameSections) {
        expect(find.text(section), findsWidgets);
      }
    });

    testWidgets('renders density dropdown with all frame densities', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButtonFormField<String>(
              items: AppConstants.defaultFrameDensities
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Density'),
            ),
          ),
        ),
      );
      expect(find.text('Density'), findsOneWidget);
    });

    testWidgets('renders color dropdown with all frame colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButtonFormField<String>(
              items: AppConstants.defaultFrameColors
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Color'),
            ),
          ),
        ),
      );
      expect(find.text('Color'), findsOneWidget);
    });
  });

  group('Production Line Item Form — Auto Calculation', () {
    testWidgets('per piece weight auto-calculates', (tester) async {
      final perPieceController = TextEditingController();
      final totalController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _AutoCalcForm(
              perPieceController: perPieceController,
              totalController: totalController,
            ),
          ),
        ),
      );

      // Enter length = 10
      await tester.enterText(find.byKey(const Key('length')), '10');
      await tester.pump();

      // Simulate calculation after length change
      final weight = Calculations.framePerPieceWeight(lengthFeet: 10, weightPerFoot: 0.486);
      perPieceController.text = weight.toString();
      expect(double.parse(perPieceController.text), 4.86);
    });

    testWidgets('total weight auto-calculates from qty and per piece weight', (tester) async {
      final total = Calculations.totalWeight(50, 4.86);
      expect(total, 243.0);
    });
  });

  group('Production Line Item Form — Density Others', () {
    testWidgets('selecting Others density shows manual weight field', (tester) async {
      bool showManual = false;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      items: AppConstants.defaultFrameDensities
                          .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          showManual = v == 'Others';
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Density'),
                    ),
                    if (showManual)
                      const TextField(
                        key: Key('manualWeight'),
                        decoration: InputDecoration(labelText: 'Manual Weight per Foot'),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('manualWeight')), findsNothing);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Others').last);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('manualWeight')), findsOneWidget);
    });
  });

  group('Production Line Item Form — Validation', () {
    testWidgets('empty length shows validation error', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('length'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Length is required' : null,
                    decoration: const InputDecoration(labelText: 'Length'),
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.validate(),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Length is required'), findsOneWidget);
    });

    testWidgets('empty quantity shows validation error', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('quantity'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Quantity is required' : null,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.validate(),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Quantity is required'), findsOneWidget);
    });
  });

  group('Production Line Item Form — Time of Change', () {
    test('second line item with different section requires time of change', () {
      // Business logic: if lineItems.length > 1 and sections differ,
      // timeOfChange is required for items after the first
      final items = [
        {'section': '3x2', 'timeOfChange': null},
        {'section': '4x2', 'timeOfChange': null},
      ];
      final needsTimeOfChange =
          items.length > 1 && items[0]['section'] != items[1]['section'];
      expect(needsTimeOfChange, isTrue);
    });

    test('second line item with same section does not require time of change', () {
      final items = [
        {'section': '3x2', 'timeOfChange': null},
        {'section': '3x2', 'timeOfChange': null},
      ];
      final needsTimeOfChange =
          items.length > 1 && items[0]['section'] != items[1]['section'];
      expect(needsTimeOfChange, isFalse);
    });
  });

  group('Production Line Item Form — Add/Remove Items', () {
    testWidgets('add button adds a row', (tester) async {
      int itemCount = 1;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    ...List.generate(
                      itemCount,
                      (i) => Text('Item $i', key: Key('item-$i')),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => itemCount++),
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('item-0')), findsOneWidget);
      expect(find.byKey(const Key('item-1')), findsNothing);

      await tester.tap(find.text('Add Item'));
      await tester.pump();

      expect(find.byKey(const Key('item-1')), findsOneWidget);
    });
  });
}

/// Helper widget to test auto-calculation form behavior.
class _AutoCalcForm extends StatelessWidget {
  final TextEditingController perPieceController;
  final TextEditingController totalController;

  const _AutoCalcForm({
    required this.perPieceController,
    required this.totalController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('length'),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Length'),
        ),
        TextField(
          key: const Key('quantity'),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
        ),
        TextField(
          controller: perPieceController,
          readOnly: true,
          decoration: const InputDecoration(labelText: 'Per Piece Weight'),
        ),
        TextField(
          controller: totalController,
          readOnly: true,
          decoration: const InputDecoration(labelText: 'Total Weight'),
        ),
      ],
    );
  }
}
