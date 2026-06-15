import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_calendar_view.dart';
import '../bloc/frame_reports_bloc.dart';

/// Report type selector for operator-wise monthly view.
enum _ReportType {
  cleaning('Machine Cleaning', Icons.cleaning_services),
  tools('Tools Count', Icons.build),
  health('Health Report', Icons.health_and_safety),
  production('Production Details', Icons.precision_manufacturing),
  writingEfficiency('Report Writing Efficiency', Icons.edit_note),
  customerRejection('Customer Rejection', Icons.cancel);

  final String label;
  final IconData icon;
  const _ReportType(this.label, this.icon);
}

class FrameOperatorMonthlyReportsPage extends StatefulWidget {
  const FrameOperatorMonthlyReportsPage({super.key});

  @override
  State<FrameOperatorMonthlyReportsPage> createState() =>
      _FrameOperatorMonthlyReportsPageState();
}

class _FrameOperatorMonthlyReportsPageState
    extends State<FrameOperatorMonthlyReportsPage> {
  _ReportType? _selectedType;

  @override
  Widget build(BuildContext context) {
    if (_selectedType == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Operator-wise Reports')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: _ReportType.values.map((type) {
            return Card(
              child: ListTile(
                leading: Icon(type.icon, color: AppTheme.primaryNavy),
                title: Text(type.label),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => setState(() => _selectedType = type),
              ),
            );
          }).toList(),
        ),
      );
    }

    return _OperatorCalendarView(
      reportType: _selectedType!,
      onBack: () => setState(() => _selectedType = null),
    );
  }
}

class _OperatorCalendarView extends StatefulWidget {
  final _ReportType reportType;
  final VoidCallback onBack;

  const _OperatorCalendarView({required this.reportType, required this.onBack});

  @override
  State<_OperatorCalendarView> createState() => _OperatorCalendarViewState();
}

