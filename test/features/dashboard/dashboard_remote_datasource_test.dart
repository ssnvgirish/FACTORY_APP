import 'package:factory_app/core/data/firestore_support.dart';
import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:factory_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('summary combines bounded queries and stock counters', () async {
    final db = FakeFirebaseFirestore();
    final today = DateTime.now();
    final todayKey = dateKey(today);
    final threeDaysAgo = dateKey(today.subtract(const Duration(days: 3)));
    final longAgo = dateKey(today.subtract(const Duration(days: 40)));

    await db.doc('users/a').set({'uid': '1', 'isActive': true});
    await db.doc('users/b').set({'uid': '2', 'isActive': false});

    await db.collection('frame_health_reports').add({'date': todayKey});
    await db.collection('sheet_health_reports').add({'date': todayKey});
    await db.collection('sheet_health_reports').add({'date': longAgo});

    await db.collection('frame_production_details_reports').add({'date': todayKey, 'totalWeight': 50.0});
    await db.collection('frame_production_details_reports').add({'date': threeDaysAgo, 'totalWeight': 30.0});
    await db.collection('frame_production_details_reports').add({'date': longAgo, 'totalWeight': 999.0});
    await db.collection('sheet_production_details_reports').add({'date': todayKey, 'totalRunningFeet': 70.0});

    await db.collection('frame_production_weight_reports').add({'date': todayKey, 'efficiencyPercentage': 80.0});
    await db.collection('frame_production_weight_reports').add({'date': threeDaysAgo, 'efficiencyPercentage': 60.0});
    await db.collection('sheet_running_feet_reports').add({'date': todayKey, 'efficiencyPercentage': 90.0});

    final batch = db.batch();
    StockLedger.apply(batch, db, kind: StockKind.frame, producedAmount: 100, lines: const [
      StockLine(variant: '3x2', density: '0.8', color: 'White', produced: 10, packed: 4, rejected: 1,
          packedAmount: 20, rejectedAmount: 5),
      StockLine(variant: '4x2', density: '0.8', color: 'White', produced: 5, packed: 5),
    ]);
    await batch.commit();

    final s = await DashboardRemoteDatasource(firestore: db).getDashboardSummary();
    expect(s.totalOperators, 2);
    expect(s.activeOperators, 1);
    expect(s.pendingApprovals, 2);
    expect(s.todayFrameWeight, 50);
    expect(s.todaySheetRunningFeet, 70);
    expect(s.weeklyFrameProduction.map((d) => d.value).toList()..sort(), [30, 50]);
    expect(s.avgFrameEfficiency, 70);
    expect(s.avgSheetEfficiency, 90);
    expect(s.frameStock.totalProduced, 100);
    expect(s.frameStock.totalPacked, 20);
    expect(s.frameStock.totalRejected, 5);
    expect(s.frameStock.stockInPlace, 75);
    // 4x2 is fully packed (inStock == 0) so it is filtered out of the breakdown.
    expect(s.frameStock.breakdown.single.variant, '3x2');
    expect(s.frameStock.breakdown.single.inStock, 5);
    expect(s.sheetStock.totalProduced, 0);
  });
}
