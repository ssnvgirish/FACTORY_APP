import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../frames/domain/repositories/frame_repository.dart';
import '../../../sheets/domain/repositories/sheet_repository.dart';
import 'reports_tab_page.dart';

class ReportResultsPage extends StatefulWidget {
  const ReportResultsPage({super.key, required this.request});

  final ReportRequest request;

  @override
  State<ReportResultsPage> createState() => _ReportResultsPageState();
}

class _ReportResultsPageState extends State<ReportResultsPage> {
  late Future<_ReportResultsData> _reportDataFuture;

  @override
  void initState() {
    super.initState();
    _reportDataFuture = _fetchReportData();
  }

  Future<_ReportResultsData> _fetchReportData() async {
    final isMachineType =
        widget.request.type == ReportGenerationType.machineAndTimeRange;
    if (isMachineType) {
      return _ReportResultsData(machineData: await _fetchMachineReportData());
    }

    return _ReportResultsData(operatorData: await _fetchOperatorReportData());
  }

  Future<_MachineReportData> _fetchMachineReportData() async {
    final machine = widget.request.target.id;
    final selectedShift = widget.request.selectedShift;
    final startDate = _startOfDay(widget.request.start ?? DateTime.now());
    final endDate = _endOfDay(
      widget.request.end ?? widget.request.start ?? DateTime.now(),
    );

    if (_isFrameMachine(machine)) {
      final frameRepository = sl<FrameRepository>();
      final details = await frameRepository.getProductionDetailsReports(
        machineNumber: machine,
        startDate: startDate,
        endDate: endDate,
      );
      final weights = await frameRepository.getProductionWeightReports(
        machineNumber: machine,
        startDate: startDate,
        endDate: endDate,
      );

      final filteredDetails =
          details
              .where(
                (report) =>
                    selectedShift == null || report.shift == selectedShift,
              )
              .toList()
            ..sort((a, b) {
              final dateCompare = a.date.compareTo(b.date);
              if (dateCompare != 0) return dateCompare;
              return a.shift.compareTo(b.shift);
            });

      final efficiencyByShift = {
        for (final report in weights)
          _rowKey(report.date, report.shift): report.efficiencyPercentage,
      };

      final rows = filteredDetails
          .map(
            (report) => _MachineReportRow(
              date: report.date,
              shift: report.shift,
              producedWeight: report.totalWeight,
              efficiency:
                  efficiencyByShift[_rowKey(report.date, report.shift)] ?? 0,
            ),
          )
          .toList();

      return _MachineReportData(
        machineName: machine,
        reportFamily: 'Frame',
        selectedShift: selectedShift,
        startDate: startDate,
        endDate: endDate,
        rows: rows,
      );
    }

    final sheetRepository = sl<SheetRepository>();
    final details = await sheetRepository.getProductionDetailsReports(
      machineNumber: machine,
      startDate: startDate,
      endDate: endDate,
    );
    final runningFeetReports = await sheetRepository
        .getProductionRunningFeetReports(
          machineNumber: machine,
          startDate: startDate,
          endDate: endDate,
        );

    final filteredDetails =
        details
            .where(
              (report) =>
                  selectedShift == null || report.shift == selectedShift,
            )
            .toList()
          ..sort((a, b) {
            final dateCompare = a.date.compareTo(b.date);
            if (dateCompare != 0) return dateCompare;
            return a.shift.compareTo(b.shift);
          });

    final efficiencyByShift = {
      for (final report in runningFeetReports)
        _rowKey(report.date, report.shift): report.efficiencyPercentage,
    };

    final rows = filteredDetails
        .map(
          (report) => _MachineReportRow(
            date: report.date,
            shift: report.shift,
            producedWeight: report.totalWeight,
            efficiency:
                efficiencyByShift[_rowKey(report.date, report.shift)] ?? 0,
          ),
        )
        .toList();

    return _MachineReportData(
      machineName: machine,
      reportFamily: 'Sheet',
      selectedShift: selectedShift,
      startDate: startDate,
      endDate: endDate,
      rows: rows,
    );
  }

