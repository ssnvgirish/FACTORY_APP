import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:factory_app/firebase_options.dart';
import 'package:factory_app/generated/dataconnect/default.dart';

/// Run with:
///   flutter test test/integration/seed_database_test.dart
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  test('seed database with sample data', () async {
    final connector = DefaultConnector.instance;

    // ── Users ──
    await _run('Admin User', () => connector.seedAdminUser().execute());
    await _run(
      'Operator 1 (Ravi Kumar)',
      () => connector.seedOperator1().execute(),
    );
    await _run(
      'Operator 2 (Suresh Yadav)',
      () => connector.seedOperator2().execute(),
    );
    await _run(
      'Operator 3 (Amit Sharma)',
      () => connector.seedOperator3().execute(),
    );
    await _run(
      'Operator 4 (Deepak Verma)',
      () => connector.seedOperator4().execute(),
    );
    await _run(
      'Quality Packing Supervisor',
      () => connector.seedQualityPacking().execute(),
    );

    // ── Master Tables ──
    print('\n── Master Tables (Machines) ──');
    await _run(
      'Frame Machine 1',
      () => connector.seedMachineFrame1().execute(),
    );
    await _run(
      'Frame Machine 2',
      () => connector.seedMachineFrame2().execute(),
    );
    await _run(
      'Sheet Machine 3',
      () => connector.seedMachineSheet3().execute(),
    );
    await _run(
      'Sheet Machine 4',
      () => connector.seedMachineSheet4().execute(),
    );
    await _run(
      'Sheet Machine 5',
      () => connector.seedMachineSheet5().execute(),
    );
    await _run('Crusher 1', () => connector.seedMachineCrusher1().execute());
    await _run('Crusher 2', () => connector.seedMachineCrusher2().execute());
    await _run('Crusher 3', () => connector.seedMachineCrusher3().execute());
    await _run(
      'Pulverizer 1',
      () => connector.seedMachinePulverizer1().execute(),
    );
    await _run(
      'Pulverizer 2',
      () => connector.seedMachinePulverizer2().execute(),
    );
    await _run(
      'Pulverizer 3',
      () => connector.seedMachinePulverizer3().execute(),
    );
    await _run('Shredder', () => connector.seedMachineShredder().execute());

    print('\n── Master Tables (Shifts, Roles) ──');
    await _run('Day Shift', () => connector.seedShiftDay().execute());
    await _run('Night Shift', () => connector.seedShiftNight().execute());
    await _run('Role: Operator', () => connector.seedRoleOperator().execute());
    await _run('Role: Quality', () => connector.seedRoleQuality().execute());
    await _run(
      'Role: Frame Senior',
      () => connector.seedRoleFrameSenior().execute(),
    );
    await _run(
      'Role: Sheet Senior',
      () => connector.seedRoleSheetSenior().execute(),
    );
    await _run(
      'Role: Plant Manager',
      () => connector.seedRolePlantManager().execute(),
    );
    await _run('Role: Admin', () => connector.seedRoleAdmin().execute());

    print('\n── Master Tables (Frame Sections, Densities, Colors) ──');
    for (var i = 1; i <= 7; i++) {
      await _run('Frame Section $i', () {
        switch (i) {
          case 1:
            return connector.seedFrameSection1().execute();
          case 2:
            return connector.seedFrameSection2().execute();
          case 3:
            return connector.seedFrameSection3().execute();
          case 4:
            return connector.seedFrameSection4().execute();
          case 5:
            return connector.seedFrameSection5().execute();
          case 6:
            return connector.seedFrameSection6().execute();
          default:
            return connector.seedFrameSection7().execute();
        }
      });
    }
    for (var i = 1; i <= 4; i++) {
      await _run('Frame Density $i', () {
        switch (i) {
          case 1:
            return connector.seedFrameDensity1().execute();
          case 2:
            return connector.seedFrameDensity2().execute();
          case 3:
            return connector.seedFrameDensity3().execute();
          default:
            return connector.seedFrameDensity4().execute();
        }
      });
    }
    await _run('Frame Color 1', () => connector.seedFrameColor1().execute());
    await _run('Frame Color 2', () => connector.seedFrameColor2().execute());
    await _run('Frame Color 3', () => connector.seedFrameColor3().execute());

    print('\n── Master Tables (Sheet Thicknesses, Densities, Colors) ──');
    // Sheet thicknesses 1-21
    final thickSeeds = [
      () => connector.seedSheetThick1().execute(),
      () => connector.seedSheetThick2().execute(),
      () => connector.seedSheetThick3().execute(),
      () => connector.seedSheetThick4().execute(),
      () => connector.seedSheetThick5().execute(),
      () => connector.seedSheetThick6().execute(),
      () => connector.seedSheetThick7().execute(),
      () => connector.seedSheetThick8().execute(),
      () => connector.seedSheetThick9().execute(),
      () => connector.seedSheetThick10().execute(),
      () => connector.seedSheetThick11().execute(),
      () => connector.seedSheetThick12().execute(),
      () => connector.seedSheetThick13().execute(),
      () => connector.seedSheetThick14().execute(),
      () => connector.seedSheetThick15().execute(),
      () => connector.seedSheetThick16().execute(),
      () => connector.seedSheetThick17().execute(),
      () => connector.seedSheetThick18().execute(),
      () => connector.seedSheetThick19().execute(),
      () => connector.seedSheetThick20().execute(),
      () => connector.seedSheetThick21().execute(),
    ];
    for (var i = 0; i < thickSeeds.length; i++) {
      await _run('Sheet Thickness ${i + 1}', thickSeeds[i]);
    }
    for (var i = 1; i <= 8; i++) {
      await _run('Sheet Density $i', () {
        switch (i) {
          case 1:
            return connector.seedSheetDensity1().execute();
          case 2:
            return connector.seedSheetDensity2().execute();
          case 3:
            return connector.seedSheetDensity3().execute();
          case 4:
            return connector.seedSheetDensity4().execute();
          case 5:
            return connector.seedSheetDensity5().execute();
          case 6:
            return connector.seedSheetDensity6().execute();
          case 7:
            return connector.seedSheetDensity7().execute();
          default:
            return connector.seedSheetDensity8().execute();
        }
      });
    }
    for (var i = 1; i <= 5; i++) {
      await _run('Sheet Color $i', () {
        switch (i) {
          case 1:
            return connector.seedSheetColor1().execute();
          case 2:
            return connector.seedSheetColor2().execute();
          case 3:
            return connector.seedSheetColor3().execute();
          case 4:
            return connector.seedSheetColor4().execute();
          default:
            return connector.seedSheetColor5().execute();
        }
      });
    }

    print('\n── Master Tables (Maintenance, Scrap Products, Weights) ──');
    for (var i = 1; i <= 9; i++) {
      await _run('Maintenance $i', () {
        switch (i) {
          case 1:
            return connector.seedMaint1().execute();
          case 2:
            return connector.seedMaint2().execute();
          case 3:
            return connector.seedMaint3().execute();
          case 4:
            return connector.seedMaint4().execute();
          case 5:
            return connector.seedMaint5().execute();
          case 6:
            return connector.seedMaint6().execute();
          case 7:
            return connector.seedMaint7().execute();
          case 8:
            return connector.seedMaint8().execute();
          default:
            return connector.seedMaint9().execute();
        }
      });
    }
    for (var i = 1; i <= 6; i++) {
      await _run('Scrap Product $i', () {
        switch (i) {
          case 1:
            return connector.seedScrapProd1().execute();
          case 2:
            return connector.seedScrapProd2().execute();
          case 3:
            return connector.seedScrapProd3().execute();
          case 4:
            return connector.seedScrapProd4().execute();
          case 5:
            return connector.seedScrapProd5().execute();
          default:
            return connector.seedScrapProd6().execute();
        }
      });
    }

    // Frame Weight lookup rows
    print('\n── Frame Weight Lookup ──');
    for (var i = 1; i <= 21; i++) {
      await _run('Frame Weight $i', () {
        switch (i) {
          case 1:
            return connector.seedFw1().execute();
          case 2:
            return connector.seedFw2().execute();
          case 3:
            return connector.seedFw3().execute();
          case 4:
            return connector.seedFw4().execute();
          case 5:
            return connector.seedFw5().execute();
          case 6:
            return connector.seedFw6().execute();
          case 7:
            return connector.seedFw7().execute();
          case 8:
            return connector.seedFw8().execute();
          case 9:
            return connector.seedFw9().execute();
          case 10:
            return connector.seedFw10().execute();
          case 11:
            return connector.seedFw11().execute();
          case 12:
            return connector.seedFw12().execute();
          case 13:
            return connector.seedFw13().execute();
          case 14:
            return connector.seedFw14().execute();
          case 15:
            return connector.seedFw15().execute();
          case 16:
            return connector.seedFw16().execute();
          case 17:
            return connector.seedFw17().execute();
          case 18:
            return connector.seedFw18().execute();
          case 19:
            return connector.seedFw19().execute();
          case 20:
            return connector.seedFw20().execute();
          default:
            return connector.seedFw21().execute();
        }
      });
    }

    // Salary weightages
    print('\n── Salary Weightages ──');
    await _run('Salary wA', () => connector.seedSalaryWa().execute());
    await _run('Salary wB', () => connector.seedSalaryWb().execute());
    await _run('Salary wC', () => connector.seedSalaryWc().execute());
    await _run('Salary wD', () => connector.seedSalaryWd().execute());
    await _run('Salary wE', () => connector.seedSalaryWe().execute());
    await _run('Salary wF', () => connector.seedSalaryWf().execute());
    await _run(
      'Scrap Salary wA',
      () => connector.seedScrapSalaryWa().execute(),
    );
    await _run(
      'Scrap Salary wB',
      () => connector.seedScrapSalaryWb().execute(),
    );
    await _run(
      'Scrap Salary wE',
      () => connector.seedScrapSalaryWe().execute(),
    );
    await _run(
      'Scrap Salary wF',
      () => connector.seedScrapSalaryWf().execute(),
    );
    await _run(
      'Scrap Salary wG',
      () => connector.seedScrapSalaryWg().execute(),
    );

    // ── Frame Cleaning Reports ──
    print('\n── Frame Cleaning Reports ──');
    await _run(
      'Frame Cleaning 1',
      () => connector.seedFrameCleaning1().execute(),
    );
    await _run(
      'Frame Cleaning 2',
      () => connector.seedFrameCleaning2().execute(),
    );
    await _run(
      'Frame Cleaning 3',
      () => connector.seedFrameCleaning3().execute(),
    );
    await _run(
      'Frame Cleaning 4',
      () => connector.seedFrameCleaning4().execute(),
    );
    await _run(
      'Frame Cleaning 5',
      () => connector.seedFrameCleaning5().execute(),
    );

    // ── Frame Tools Count Reports ──
    print('\n── Frame Tools Count Reports ──');
    await _run('Frame Tools 1', () => connector.seedFrameTools1().execute());
    await _run('Frame Tools 2', () => connector.seedFrameTools2().execute());
    await _run('Frame Tools 3', () => connector.seedFrameTools3().execute());
    await _run('Frame Tools 4', () => connector.seedFrameTools4().execute());

    // ── Frame Health Reports ──
    print('\n── Frame Health Reports ──');
    await _run('Frame Health 1', () => connector.seedFrameHealth1().execute());
    await _run('Frame Health 2', () => connector.seedFrameHealth2().execute());
    await _run('Frame Health 3', () => connector.seedFrameHealth3().execute());

    // ── Frame Production Weight Reports ──
    print('\n── Frame Production Weight Reports ──');
    await _run('Frame Weight 1', () => connector.seedFrameWeight1().execute());
    await _run('Frame Weight 2', () => connector.seedFrameWeight2().execute());
    await _run('Frame Weight 3', () => connector.seedFrameWeight3().execute());
    await _run('Frame Weight 4', () => connector.seedFrameWeight4().execute());

    // ── Sheet Cleaning Reports ──
    print('\n── Sheet Cleaning Reports ──');
    await _run(
      'Sheet Cleaning 1',
      () => connector.seedSheetCleaning1().execute(),
    );
    await _run(
      'Sheet Cleaning 2',
      () => connector.seedSheetCleaning2().execute(),
    );
    await _run(
      'Sheet Cleaning 3',
      () => connector.seedSheetCleaning3().execute(),
    );
    await _run(
      'Sheet Cleaning 4',
      () => connector.seedSheetCleaning4().execute(),
    );
    await _run(
      'Sheet Cleaning 5',
      () => connector.seedSheetCleaning5().execute(),
    );

    // ── Sheet Running Feet Reports ──
    print('\n── Sheet Running Feet Reports ──');
    await _run(
      'Sheet Running Feet 1',
      () => connector.seedSheetRunningFeet1().execute(),
    );
    await _run(
      'Sheet Running Feet 2',
      () => connector.seedSheetRunningFeet2().execute(),
    );
    await _run(
      'Sheet Running Feet 3',
      () => connector.seedSheetRunningFeet3().execute(),
    );

    // ── Salary Calculations ──
    print('\n── Salary Calculations ──');
    await _run('Salary Op-1 (Ravi)', () => connector.seedSalaryOp1().execute());
    await _run(
      'Salary Op-2 (Suresh)',
      () => connector.seedSalaryOp2().execute(),
    );
    await _run('Salary Op-3 (Amit)', () => connector.seedSalaryOp3().execute());
    await _run(
      'Salary Op-4 (Deepak)',
      () => connector.seedSalaryOp4().execute(),
    );

    // ── Writing Efficiency ──
    print('\n── Writing Efficiency ──');
    await _run(
      'Frame Writing 1',
      () => connector.seedFrameWriting1().execute(),
    );
    await _run(
      'Frame Writing 2',
      () => connector.seedFrameWriting2().execute(),
    );
    await _run(
      'Frame Writing 3',
      () => connector.seedFrameWriting3().execute(),
    );
    await _run(
      'Sheet Writing 1',
      () => connector.seedSheetWriting1().execute(),
    );
    await _run(
      'Sheet Writing 2',
      () => connector.seedSheetWriting2().execute(),
    );

    // ── Scrap/Regrind Operators ──
    print('\n── Scrap/Regrind Operators ──');
    await _run(
      'Scrap Operator 1 (Rajesh)',
      () => connector.seedScrapOperator1().execute(),
    );
    await _run(
      'Scrap Operator 2 (Manoj)',
      () => connector.seedScrapOperator2().execute(),
    );

    // ── Scrap master data already seeded above ──

    // ── Scrap Cleaning Reports ──
    print('\n── Scrap Cleaning Reports ──');
    await _run(
      'Scrap Cleaning 1',
      () => connector.seedScrapCleaning1().execute(),
    );
    await _run(
      'Scrap Cleaning 2',
      () => connector.seedScrapCleaning2().execute(),
    );
    await _run(
      'Scrap Cleaning 3',
      () => connector.seedScrapCleaning3().execute(),
    );
    await _run(
      'Scrap Cleaning 4',
      () => connector.seedScrapCleaning4().execute(),
    );

    // ── Scrap Tools Count Reports ──
    print('\n── Scrap Tools Count Reports ──');
    await _run('Scrap Tools 1', () => connector.seedScrapTools1().execute());
    await _run('Scrap Tools 2', () => connector.seedScrapTools2().execute());
    await _run('Scrap Tools 3', () => connector.seedScrapTools3().execute());

    // ── Scrap Production Weight Reports ──
    print('\n── Scrap Production Weight Reports ──');
    await _run(
      'Scrap Prod Weight 1',
      () => connector.seedScrapProdWeight1().execute(),
    );
    await _run(
      'Scrap Prod Weight 2',
      () => connector.seedScrapProdWeight2().execute(),
    );
    await _run(
      'Scrap Prod Weight 3',
      () => connector.seedScrapProdWeight3().execute(),
    );

    // ── Scrap Writing Efficiency ──
    print('\n── Scrap Writing Efficiency ──');
    await _run(
      'Scrap Writing 1',
      () => connector.seedScrapWriting1().execute(),
    );
    await _run(
      'Scrap Writing 2',
      () => connector.seedScrapWriting2().execute(),
    );
    await _run(
      'Scrap Writing 3',
      () => connector.seedScrapWriting3().execute(),
    );

    // ── Scrap Quality Reports ──
    print('\n── Scrap Quality Reports ──');
    await _run(
      'Scrap Quality 1',
      () => connector.seedScrapQuality1().execute(),
    );
    await _run(
      'Scrap Quality 2',
      () => connector.seedScrapQuality2().execute(),
    );
    await _run(
      'Scrap Quality 3',
      () => connector.seedScrapQuality3().execute(),
    );
    await _run(
      'Scrap Quality 4',
      () => connector.seedScrapQuality4().execute(),
    );

    // ── Scrap Salary Calculations ──
    print('\n── Scrap Salary Calculations ──');
    await _run(
      'Scrap Salary Op-5 (Rajesh)',
      () => connector.seedScrapSalary1().execute(),
    );
    await _run(
      'Scrap Salary Op-6 (Manoj)',
      () => connector.seedScrapSalary2().execute(),
    );

    print('\n  Seeding Complete!');
  }, timeout: const Timeout(Duration(minutes: 5)));
}

Future<void> _run(String label, Future<void> Function() fn) async {
  try {
    await fn();
    print('  ✓ $label');
  } catch (e) {
    print('  ✗ $label: $e');
  }
}
