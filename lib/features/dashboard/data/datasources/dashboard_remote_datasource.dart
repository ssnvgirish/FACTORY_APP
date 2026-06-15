import '../../../../generated/dataconnect/default.dart';
import '../../domain/entities/dashboard_entities.dart';

class DashboardRemoteDatasource {
  final DefaultConnector _connector;

  DashboardRemoteDatasource({DefaultConnector? connector})
    : _connector = connector ?? DefaultConnector.instance;

  Future<DashboardSummary> getDashboardSummary() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekAgo = todayStart.subtract(const Duration(days: 7));

    // Operator counts
    final usersResult = await _connector.listAllUsers().execute();
    final totalOps = usersResult.data.users.length;
    final activeOps = usersResult.data.users.where((u) => u.isActive).length;

    // Health reports count (today) - use both frame + sheet
    final frameHealthResult = await _connector
        .listFrameHealthReports()
        .startDate(todayStart)
        .execute();
    final sheetHealthResult = await _connector
        .listSheetHealthReports()
        .startDate(todayStart)
        .execute();
    final pendingCount =
        frameHealthResult.data.frameHealthReports.length +
        sheetHealthResult.data.sheetHealthReports.length;

    // Today's frame production
    final todayFrameResult = await _connector
        .listFrameProductionDetailsReports()
        .startDate(todayStart)
        .execute();
    double todayFrameWeight = 0;
    for (final r in todayFrameResult.data.frameProductionDetailsReports) {
      todayFrameWeight += r.totalWeight;
    }

    // Today's sheet production
    final todaySheetResult = await _connector
        .listSheetProductionDetailsReports()
        .startDate(todayStart)
        .execute();
    double todaySheetFeet = 0;
    for (final r in todaySheetResult.data.sheetProductionDetailsReports) {
      todaySheetFeet += r.totalRunningFeet;
    }

    // Weekly frame production
    final weekFrameResult = await _connector
        .listFrameProductionDetailsReports()
        .startDate(weekAgo)
        .execute();
    final Map<String, double> frameByDay = {};
    for (final r in weekFrameResult.data.frameProductionDetailsReports) {
      final date = r.date;
      final key = '${date.year}-${date.month}-${date.day}';
      frameByDay[key] = (frameByDay[key] ?? 0) + r.totalWeight;
    }