  Future<_OperatorReportData> _fetchOperatorReportData() async {
    final monthAnchor =
        widget.request.start ?? widget.request.end ?? DateTime.now();
    final includeFrame =
        widget.request.target.assignedMachines.isEmpty ||
        widget.request.target.assignedMachines.any(_isFrameMachine);
    final includeSheet =
        widget.request.target.assignedMachines.isEmpty ||
        widget.request.target.assignedMachines.any(_isSheetMachine);

    final frameMetrics = includeFrame
        ? await sl<FrameRepository>().getMonthlyAggregates(
            widget.request.target.id,
            monthAnchor.year,
            monthAnchor.month,
          )
        : <String, double>{};

    final sheetMetrics = includeSheet
        ? await sl<SheetRepository>().getMonthlyAggregates(
            widget.request.target.id,
            monthAnchor.year,
            monthAnchor.month,
          )
        : <String, double>{};

    final combined = <String, double>{};
    for (final key in {'a', 'b', 'c', 'd', 'e', 'f'}) {
      final values = <double>[];
      if (frameMetrics.containsKey(key)) values.add(frameMetrics[key]!);
      if (sheetMetrics.containsKey(key)) values.add(sheetMetrics[key]!);
      combined[key] = values.isEmpty
          ? 0
          : values.reduce((a, b) => a + b) / values.length;
    }

    return _OperatorReportData(
      operatorName: widget.request.target.name,
      month: DateTime(monthAnchor.year, monthAnchor.month),
      metrics: combined,
      assignedMachines: widget.request.target.assignedMachines,
    );
  }

  bool _isFrameMachine(String machine) {
    return ddp.frameMachines.contains(machine) ||
        AppConstants.frameMachines.contains(machine);
  }

  bool _isSheetMachine(String machine) {
    return ddp.sheetMachines.contains(machine) ||
        AppConstants.sheetMachines.contains(machine);
  }

