import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../../core/data/stock_ledger.dart';
import '../../domain/entities/dashboard_entities.dart';

class DashboardRemoteDatasource {
  DashboardRemoteDatasource({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<DashboardSummary> getDashboardSummary() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekAgo = todayStart.subtract(const Duration(days: 7));

    // Operators
    final users = (await _db.collection(Col.users).get()).docs
        .map(DocRow.fromSnapshot)
        .toList();
    final totalOps = users.length;
    final activeOps = users.where((u) => u.flag('isActive')).length;

    // Reports submitted today (frame + sheet health)
    final frameHealth = await _reports.list(Col.frameHealth, startDate: todayStart);
    final sheetHealth = await _reports.list(Col.sheetHealth, startDate: todayStart);
    final pendingCount = frameHealth.length + sheetHealth.length;

    // One week-range query per production collection; "today" is a subset.
    final weekFrame = await _reports.list(Col.frameProductionDetails, startDate: weekAgo);
    final weekSheet = await _reports.list(Col.sheetProductionDetails, startDate: weekAgo);

    bool isToday(DocRow r) => !r.date('date').isBefore(todayStart);
    final todayFrameWeight = weekFrame
        .where(isToday)
        .fold<double>(0, (s, r) => s + r.real('totalWeight'));
    final todaySheetFeet = weekSheet
        .where(isToday)
        .fold<double>(0, (s, r) => s + r.real('totalRunningFeet'));

    Map<String, double> byDay(List<DocRow> rows, String field) {
      final out = <String, double>{};
      for (final r in rows) {
        final d = r.date('date');
        final key = '${d.year}-${d.month}-${d.day}';
        out[key] = (out[key] ?? 0) + r.real(field);
      }
      return out;
    }

    List<DailyProduction> toDailyList(Map<String, double> byDay) {
      return byDay.entries.map((e) {
        final parts = e.key.split('-').map(int.parse).toList();
        return DailyProduction(
          date: DateTime(parts[0], parts[1], parts[2]),
          value: e.value,
        );
      }).toList()..sort((a, b) => a.date.compareTo(b.date));
    }

    final frameStock = await _stock(StockKind.frame);
    final sheetStock = await _stock(StockKind.sheet);

    double avg(List<DocRow> rows) => rows.isEmpty
        ? 0.0
        : rows.map((r) => r.real('efficiencyPercentage')).reduce((a, b) => a + b) /
              rows.length;
    final avgFrameEff = avg(await _reports.list(Col.frameProductionWeight, startDate: weekAgo));
    final avgSheetEff = avg(await _reports.list(Col.sheetRunningFeet, startDate: weekAgo));

    return DashboardSummary(
      totalOperators: totalOps,
      activeOperators: activeOps,
      pendingApprovals: pendingCount,
      todayFrameWeight: todayFrameWeight,
      todaySheetRunningFeet: todaySheetFeet,
      avgFrameEfficiency: avgFrameEff,
      avgSheetEfficiency: avgSheetEff,
      weeklyFrameProduction: toDailyList(byDay(weekFrame, 'totalWeight')),
      weeklySheetProduction: toDailyList(byDay(weekSheet, 'totalRunningFeet')),
      frameStock: frameStock,
      sheetStock: sheetStock,
    );
  }

  Future<StockSummary> _stock(String kind) async {
    final data = await StockLedger.read(_db, kind);
    final breakdown = data.variants
        .map(
          (v) => StockLineItem(
            variant: v.variant,
            density: v.density,
            color: v.color,
            produced: v.produced,
            packed: v.packed,
            rejected: v.rejected,
          ),
        )
        .where((item) => item.inStock != 0)
        .toList()
      ..sort((a, b) => b.inStock.compareTo(a.inStock));
    return StockSummary(
      totalProduced: data.totalProduced,
      totalPacked: data.totalPacked,
      totalRejected: data.totalRejected,
      stockInPlace: data.totalProduced - data.totalPacked - data.totalRejected,
      breakdown: breakdown,
    );
  }
}
