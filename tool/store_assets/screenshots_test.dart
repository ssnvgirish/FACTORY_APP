// Generates Play Store screenshots by rendering the real app screens in a test,
// against a fake Firestore seeded with fictional demo data (no real staff or
// production data is used).
//
//   flutter test tool/store_assets/screenshots_test.dart
//
// Output: store_assets/screenshots/*.png (1080x2160)

import 'dart:io';
import 'dart:ui' as ui;

import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/core/utils/master_table_seeder.dart';
import 'package:factory_app/features/admin/data/datasources/admin_remote_datasource.dart';
import 'package:factory_app/features/frames/data/datasources/frame_remote_datasource.dart';
import 'package:factory_app/features/frames/domain/entities/frame_entities.dart';
import 'package:factory_app/features/sheets/data/datasources/sheet_remote_datasource.dart';
import 'package:factory_app/features/sheets/domain/entities/sheet_entities.dart';
import 'package:factory_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const _phone = '9000000001';

Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT']!;
  final dir = '$root/bin/cache/artifacts/material_fonts';
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      loader.addFont(Future.value(ByteData.sublistView(File('$dir/$f').readAsBytesSync())));
    }
    await loader.load();
  }

  await load('Roboto', ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf', 'Roboto-Light.ttf']);
  await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
}

Future<void> _settle(WidgetTester t, {int rounds = 10}) async {
  for (var i = 0; i < rounds; i++) {
    await t.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 60)));
    await t.pump(const Duration(milliseconds: 250));
  }
}