  DateTime _startOfDay(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  DateTime _endOfDay(DateTime value) =>
      DateTime(value.year, value.month, value.day, 23, 59, 59, 999);

  String _rowKey(DateTime date, String shift) =>
      '${date.year}-${date.month}-${date.day}|$shift';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Generated'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<_ReportResultsData>(
        future: _reportDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text('Error loading report data'),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('Back'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildReportSummaryCard(context, data),
                    const SizedBox(height: 20),
                    _buildReportDetailsCard(context, data),
                    const SizedBox(height: 20),
                    _buildReportDataSection(context, data),
                    const SizedBox(height: 20),
                    _buildBackButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportSummaryCard(
    BuildContext context,
    _ReportResultsData data,
  ) {
    final isMachineType =
        widget.request.type == ReportGenerationType.machineAndTimeRange;
    final metricTitle = isMachineType
        ? 'Overall Production Weight'
        : 'Monthly Avg Production Efficiency';
    final metricValue = isMachineType
        ? '${data.machineData!.overallProductionWeight.toStringAsFixed(2)} kg'
        : '${data.operatorData!.productionEfficiency.toStringAsFixed(1)}%';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isMachineType
                        ? Icons.precision_manufacturing
                        : Icons.person_search,
                    color: AppTheme.successGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMachineType ? 'Machine Report' : 'Operator Report',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Target: ${widget.request.target.displayLabel}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SummaryMetricTile(
                    label: metricTitle,
                    value: metricValue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryMetricTile(
                    label: isMachineType ? 'Average Efficiency' : 'Target',
                    value: isMachineType
                        ? '${data.machineData!.averageEfficiency.toStringAsFixed(1)}%'
                        : '100%',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportDetailsCard(
    BuildContext context,
    _ReportResultsData data,
  ) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final monthFormat = DateFormat('MMMM yyyy');
    final isMachineType =
        widget.request.type == ReportGenerationType.machineAndTimeRange;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (isMachineType) ...[
              _DetailRow(
                label: 'Machine',
                value: data.machineData!.machineName,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Category',
                value: data.machineData!.reportFamily,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Shift',
                value: data.machineData!.selectedShift ?? 'Both',
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Start Date',
                value: dateFormat.format(data.machineData!.startDate),
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'End Date',
                value: dateFormat.format(data.machineData!.endDate),
              ),
            ] else ...[
              _DetailRow(
                label: 'Operator',
                value: data.operatorData!.operatorName,
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Month',
                value: monthFormat.format(data.operatorData!.month),
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Assigned Machines',
                value: data.operatorData!.assignedMachines.isEmpty
                    ? 'All'
                    : data.operatorData!.assignedMachines.join(', '),
              ),
            ],
            const SizedBox(height: 8),
            _DetailRow(
              label: 'Generated At',
              value: DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportDataSection(
    BuildContext context,
    _ReportResultsData data,
  ) {
    final isMachineType =
        widget.request.type == ReportGenerationType.machineAndTimeRange;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMachineType ? 'Production Data' : 'Monthly Averages vs Target',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (isMachineType)
              _buildMachineDataTable(context, data.machineData!)
            else
              _buildOperatorDataTable(context, data.operatorData!),
          ],
        ),
      ),
    );
  }

  Widget _buildMachineDataTable(BuildContext context, _MachineReportData data) {
    final dateFormat = DateFormat('dd MMM yyyy');
    if (data.rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'No production data available for the selected period',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Shift')),
          DataColumn(label: Text('Produced Weight')),
          DataColumn(label: Text('Efficiency')),
          DataColumn(label: Text('Status')),
        ],
        rows: data.rows
            .map(
              (row) => DataRow(
                cells: [
                  DataCell(Text(dateFormat.format(row.date))),
                  DataCell(Text(row.shift)),
                  DataCell(Text('${row.producedWeight.toStringAsFixed(2)} kg')),
                  DataCell(Text('${row.efficiency.toStringAsFixed(1)}%')),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          row.status,
                        ).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        row.status,
                        style: TextStyle(
                          color: _getStatusColor(row.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildOperatorDataTable(
    BuildContext context,
    _OperatorReportData data,
  ) {
    final rows = [
      ('Machine Cleaning', data.metric('a')),
      ('Tools Count', data.metric('b')),
      ('Production Efficiency', data.metric('c')),
      ('Quality Acceptance', data.metric('d')),
      ('Packing Efficiency', data.metric('e')),
      ('Report Writing', data.metric('f')),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('Metric')),
          DataColumn(label: Text('Monthly Average')),
          DataColumn(label: Text('Target')),
          DataColumn(label: Text('Gap')),
        ],
        rows: rows
            .map(
              (row) => DataRow(
                cells: [
                  DataCell(Text(row.$1)),
                  DataCell(Text('${row.$2.toStringAsFixed(1)}%')),
                  const DataCell(Text('100.0%')),
                  DataCell(Text('${(100 - row.$2).toStringAsFixed(1)}%')),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return AppTheme.successGreen;
      case 'good':
        return AppTheme.accentAmber;
      case 'fair':
        return AppTheme.accentOrange;
      default:
        return AppTheme.textSecondary;
    }
  }

  Widget _buildBackButton(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.arrow_back),
      label: const Text('Back to Reports'),
      onPressed: () => context.pop(),
    );
  }
}

class _ReportResultsData {
  const _ReportResultsData({this.machineData, this.operatorData});

  final _MachineReportData? machineData;
  final _OperatorReportData? operatorData;
}

class _MachineReportData {
  const _MachineReportData({
    required this.machineName,
    required this.reportFamily,
    required this.selectedShift,
    required this.startDate,
    required this.endDate,
    required this.rows,
  });

  final String machineName;
  final String reportFamily;
  final String? selectedShift;
  final DateTime startDate;
  final DateTime endDate;
  final List<_MachineReportRow> rows;

  double get overallProductionWeight =>
      rows.fold(0, (sum, row) => sum + row.producedWeight);

  double get averageEfficiency => rows.isEmpty
      ? 0
      : rows.map((row) => row.efficiency).reduce((a, b) => a + b) / rows.length;
}

class _MachineReportRow {
  const _MachineReportRow({
    required this.date,
    required this.shift,
    required this.producedWeight,
    required this.efficiency,
  });

  final DateTime date;
  final String shift;
  final double producedWeight;
  final double efficiency;

  String get status {
    if (efficiency >= 90) return 'Excellent';
    if (efficiency >= 80) return 'Good';
    if (efficiency >= 70) return 'Fair';
    return 'Poor';
  }
}

class _OperatorReportData {
  const _OperatorReportData({
    required this.operatorName,
    required this.month,
    required this.metrics,
    required this.assignedMachines,
  });

  final String operatorName;
  final DateTime month;
  final Map<String, double> metrics;
  final List<String> assignedMachines;

  double metric(String key) => metrics[key] ?? 0;

  double get productionEfficiency => metric('c');
}

class _SummaryMetricTile extends StatelessWidget {
  const _SummaryMetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppTheme.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
