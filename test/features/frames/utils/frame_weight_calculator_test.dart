import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/constants/app_constants.dart';

void main() {
  final weightTable = AppConstants.defaultFrameWeights;

  group('Frame Weight Calculations', () {
    group('frameWeightPerFoot() lookup', () {
      test('3x2 / 0.75 → 0.486', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2', density: '0.75', weightTable: weightTable), 0.486);
      });
      test('3x2 / 0.80 → 0.519', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2', density: '0.80', weightTable: weightTable), 0.519);
      });
      test('3x2 / 0.90 → 0.584', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2', density: '0.90', weightTable: weightTable), 0.584);
      });

      test('4x2 / 0.75 → 0.647', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.75', weightTable: weightTable), 0.647);
      });
      test('4x2 / 0.80 → 0.690', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.80', weightTable: weightTable), 0.690);
      });
      test('4x2 / 0.90 → 0.777', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.90', weightTable: weightTable), 0.777);
      });

      test('4x2.5 / 0.75 → 0.810', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5', density: '0.75', weightTable: weightTable), 0.810);
      });
      test('4x2.5 / 0.80 → 0.864', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5', density: '0.80', weightTable: weightTable), 0.864);
      });
      test('4x2.5 / 0.90 → 0.972', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5', density: '0.90', weightTable: weightTable), 0.972);
      });

      test('5x2.5 / 0.75 → 1.012', () {
        expect(Calculations.frameWeightPerFoot(section: '5x2.5', density: '0.75', weightTable: weightTable), 1.012);
      });
      test('5x2.5 / 0.80 → 1.080', () {
        expect(Calculations.frameWeightPerFoot(section: '5x2.5', density: '0.80', weightTable: weightTable), 1.080);
      });
      test('5x2.5 / 0.90 → 1.215', () {
        expect(Calculations.frameWeightPerFoot(section: '5x2.5', density: '0.90', weightTable: weightTable), 1.215);
      });

      test('3x2 (HR) / 0.75 → 0.486', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2 (HR)', density: '0.75', weightTable: weightTable), 0.486);
      });
      test('3x2 (HR) / 0.80 → 0.519', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2 (HR)', density: '0.80', weightTable: weightTable), 0.519);
      });
      test('3x2 (HR) / 0.90 → 0.584', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2 (HR)', density: '0.90', weightTable: weightTable), 0.584);
      });

      test('4x2.5(HR) / 0.75 → 0.810', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5(HR)', density: '0.75', weightTable: weightTable), 0.810);
      });
      test('4x2.5(HR) / 0.80 → 0.864', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5(HR)', density: '0.80', weightTable: weightTable), 0.864);
      });
      test('4x2.5(HR) / 0.90 → 0.972', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2.5(HR)', density: '0.90', weightTable: weightTable), 0.972);
      });

      test('Window Shutter / 0.75 → 0.648', () {
        expect(Calculations.frameWeightPerFoot(section: 'Window Shutter', density: '0.75', weightTable: weightTable), 0.648);
      });
      test('Window Shutter / 0.80 → 0.691', () {
        expect(Calculations.frameWeightPerFoot(section: 'Window Shutter', density: '0.80', weightTable: weightTable), 0.691);
      });
      test('Window Shutter / 0.90 → 0.778', () {
        expect(Calculations.frameWeightPerFoot(section: 'Window Shutter', density: '0.90', weightTable: weightTable), 0.778);
      });

      test('unknown section returns null', () {
        expect(Calculations.frameWeightPerFoot(section: 'Unknown', density: '0.75', weightTable: weightTable), isNull);
      });

      test('unknown density returns null', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2', density: '0.99', weightTable: weightTable), isNull);
      });

      test('Others density returns null (manual weight used)', () {
        expect(Calculations.frameWeightPerFoot(section: '3x2', density: 'Others', weightTable: weightTable), isNull);
      });
    });

    group('frameWeightPerFoot() numeric key tolerance', () {
      // Master tables are edited by hand, so the density dropdown can hold
      // '0.8' while the weight table stores '0.80'. Both must resolve.
      test("'0.8' matches a '0.80' row", () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.8', weightTable: weightTable), 0.690);
      });

      test("'0.9' matches a '0.90' row", () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.9', weightTable: weightTable), 0.777);
      });

      test("'.75' matches a '0.75' row", () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '.75', weightTable: weightTable), 0.647);
      });

      test('surrounding whitespace is tolerated', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: ' 0.80 ', weightTable: weightTable), 0.690);
      });

      test('a genuinely absent density still returns null', () {
        expect(Calculations.frameWeightPerFoot(section: '4x2', density: '0.85', weightTable: weightTable), isNull);
      });

      test('non-numeric section is still matched exactly only', () {
        expect(Calculations.frameWeightPerFoot(section: '4X2', density: '0.80', weightTable: weightTable), isNull);
      });
    });

    group('sheetWeightPerSqft() numeric key tolerance', () {
      final sheetTable = AppConstants.defaultSheetWeights;

      test("6mm / '0.45' resolves exactly", () {
        expect(Calculations.sheetWeightPerSqft(thickness: '6mm', density: '0.45', weightTable: sheetTable), 0.199);
      });

      test("6mm / '0.5' matches a '0.50' row", () {
        expect(Calculations.sheetWeightPerSqft(thickness: '6mm', density: '0.5', weightTable: sheetTable), 0.221);
      });

      test('unknown thickness returns null', () {
        expect(Calculations.sheetWeightPerSqft(thickness: '99mm', density: '0.45', weightTable: sheetTable), isNull);
      });
    });

    group('framePerPieceWeight()', () {
      test('3x2, 0.75, length=10 → 10 × 0.486 = 4.86', () {
        expect(Calculations.framePerPieceWeight(lengthFeet: 10, weightPerFoot: 0.486), 4.86);
      });

      test('4x2, 0.80, length=6 → 6 × 0.690 = 4.14', () {
        expect(Calculations.framePerPieceWeight(lengthFeet: 6, weightPerFoot: 0.690), 4.14);
      });

      test('Window Shutter, 0.90, length=8 → 8 × 0.778 = 6.224', () {
        expect(Calculations.framePerPieceWeight(lengthFeet: 8, weightPerFoot: 0.778), 6.224);
      });

      test('length=0 → weight=0.0', () {
        expect(Calculations.framePerPieceWeight(lengthFeet: 0, weightPerFoot: 0.486), 0.0);
      });
    });

    group('totalWeight()', () {
      test('quantity=50, perPieceWeight=4.86 → 243.0', () {
        expect(Calculations.totalWeight(50, 4.86), 243.0);
      });

      test('quantity=50, perPieceWeight=3.24 → 162.0', () {
        expect(Calculations.totalWeight(50, 3.24), 162.0);
      });

      test('quantity=0 → 0.0', () {
        expect(Calculations.totalWeight(0, 4.86), 0.0);
      });

      test('perPieceWeight=0 → 0.0', () {
        expect(Calculations.totalWeight(50, 0.0), 0.0);
      });
    });
  });
}
