import 'package:equatable/equatable.dart';

class DashboardSummary extends Equatable {
  final int totalOperators;
  final int activeOperators;
  final int pendingApprovals;
  final double todayFrameWeight;
  final double todaySheetRunningFeet;
  final double avgFrameEfficiency;
  final double avgSheetEfficiency;
  final List<DailyProduction> weeklyFrameProduction;
  final List<DailyProduction> weeklySheetProduction;
  final StockSummary frameStock;
  final StockSummary sheetStock;

  const DashboardSummary({
    required this.totalOperators,
    required this.activeOperators,
    required this.pendingApprovals,
    required this.todayFrameWeight,
    required this.todaySheetRunningFeet,
    required this.avgFrameEfficiency,
    required this.avgSheetEfficiency,
    required this.weeklyFrameProduction,
    required this.weeklySheetProduction,
    required this.frameStock,
    required this.sheetStock,
  });

  @override
  List<Object?> get props => [
    totalOperators,
    activeOperators,
    pendingApprovals,
    todayFrameWeight,
    todaySheetRunningFeet,
    avgFrameEfficiency,
    avgSheetEfficiency,
    weeklyFrameProduction,
    weeklySheetProduction,
    frameStock,
    sheetStock,
  ];
}

class StockSummary extends Equatable {
  final double totalProduced; // total weight (frames) or running feet (sheets)
  final double totalPacked;
  final double totalRejected;
  final double stockInPlace; // produced - packed - rejected
  final List<StockLineItem> breakdown; // per-variant stock

  const StockSummary({
    required this.totalProduced,
    required this.totalPacked,
    required this.totalRejected,
    required this.stockInPlace,
    this.breakdown = const [],
  });

  @override
  List<Object?> get props => [
    totalProduced,
    totalPacked,
    totalRejected,
    stockInPlace,
    breakdown,
  ];
}

class StockLineItem extends Equatable {
  final String variant; // e.g. "3x2" or "9mm"
  final String density;
  final String color;
  final int produced;
  final int packed;
  final int rejected;

  const StockLineItem({
    required this.variant,
    required this.density,
    required this.color,
    required this.produced,
    required this.packed,
    required this.rejected,
  });

  int get inStock => produced - packed - rejected;

  @override
  List<Object?> get props => [
    variant,
    density,
    color,
    produced,
    packed,
    rejected,
  ];
}

class DailyProduction extends Equatable {
  final DateTime date;
  final double value;

  const DailyProduction({required this.date, required this.value});

  @override
  List<Object?> get props => [date, value];
}