Future<void> _seed(FakeFirebaseFirestore db) async {
  await db.doc('users/admin-1').set({
    'uid': '+91$_phone',
    'name': 'Demo Admin',
    'phone': '+91$_phone',
    'email': '',
    'roles': ['admin'],
    'assignedMachines': <String>[],
    'fixedSalary': 30000,
    'isActive': true,
  });
  final operators = [
    ('Ravi Kumar', '9000000002', ['Frame Machine 1']),
    ('Suresh Patil', '9000000003', ['Frame Machine 2']),
    ('Anita Rao', '9000000004', ['Sheet Machine 3']),
  ];
  for (final o in operators) {
    await db.collection('users').add({
      'uid': '+91${o.$2}',
      'name': o.$1,
      'phone': '+91${o.$2}',
      'email': '',
      'roles': ['machine_operator'],
      'assignedMachines': o.$3,
      'fixedSalary': 18000,
      'isActive': true,
    });
  }

  await MasterTableSeeder.seed(sl<AdminRemoteDatasource>());

  final frames = sl<FrameRemoteDataSource>();
  final sheets = sl<SheetRemoteDataSource>();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  const sections = ['3x2', '4x2', '4x2.5'];
  const colors = ['Brown', 'Ivory', 'NFC Color'];

  for (var d = 0; d < 7; d++) {
    final date = today.subtract(Duration(days: d));
    for (final (mi, machine) in ['Frame Machine 1', 'Frame Machine 2'].indexed) {
      final qty = 120 + d * 9 + mi * 25;
      final items = [
        for (var i = 0; i < 3; i++)
          FrameProductionLineItem(
            section: sections[(i + mi) % 3], density: '0.80', color: colors[(i + d) % 3],
            length: 10, quantity: qty ~/ 3, perPieceWeight: 2.4 + i * 0.3,
            totalWeight: (qty ~/ 3) * (2.4 + i * 0.3),
          ),
      ];
      final weight = items.fold<double>(0, (s, e) => s + e.totalWeight);
      await frames.submitProductionDetailsReport(FrameProductionDetailsReport(
        date: date, machineNumber: machine, shift: 'Day Shift', lineItems: items,
        totalQuantity: items.fold<int>(0, (s, e) => s + e.quantity), totalWeight: weight,
        createdBy: '+91900000000${2 + mi}', submittedAt: date.add(const Duration(hours: 18)),
      ));
      await frames.submitProductionWeightReport(FrameProductionWeightReport(
        date: date, machineNumber: machine, shift: 'Day Shift', productionWeight: weight,
        maintenanceWeight: 12, totalProductionWeight: weight + 12, targetWeight: 420,
        efficiencyPercentage: ((weight + 12) / 420 * 100).clamp(0, 100).toDouble(),
        createdBy: '+91900000000${2 + mi}',
      ));
      await frames.submitShiftPackingReport(FrameShiftPackingReport(
        date: date, machineNumber: machine, shift: 'Day Shift',
        lineItems: [
          for (final it in items)
            FramePackingLineItem(
              section: it.section, density: it.density, color: it.color, length: it.length,
              productionQuantity: it.quantity, perPieceWeight: it.perPieceWeight,
              packed: (it.quantity * 0.8).round(), rejectedQuality: 0,
            ),
        ],
        totalRejectedWeight: 0, qualityAcceptancePercentage: 98, packingEfficiency: 80,
        createdBy: '+91900000000${2 + mi}',
      ));
      await frames.submitMachineCleaningReport(MachineCleaningReport(
        date: date, machineNumber: machine, machineCondition: 5, groundCondition: 4,
        mouldCondition: 5, totalScore: 14, percentage: 93, createdBy: '+91900000000${2 + mi}',
      ));
    }

    final sheetItem = SheetProductionLineItem(
      thickness: '9mm', density: '0.80', color: 'Ivory', length: 8, width: 4,
      quantity: 60 + d * 4, sqft: 32, perPieceWeight: 6.5, totalWeight: (60 + d * 4) * 6.5,
      totalRunningFeet: (60 + d * 4) * 8, timeOfChange: null, manualWeightPerSqft: null,
    );
    await sheets.submitProductionDetailsReport(SheetProductionDetailsReport(
      date: date, machineNumber: 'Sheet Machine 3', shift: 'Day Shift', lineItems: [sheetItem],
      totalQuantity: sheetItem.quantity, totalWeight: sheetItem.totalWeight,
      totalRunningFeet: sheetItem.totalRunningFeet, createdBy: '+91900000000${4}',
      submittedAt: date.add(const Duration(hours: 18)),
    ));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('store screenshots', (tester) async {
    final outDir = Directory('store_assets/screenshots')..createSync(recursive: true);
    tester.view.physicalSize = const Size(1080, 2160);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.runAsync(_loadFonts);
    HttpOverrides.global = null; // let google_fonts fetch Source Sans 3
    GoogleFonts.config.allowRuntimeFetching = true;

    final db = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth(
      mockUser: MockUser(uid: 'admin-1', email: '91$_phone@prabitha.app'),
    );
    sl.allowReassignment = true;
    await initDependencies();
    sl.registerLazySingleton<FirebaseFirestore>(() => db);
    sl.registerLazySingleton<FirebaseAuth>(() => auth);

    await tester.runAsync(() async {
      await _seed(db);
      await sl<DropdownConfigProvider>().load();
    });

    final key = GlobalKey();
    await tester.pumpWidget(RepaintBoundary(key: key, child: const FactoryApp()));
    await _settle(tester);

    Future<void> shot(String name) async {
      await _settle(tester, rounds: 8);
      await tester.runAsync(() async {
        final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 3);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File('${outDir.path}/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
      });
    }

    void go(String location) {
      GoRouter.of(tester.element(find.byType(Scaffold).first)).go(location);
    }

    // 1. Login (typed phone, password hidden)
    await tester.enterText(find.byType(TextFormField).at(0), _phone);
    await tester.enterText(find.byType(TextFormField).at(1), 'demo-password');
    await tester.pump();
    await shot('01_login');

    // Sign in through the real flow.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In').first);
    await _settle(tester, rounds: 16);

    await shot('02_home_frames');

    go('/dashboard');
    await _settle(tester, rounds: 16);
    await shot('03_dashboard');

    go('/frames/production');
    await _settle(tester, rounds: 16);
    await shot('04_production_reports');

    go('/frames/weight');
    await _settle(tester, rounds: 16);
    await shot('05_production_weight');

    go('/report');
    await _settle(tester, rounds: 16);
    await shot('06_reports');

    go('/admin');
    await _settle(tester, rounds: 16);
    await shot('07_admin');
  });
}