    // Weekly sheet production
    final weekSheetResult = await _connector
        .listSheetProductionDetailsReports()
        .startDate(weekAgo)
        .execute();
    final Map<String, double> sheetByDay = {};
    for (final r in weekSheetResult.data.sheetProductionDetailsReports) {
      final date = r.date;
      final key = '${date.year}-${date.month}-${date.day}';
      sheetByDay[key] = (sheetByDay[key] ?? 0) + r.totalRunningFeet;
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

    // ─── Frame Stock ───
    final allFrameProdResult = await _connector
        .listFrameProductionDetailsReports()
        .execute();
    double totalFrameProduced = 0;
    final Map<String, _VariantAcc> frameVariants = {};
    for (final r in allFrameProdResult.data.frameProductionDetailsReports) {
      totalFrameProduced += r.totalWeight;
      for (final li in r.frameProductionLineItems_on_report) {
        final key = '${li.section}|${li.density}|${li.color}';
        final acc = frameVariants.putIfAbsent(key, _VariantAcc.new);
        acc.produced += li.quantity;
      }
    }

    final allFramePackResult = await _connector
        .listFrameShiftPackingReports()
        .execute();
    double totalFramePacked = 0;
    double totalFrameRejected = 0;
    for (final r in allFramePackResult.data.frameShiftPackingReports) {
      for (final li in r.framePackingLineItems_on_report) {
        totalFramePacked += li.packed * li.perPieceWeight;
        totalFrameRejected += li.rejectedQuality * li.perPieceWeight;
        final key = '${li.section}|${li.density}|${li.color}';
        final acc = frameVariants.putIfAbsent(key, _VariantAcc.new);
        acc.packed += li.packed;
        acc.rejected += li.rejectedQuality;
      }
    }

    final frameBreakdown =
        frameVariants.entries
            .map((e) {
              final parts = e.key.split('|');
              return StockLineItem(
                variant: parts[0],
                density: parts[1],
                color: parts[2],
                produced: e.value.produced,
                packed: e.value.packed,
                rejected: e.value.rejected,
              );
            })
            .where((item) => item.inStock != 0)
            .toList()
          ..sort((a, b) => b.inStock.compareTo(a.inStock));

    final frameStock = StockSummary(
      totalProduced: totalFrameProduced,
      totalPacked: totalFramePacked,
      totalRejected: totalFrameRejected,
      stockInPlace: totalFrameProduced - totalFramePacked - totalFrameRejected,
      breakdown: frameBreakdown,
    );

    // ─── Sheet Stock ───
    final allSheetProdResult = await _connector
        .listSheetProductionDetailsReports()
        .execute();
    double totalSheetProduced = 0;
    final Map<String, _VariantAcc> sheetVariants = {};
    for (final r in allSheetProdResult.data.sheetProductionDetailsReports) {
      totalSheetProduced += r.totalRunningFeet;
      for (final li in r.sheetProductionLineItems_on_report) {
        final key = '${li.thickness}|${li.density}|${li.color}';
        final acc = sheetVariants.putIfAbsent(key, _VariantAcc.new);
        acc.produced += li.quantity;
      }
    }

    final allSheetPackResult = await _connector
        .listSheetShiftPackingReports()
        .execute();
    double totalSheetPacked = 0;
    double totalSheetRejected = 0;
    for (final r in allSheetPackResult.data.sheetShiftPackingReports) {
      for (final li in r.sheetPackingLineItems_on_report) {
        totalSheetPacked += li.packed * li.runningFeetPerItem;
        totalSheetRejected += li.rejectedQuality * li.runningFeetPerItem;
        final key = '${li.thickness}|${li.density}|${li.color}';
        final acc = sheetVariants.putIfAbsent(key, _VariantAcc.new);
        acc.packed += li.packed;
        acc.rejected += li.rejectedQuality;
      }
    }

    final sheetBreakdown =
        sheetVariants.entries
            .map((e) {
              final parts = e.key.split('|');
              return StockLineItem(
                variant: parts[0],
                density: parts[1],
                color: parts[2],
                produced: e.value.produced,
                packed: e.value.packed,
                rejected: e.value.rejected,
              );
            })
            .where((item) => item.inStock != 0)
            .toList()
          ..sort((a, b) => b.inStock.compareTo(a.inStock));

    final sheetStock = StockSummary(
      totalProduced: totalSheetProduced,
      totalPacked: totalSheetPacked,
      totalRejected: totalSheetRejected,
      stockInPlace: totalSheetProduced - totalSheetPacked - totalSheetRejected,
      breakdown: sheetBreakdown,
    );

    // Avg efficiency from weight/running-feet reports
    final frameWeightResult = await _connector
        .listFrameProductionWeightReports()
        .startDate(weekAgo)
        .execute();
    final frameEffs = frameWeightResult.data.frameProductionWeightReports
        .map((r) => r.efficiencyPercentage)
        .toList();
    final avgFrameEff = frameEffs.isEmpty
        ? 0.0
        : frameEffs.reduce((a, b) => a + b) / frameEffs.length;

    final sheetFeetResult = await _connector
        .listSheetRunningFeetReports()
        .startDate(weekAgo)
        .execute();
    final sheetEffs = sheetFeetResult.data.sheetRunningFeetReports
        .map((r) => r.efficiencyPercentage)
        .toList();
    final avgSheetEff = sheetEffs.isEmpty
        ? 0.0
        : sheetEffs.reduce((a, b) => a + b) / sheetEffs.length;

    return DashboardSummary(
      totalOperators: totalOps,
      activeOperators: activeOps,
      pendingApprovals: pendingCount,
      todayFrameWeight: todayFrameWeight,
      todaySheetRunningFeet: todaySheetFeet,
      avgFrameEfficiency: avgFrameEff,
      avgSheetEfficiency: avgSheetEff,
      weeklyFrameProduction: toDailyList(frameByDay),
      weeklySheetProduction: toDailyList(sheetByDay),
      frameStock: frameStock,
      sheetStock: sheetStock,
    );
  }
}

class _VariantAcc {
  int produced = 0;
  int packed = 0;
  int rejected = 0;
}
