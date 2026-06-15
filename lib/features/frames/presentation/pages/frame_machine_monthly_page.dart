import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_calendar_view.dart';
import '../bloc/frame_reports_bloc.dart';

/// Report type selector for machine-wise monthly view.
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

class FrameMachineMonthlyReportsPage extends StatefulWidget {
  const FrameMachineMonthlyReportsPage({super.key});

  @override
  State<FrameMachineMonthlyReportsPage> createState() =>
      _FrameMachineMonthlyReportsPageState();
}

class _FrameMachineMonthlyReportsPageState
    extends State<FrameMachineMonthlyReportsPage> {
  _ReportType? _selectedType;

  @override
  Widget build(BuildContext context) {
    if (_selectedType == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Machine-wise Reports')),
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

    return _MachineCalendarView(
      reportType: _selectedType!,
      onBack: () => setState(() => _selectedType = null),
    );
  }
}

class _MachineCalendarView extends StatefulWidget {
  final _ReportType reportType;
  final VoidCallback onBack;

  const _MachineCalendarView({required this.reportType, required this.onBack});

  @override
  State<_MachineCalendarView> createState() => _MachineCalendarViewState();
}

class _MachineCalendarViewState extends State<_MachineCalendarView> {
  String? _selectedMachine;
  DateTime? _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  void _loadData() {
    if (_selectedMachine == null) return;
    final start = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final end = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final bloc = context.read<FrameReportsBloc>();
    switch (widget.reportType) {
      case _ReportType.cleaning:
        bloc.add(
          LoadMachineCleaningReports(
            machineNumber: _selectedMachine,
            startDate: start,
            endDate: end,
          ),
        );
      case _ReportType.tools:
        bloc.add(
          LoadToolsCountReports(
            machineNumber: _selectedMachine,
            startDate: start,
            endDate: end,
          ),
        );
      case _ReportType.health:
        bloc.add(
          LoadMachineHealthReports(
            machineNumber: _selectedMachine,
            startDate: start,
            endDate: end,
          ),
        );
      case _ReportType.production:
      case _ReportType.writingEfficiency:
        bloc.add(
          LoadProductionDetailsReports(
            machineNumber: _selectedMachine,
            startDate: start,
            endDate: end,
          ),
        );
      case _ReportType.customerRejection:
        bloc.add(
          LoadCustomerRejectionReports(
            machineNumber: _selectedMachine,
            startDate: start,
            endDate: end,
          ),
        );
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
        title: Text('Machine: ${widget.reportType.label}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _selectedMachine,
              decoration: const InputDecoration(labelText: 'Select Machine'),
              items: ddp.frameMachines
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  _selectedMachine = v;
                  _selectedDate = null;
                });
                _loadData();
              },
            ),
          ),
          if (_selectedMachine == null)
            const Expanded(
              child: Center(
                child: Text(
                  'Select a machine to view reports',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            )
          else
            Expanded(
              child: BlocBuilder<FrameReportsBloc, FrameReportsState>(
                builder: (context, state) {
                  if (state is FrameReportsLoading) {
                    return const LoadingWidget();
                  }
                  if (state is FrameReportsError) {
                    return Center(child: Text(state.message));
                  }

                  final entries = _extractEntries(state);
                  if (entries.isEmpty) {
                    return const EmptyStateWidget(
                      message: 'No reports for this month',
                    );
                  }

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

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ReportCalendarView(
                          initialMonth: _currentMonth,
                          dataForDate: dataMap,
                          onDateSelected: (d) =>
                              setState(() => _selectedDate = d),
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
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(_selectedDate!),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                            ...selectedEntries.map(
                              (e) => _detailCard(context, e),
                            ),
                          const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
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
                  shift: null,
                  summaryLabel: '${r.percentage.toStringAsFixed(0)}%',
                  details: {
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
                  shift: null,
                  summaryLabel: '${r.percentageAvailable.toStringAsFixed(0)}%',
                  details: {
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
                  shift: r.shift,
                  summaryLabel: '${r.percentage.toStringAsFixed(0)}%',
                  details: {
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
                  shift: r.shift,
                  summaryLabel: '${r.totalWeight.toStringAsFixed(0)} kg',
                  details: {
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
                  shift: r.shift,
                  summaryLabel:
                      '${r.totalRejectedWeight.toStringAsFixed(0)} kg',
                  details: {
                    'Shift': r.shift,
                    'Total Rejected':
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

  Widget _detailCard(BuildContext context, _ReportEntry entry) {
    final isDay = entry.shift?.toLowerCase().contains('day') ?? true;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entry.shift != null)
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isDay
                          ? AppTheme.pendingBlue
                          : AppTheme.accentOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    entry.shift!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            if (entry.shift != null) const Divider(height: 12),
            ...entry.details.entries.map(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportEntry {
  final DateTime date;
  final String? shift;
  final String summaryLabel;
  final Map<String, String> details;

  _ReportEntry({
    required this.date,
    required this.shift,
    required this.summaryLabel,
    required this.details,
  });
}
