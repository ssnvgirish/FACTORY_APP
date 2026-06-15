import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/dashboard_entities.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/wudsy_nfc_logo.png',
              height: 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text('Report'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<DashboardBloc>().add(RefreshDashboard()),
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) return const LoadingWidget();
          if (state is DashboardError) {
            debugPrint('DashboardError: ${state.message}');
            return EmptyStateWidget(
              message: 'Something went wrong',
              icon: Icons.error_outline,
              actionLabel: 'Retry',
              onAction: () =>
                  context.read<DashboardBloc>().add(LoadDashboard()),
            );
          }
          if (state is DashboardLoaded) {
            return _DashboardContent(summary: state.summary);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardSummary summary;
  const _DashboardContent({required this.summary});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(RefreshDashboard());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Operators',
                    value:
                        '${summary.activeOperators}/${summary.totalOperators}',
                    icon: Icons.people,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Pending Approvals',
                    value: summary.pendingApprovals.toString(),
                    icon: Icons.pending_actions,
                    color: summary.pendingApprovals > 0
                        ? AppTheme.accentOrange
                        : AppTheme.successGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: "Today's Frames",
                    value: '${summary.todayFrameWeight.toStringAsFixed(0)} lbs',
                    icon: Icons.window,
                    color: AppTheme.accentAmber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: "Today's Sheets",
                    value:
                        '${summary.todaySheetRunningFeet.toStringAsFixed(0)} ft',
                    icon: Icons.layers,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Frame Efficiency',
                    value: '${summary.avgFrameEfficiency.toStringAsFixed(1)}%',
                    icon: Icons.speed,
                    color: _efficiencyColor(summary.avgFrameEfficiency),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Sheet Efficiency',
                    value: '${summary.avgSheetEfficiency.toStringAsFixed(1)}%',
                    icon: Icons.speed,
                    color: _efficiencyColor(summary.avgSheetEfficiency),
                  ),
                ),
              ],
            ),

            // Charts
            const SizedBox(height: 24),

            // Stock In Place
            const SectionHeader(title: 'Stock In Place'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _StockCard(
                    title: 'Frame Stock',
                    produced: summary.frameStock.totalProduced,
                    packed: summary.frameStock.totalPacked,
                    rejected: summary.frameStock.totalRejected,
                    stockInPlace: summary.frameStock.stockInPlace,
                    unit: 'kg',
                    color: AppTheme.accentAmber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StockCard(
                    title: 'Sheet Stock',
                    produced: summary.sheetStock.totalProduced,
                    packed: summary.sheetStock.totalPacked,
                    rejected: summary.sheetStock.totalRejected,
                    stockInPlace: summary.sheetStock.stockInPlace,
                    unit: 'ft',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            // Stock Breakdown
            if (summary.frameStock.breakdown.isNotEmpty) ...[
              const SizedBox(height: 24),
              const SectionHeader(title: 'Frame Stock by Size'),
              _StockBreakdownTable(
                items: summary.frameStock.breakdown,
                unit: 'kg',
              ),
            ],
            if (summary.sheetStock.breakdown.isNotEmpty) ...[
              const SizedBox(height: 24),
              const SectionHeader(title: 'Sheet Stock by Size'),
              _StockBreakdownTable(
                items: summary.sheetStock.breakdown,
                unit: 'ft',
              ),
            ],

            // Weekly Production Data
            const SizedBox(height: 24),
            const SectionHeader(title: 'Weekly Frame Production (kg)'),
            _WeeklyProductionTable(
              data: summary.weeklyFrameProduction,
              unit: 'kg',
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: _ProductionChart(
                data: summary.weeklyFrameProduction,
                color: AppTheme.accentAmber,
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Weekly Sheet Production (ft)'),
            _WeeklyProductionTable(
              data: summary.weeklySheetProduction,
              unit: 'ft',
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: _ProductionChart(
                data: summary.weeklySheetProduction,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _efficiencyColor(double eff) {
    if (eff >= 90) return AppTheme.successGreen;
    if (eff >= 70) return AppTheme.accentAmber;
    return Colors.red;
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.sourceCodePro(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ProductionChart extends StatelessWidget {
  final List<DailyProduction> data;
  final Color color;

  const _ProductionChart({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data for this week'));
    }

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.value);
    }).toList();

    final maxY = data.map((d) => d.value).reduce((a, b) => a > b ? a : b) * 1.2;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= data.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('E').format(data[i].date),
                    style: const TextStyle(fontSize: 11),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: color.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _StockCard extends StatelessWidget {
  final String title;
  final double produced;
  final double packed;
  final double rejected;
  final double stockInPlace;
  final String unit;
  final Color color;

  const _StockCard({
    required this.title,
    required this.produced,
    required this.packed,
    required this.rejected,
    required this.stockInPlace,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.inventory_2, color: color, size: 22),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const Divider(),
            _stockRow('Produced', produced, unit, context),
            _stockRow('Packed', packed, unit, context),
            _stockRow('Rejected', rejected, unit, context),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'In Stock',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${stockInPlace.toStringAsFixed(1)} $unit',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stockRow(
    String label,
    double value,
    String unit,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '${value.toStringAsFixed(1)} $unit',
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyProductionTable extends StatelessWidget {
  final List<DailyProduction> data;
  final String unit;

  const _WeeklyProductionTable({required this.data, required this.unit});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('No production data this week'),
      );
    }

    final total = data.fold<double>(0, (sum, d) => sum + d.value);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Day',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Production ($unit)',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Data rows
            ...data.map(
              (d) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        DateFormat('EEE').format(d.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        DateFormat('dd MMM').format(d.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        d.value.toStringAsFixed(1),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.sourceCodePro(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            // Total row
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Weekly Total',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${total.toStringAsFixed(1)} $unit',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StockBreakdownTable extends StatelessWidget {
  final List<StockLineItem> items;
  final String unit;

  const _StockBreakdownTable({required this.items, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Size',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Density',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Color',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Prod',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pack',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Rej',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Stock',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.variant,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.density,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.color,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.produced}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.sourceCodePro(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.packed}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.sourceCodePro(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.rejected}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 11,
                          color: item.rejected > 0 ? Colors.red : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.inStock}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: item.inStock > 0
                              ? AppTheme.successGreen
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
