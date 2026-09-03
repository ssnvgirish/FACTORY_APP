import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';
import '../utils/report_week_range.dart';

class ReportListQuery {
  final String? machineNumber;
  final DateTime startDate;
  final DateTime endDate;

  const ReportListQuery({
    this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

/// List page chrome: FAB stays at the bottom-right, filters sit at the top.
class ReportListPageShell extends StatefulWidget {
  final String title;
  final List<String> machines;
  final Widget? floatingActionButton;
  final void Function(ReportListQuery query) onQueryChanged;
  final Widget Function(BuildContext context, ReportListQuery query)
  bodyBuilder;

  const ReportListPageShell({
    super.key,
    required this.title,
    this.machines = const [],
    required this.onQueryChanged,
    required this.bodyBuilder,
    this.floatingActionButton,
  });

  @override
  State<ReportListPageShell> createState() => _ReportListPageShellState();
}

class _ReportListPageShellState extends State<ReportListPageShell> {
  String? _machine;
  late DateTime _fromDate;
  late DateTime _toDate;
  late ReportListQuery _activeQuery;

  @override
  void initState() {
    super.initState();
    final range = ReportWeekRange.initial();
    _fromDate = range.start;
    _toDate = range.end;
    _activeQuery = _buildQuery();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onQueryChanged(_activeQuery);
    });
  }

  bool get _isValidRange => !_toDate.isBefore(_fromDate);

  ReportListQuery _buildQuery() => ReportListQuery(
    machineNumber: _machine,
    startDate: _fromDate,
    endDate: _toDate,
  );

  void _updateQueryIfValid() {
    if (!_isValidRange) return;
    _activeQuery = _buildQuery();
    widget.onQueryChanged(_activeQuery);
  }

  Future<void> _pickDate({required bool isFromDate}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate : _toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (!mounted || picked == null) return;

    final normalizedPicked = ReportWeekRange.dateOnly(picked);

    setState(() {
      if (isFromDate) {
        _fromDate = normalizedPicked;
      } else {
        _toDate = normalizedPicked;
      }
    });
    _updateQueryIfValid();
  }

  Widget _dateField({
    required String label,
    required DateTime value,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(labelText: label, isDense: true),
          child: Text(DateFormat('dd MMM yyyy').format(value)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: widget.floatingActionButton,
      body: Column(
        children: [
          Material(
            color: AppTheme.surfaceLight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (widget.machines.isNotEmpty) ...[
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            key: ValueKey(_machine ?? 'all'),
                            initialValue: _machine ?? '',
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Machine',
                              isDense: true,
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: '',
                                child: Text('All machines'),
                              ),
                              ...widget.machines.map(
                                (machine) => DropdownMenuItem(
                                  value: machine,
                                  child: Text(machine),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _machine = value == null || value.isEmpty
                                    ? null
                                    : value;
                              });
                              _updateQueryIfValid();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      _dateField(
                        label: 'From Date',
                        value: _fromDate,
                        onTap: () => _pickDate(isFromDate: true),
                      ),
                      const SizedBox(width: 8),
                      _dateField(
                        label: 'To Date',
                        value: _toDate,
                        onTap: () => _pickDate(isFromDate: false),
                      ),
                    ],
                  ),
                  if (!_isValidRange)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'To Date cannot be before From Date',
                        style: TextStyle(color: AppTheme.errorRed),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: widget.bodyBuilder(context, _activeQuery)),
        ],
      ),
    );
  }
}