class _OperatorCalendarViewState extends State<_OperatorCalendarView> {
  DateTime? _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _loadData();
  }

  void _loadData() {
    final start = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final end = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final bloc = context.read<FrameReportsBloc>();
    switch (widget.reportType) {
      case _ReportType.cleaning:
        bloc.add(LoadMachineCleaningReports(startDate: start, endDate: end));
      case _ReportType.tools:
        bloc.add(LoadToolsCountReports(startDate: start, endDate: end));
      case _ReportType.health:
        bloc.add(LoadMachineHealthReports(startDate: start, endDate: end));
      case _ReportType.production:
        bloc.add(LoadProductionDetailsReports(startDate: start, endDate: end));
      case _ReportType.writingEfficiency:
        // Writing efficiency doesn't have a generic load event with date range
        // We load production details as proxy; actual writing efficiency is auto-generated
        bloc.add(LoadProductionDetailsReports(startDate: start, endDate: end));
      case _ReportType.customerRejection:
        bloc.add(LoadCustomerRejectionReports(startDate: start, endDate: end));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Text('Operator: ${widget.reportType.label}'),
      ),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is FrameReportsError) {
            return Center(child: Text(state.message));
          }

          final entries = _extractEntries(state);
          if (entries.isEmpty) {
            return const EmptyStateWidget(message: 'No reports for this month');
          }

          // Group by operator (createdBy)
          final operators = <String>{};
          for (final e in entries) {
            operators.add(e.createdBy);
          }

          // Build calendar data (all operators combined)
          final dataMap = <DateTime, CalendarDayData>{};
          for (final e in entries) {
            final key = DateTime(e.date.year, e.date.month, e.date.day);
            final existing = dataMap[key];
            final label = e.summaryLabel;
            if (e.shift?.toLowerCase().contains('day') ?? true) {
              dataMap[key] = CalendarDayData(
                dayShiftLabel: label,
                nightShiftLabel: existing?.nightShiftLabel,
              );
            } else {
              dataMap[key] = CalendarDayData(
                dayShiftLabel: existing?.dayShiftLabel,
                nightShiftLabel: label,
              );
            }
          }

          final selectedEntries = _selectedDate != null
              ? entries
                    .where(
                      (e) =>
                          e.date.year == _selectedDate!.year &&
                          e.date.month == _selectedDate!.month &&
                          e.date.day == _selectedDate!.day,
                    )
                    .toList()
              : <_ReportEntry>[];

          // Group selected entries by operator
          final byOperator = <String, List<_ReportEntry>>{};
          for (final e in selectedEntries) {
            byOperator.putIfAbsent(e.createdBy, () => []).add(e);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ReportCalendarView(
                  initialMonth: _currentMonth,
                  dataForDate: dataMap,
                  onDateSelected: (d) => setState(() => _selectedDate = d),
                  onMonthChanged: (m) {
                    _currentMonth = m;
                    _loadData();
                  },
                ),
                if (_selectedDate != null) ...[
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd MMM yyyy').format(_selectedDate!),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (selectedEntries.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('No data for this date'),
                    )
                  else
                    ...byOperator.entries.map(
                      (entry) =>
                          _operatorSection(context, entry.key, entry.value),
                    ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<_ReportEntry> _extractEntries(FrameReportsState state) {
    switch (widget.reportType) {
      case _ReportType.cleaning:
        if (state is MachineCleaningReportsLoaded) {
          return state.reports
              .map(
                (r) => _ReportEntry(
                  date: r.date,
                  createdBy: r.createdBy,
                  shift: null,
                  summaryLabel: '${r.percentage.toStringAsFixed(0)}%',
                  details: {
                    'Machine': r.machineNumber,
                    'Machine Condition': '${r.machineCondition}/10',
                    'Ground Condition': '${r.groundCondition}/10',
                    'Mould Condition': '${r.mouldCondition}/10',
                    'Total Score': '${r.totalScore}/30',
                    'Percentage': '${r.percentage.toStringAsFixed(1)}%',
                  },
                ),
              )
              .toList();
        }
      case _ReportType.tools:
        if (state is ToolsCountReportsLoaded) {
          return state.reports
              .map(
                (r) => _ReportEntry(
                  date: r.date,
                  createdBy: r.createdBy,
                  shift: null,
                  summaryLabel: '${r.percentageAvailable.toStringAsFixed(0)}%',
                  details: {
                    'Machine': r.machineNumber,
                    'Tools Given': '${r.totalToolsGiven}',
                    'Tools Available': '${r.totalToolsAvailable}',
                    'Percentage':
                        '${r.percentageAvailable.toStringAsFixed(1)}%',
                  },
                ),
              )
              .toList();
        }
      case _ReportType.health:
        if (state is MachineHealthReportsLoaded) {
          return state.reports
              .map(
                (r) => _ReportEntry(
                  date: r.date,
                  createdBy: r.createdBy,
                  shift: r.shift,
                  summaryLabel: '${r.percentage.toStringAsFixed(0)}%',
                  details: {
                    'Machine': r.machineNumber,
                    'Shift': r.shift,
                    'Total Score': '${r.totalScore}/${r.ratings.length * 10}',
                    'Percentage': '${r.percentage.toStringAsFixed(1)}%',
                    ...{
                      for (final item in r.ratings)
                        item.item: '${item.rating}/10',
                    },
                  },
                ),
              )
              .toList();
        }
      case _ReportType.production:
      case _ReportType.writingEfficiency:
        if (state is ProductionDetailsReportsLoaded) {
          return state.reports
              .map(
                (r) => _ReportEntry(
                  date: r.date,
                  createdBy: r.createdBy,
                  shift: r.shift,
                  summaryLabel: '${r.totalWeight.toStringAsFixed(0)} kg',
                  details: {
                    'Machine': r.machineNumber,
                    'Shift': r.shift,
                    'Total Quantity': '${r.totalQuantity}',
                    'Total Weight': '${r.totalWeight.toStringAsFixed(1)} kg',
                    'Line Items': '${r.lineItems.length}',
                  },
                ),
              )
              .toList();
        }
      case _ReportType.customerRejection:
        if (state is CustomerRejectionReportsLoaded) {
          return state.reports
              .map(
                (r) => _ReportEntry(
                  date: r.originalProductionDate,
                  createdBy: r.createdBy,
                  shift: r.shift,
                  summaryLabel:
                      '${r.totalRejectedWeight.toStringAsFixed(0)} kg',
                  details: {
                    'Machine': r.machineNumber,
                    'Shift': r.shift,
                    'Total Rejected Weight':
                        '${r.totalRejectedWeight.toStringAsFixed(1)} kg',
                    'Rejected Items': '${r.rejectedItems.length}',
                  },
                ),
              )
              .toList();
        }
    }
    return [];
  }

  Widget _operatorSection(
    BuildContext context,
    String operatorId,
    List<_ReportEntry> entries,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 18, color: AppTheme.primaryNavy),
                const SizedBox(width: 8),
                Text(
                  'Operator: $operatorId',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Divider(height: 16),
            ...entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: e.details.entries
                      .map(
                        (kv) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 140,
                                child: Text(
                                  kv.key,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  kv.value,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportEntry {
  final DateTime date;
  final String createdBy;
  final String? shift;
  final String summaryLabel;
  final Map<String, String> details;

  _ReportEntry({
    required this.date,
    required this.createdBy,
    required this.shift,
    required this.summaryLabel,
    required this.details,
  });
}
