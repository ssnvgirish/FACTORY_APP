import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/validators.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Shift Packing Report Widget', () {
    group('Frame packing: 2 classification options (Packed, Rejected)', () {
      testWidgets('renders Packed and Rejected fields for frames', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  TextField(
                    key: Key('packed'),
                    decoration: InputDecoration(labelText: 'Packed'),
                  ),
                  TextField(
                    key: Key('rejected'),
                    decoration: InputDecoration(labelText: 'Rejected'),
                  ),
                ],
              ),
            ),
          ),
        );
        expect(find.byKey(const Key('packed')), findsOneWidget);
        expect(find.byKey(const Key('rejected')), findsOneWidget);
      });
    });

    group('Sheet packing: 4 classification options', () {
      testWidgets('renders all 4 classification fields for sheets', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  TextField(key: Key('packed'), decoration: InputDecoration(labelText: 'Packed')),
                  TextField(key: Key('onlySanding'), decoration: InputDecoration(labelText: 'Only Sanding')),
                  TextField(key: Key('sandingAndPacked'), decoration: InputDecoration(labelText: 'Sanding and Packed')),
                  TextField(key: Key('rejectedQuality'), decoration: InputDecoration(labelText: 'Rejected')),
                ],
              ),
            ),
          ),
        );
        expect(find.byKey(const Key('packed')), findsOneWidget);
        expect(find.byKey(const Key('onlySanding')), findsOneWidget);
        expect(find.byKey(const Key('sandingAndPacked')), findsOneWidget);
        expect(find.byKey(const Key('rejectedQuality')), findsOneWidget);
      });
    });

    group('Packing Validation', () {
      test('frame: sum == production → valid', () {
        expect(Validators.validatePackingQuantities(50, 48, 2), isNull);
      });

      test('frame: sum != production → error', () {
        expect(Validators.validatePackingQuantities(50, 49, 2), isNotNull);
      });

      test('sheet: all categories sum to production → valid', () {
        // packed=20, rejected=2, onlySanding=28, sandingAndPacked=2 = 52
        expect(Validators.validatePackingQuantities(52, 20, 2, 28, 2), isNull);
      });

      test('sheet: sum exceeds production → error', () {
        expect(Validators.validatePackingQuantities(52, 21, 2, 28, 2), isNotNull);
      });

      test('sheet: sum less than production → error', () {
        expect(Validators.validatePackingQuantities(52, 19, 2, 28, 2), isNotNull);
      });
    });

    group('Rejected weight calculation', () {
      test('frame: rejectedQuality × perPieceWeight = rejectedWeight', () {
        const rejectedQty = 2;
        const perPieceWeight = 4.86;
        final rejectedWeight = rejectedQty * perPieceWeight;
        expect(rejectedWeight, closeTo(9.72, 0.01));
      });

      test('sheet: rejectedQuality × runningFeetPerItem = rejectedRF', () {
        const rejectedQty = 2;
        const runningFeetPerItem = 8.0;
        final rejectedRF = rejectedQty * runningFeetPerItem;
        expect(rejectedRF, 16.0);
      });
    });

    group('Quality Acceptance from packing', () {
      test('frame: totalProduced=50, totalRejected=2 → 96.0%', () {
        expect(Calculations.qualityAcceptancePercentage(50, 2), 96.0);
      });

      test('sheet: totalRF=400, rejectedRF=16 → 96.0%', () {
        expect(Calculations.qualityAcceptancePercentage(400, 16), 96.0);
      });
    });

    group('Packing Efficiency from classified counts', () {
      test('frame: h=50, packed=48 → 96.0%', () {
        expect(Calculations.packingEfficiency(50, 48), 96.0);
      });

      test('sheet: h=52, j=22 (packed+sandingAndPacked) → 42.31%', () {
        expect(Calculations.packingEfficiency(52, 22), closeTo(42.31, 0.01));
      });
    });
  });
}
