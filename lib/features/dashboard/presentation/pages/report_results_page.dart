import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../../../frames/domain/repositories/frame_repository.dart';
import 'reports_tab_page.dart';

class ReportResultsPage extends StatefulWidget {
  const ReportResultsPage({super.key, required this.request});

  final ReportRequest request;

  @override
  State<ReportResultsPage> createState() => _ReportResultsPageState();
}

class _ReportResultsPageState extends State<ReportResultsPage> {
  late Future<List<FrameProductionDetailsReport>> _reportDataFuture;

  @override
  void initState() {
    super.initState();
    _reportDataFuture = _fetchReportData();
  }

  Future<List<FrameProductionDetailsReport>> _fetchReportData() async {
    try {
      final frameRepository = sl<FrameRepository>();
      final isMachineType =
          widget.request.type == ReportGenerationType.machineAndTimeRange;

      if (isMachineType) {
        // Fetch production details for the selected machine
        final reports = await frameRepository.getProductionDetailsReports(
          machineNumber: widget.request.target.id,
          startDate: widget.request.start,
          endDate: widget.request.end,
        );
        return reports;
      } else {
        // For operator reports, return empty list (will handle separately)
        return [];
      }
    } catch (error) {
      debugPrint('Error fetching report data: $error');
      rethrow;
    }
  }

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
      body: FutureBuilder<List<FrameProductionDetailsReport>>(
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildReportSummaryCard(context),
                    const SizedBox(height: 20),
                    _buildReportDetailsCard(context),
                    const SizedBox(height: 20),
                    _buildReportDataSection(context, snapshot.data ?? []),
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

  Widget _buildReportSummaryCard(BuildContext context) {
    final isMachineType =
        widget.request.type == ReportGenerationType.machineAndTimeRange;

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
                        'Report Type',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        isMachineType
                            ? 'Machine & Time Range'
                            : 'Operator Wise',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Target: ${widget.request.target.displayLabel}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportDetailsCard(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

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
            _DetailRow(label: 'ID', value: widget.request.target.id),
            const SizedBox(height: 8),
            _DetailRow(label: 'Name', value: widget.request.target.name),
            if (widget.request.start != null) ...[
              const SizedBox(height: 8),
              _DetailRow(
                label: 'Start Date/Time',
                value: dateFormat.format(widget.request.start!),
              ),
            ],
            if (widget.request.end != null) ...[
              const SizedBox(height: 8),
              _DetailRow(
                label: 'End Date/Time',
                value: dateFormat.format(widget.request.end!),
              ),
            ],
            const SizedBox(height: 8),
            _DetailRow(
              label: 'Generated At',
              value: dateFormat.format(DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportDataSection(
    BuildContext context,
    List<FrameProductionDetailsReport> data,
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
              isMachineType
                  ? 'Machine Production Data'
                  : 'Operator Performance Data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (isMachineType)
              _buildMachineDataTable(context, data)
            else
              _buildOperatorDataTable(context, []),
          ],
        ),
      ),
    );
  }

  Widget _buildMachineDataTable(
    BuildContext context,
    List<FrameProductionDetailsReport> data,
  ) {
    final dateFormat = DateFormat('dd MMM yyyy');

    // Convert reports to display data
    final displayData = data
        .map(
          (report) => {
            'date': dateFormat.format(report.date),
            'shift': report.shift,
            'produced': '${report.totalWeight.toStringAsFixed(2)} kg',
            'efficiency': '${_calculateEfficiency(report).toStringAsFixed(1)}%',
            'status': _getProductionStatus(report),
          },
        )
        .toList();

    if (displayData.isEmpty) {
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
          DataColumn(label: Text('Produced')),
          DataColumn(label: Text('Efficiency')),
          DataColumn(label: Text('Status')),
        ],
        rows: displayData
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(Text(item['date']!)),
                  DataCell(Text(item['shift']!)),
                  DataCell(Text(item['produced']!)),
                  DataCell(Text(item['efficiency']!)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          item['status']!,
                        ).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['status']!,
                        style: TextStyle(
                          color: _getStatusColor(item['status']!),
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

  Widget _buildOperatorDataTable(BuildContext context, List<dynamic> data) {
    // Placeholder for operator data - to be implemented
    // For now, returning empty state
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Operator report data not yet implemented',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
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

  double _calculateEfficiency(FrameProductionDetailsReport report) {
    // Simple efficiency calculation based on weight produced
    // Normalized to a base of 1000 kg per shift
    if (report.totalWeight <= 0) return 0;
    return (report.totalWeight / 1000) * 100;
  }

  String _getProductionStatus(FrameProductionDetailsReport report) {
    final efficiency = _calculateEfficiency(report);
    if (efficiency >= 90) return 'Excellent';
    if (efficiency >= 80) return 'Good';
    if (efficiency >= 70) return 'Fair';
    return 'Poor';
  }

  Widget _buildBackButton(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.arrow_back),
      label: const Text('Back to Reports'),
      onPressed: () => context.pop(),
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
