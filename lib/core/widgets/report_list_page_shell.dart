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
  final Widget Function(BuildContext context, ReportListQuery query) bodyBuilder;

  const ReportListPageShell({
    super.key,
    required this.title,
    required this.machines,
    required this.onQueryChanged,
    required this.bodyBuilder,
    this.floatingActionButton,
  });

  @override
  State<ReportListPageShell> createState() => _ReportListPageShellState();
}

class _ReportListPageShellState extends State<ReportListPageShell> {
  String? _machine;
  late DateTime _month;
  late int _week;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = ReportWeekRange.monthStart(now);
    _week = ReportWeekRange.weekOfMonthIndex(now);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onQueryChanged(_query);
    });
  }

  ReportListQuery get _query {
    final range = ReportWeekRange.weekOfMonth(_month, _week);
    return ReportListQuery(
      machineNumber: _machine,
      startDate: range.start,
      endDate: range.end,
    );
  }

  void _emit() => widget.onQueryChanged(_query);

  @override
  Widget build(BuildContext context) {
    final weekCount = ReportWeekRange.weeksInMonth(_month);
    if (_week > weekCount) _week = weekCount;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: widget.floatingActionButton,
      body: Column(
        children: [
          Material(
            color: AppTheme.surfaceLight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
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
                          (m) => DropdownMenuItem(value: m, child: Text(m)),
                        ),
                      ],
                      onChanged: (v) => setState(() {
                        _machine = (v == null || v.isEmpty) ? null : v;
                        _emit();
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _month,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          helpText: 'Select month',
                        );
                        if (picked == null) return;
                        setState(() {
                          _month = ReportWeekRange.monthStart(picked);
                          final maxWeek = ReportWeekRange.weeksInMonth(_month);
                          if (_week > maxWeek) _week = maxWeek;
                          _emit();
                        });
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Month',
                          isDense: true,
                        ),
                        child: Text(DateFormat('MMM yyyy').format(_month)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 88,
                    child: DropdownButtonFormField<int>(
                      key: ValueKey(_week),
                      initialValue: _week,
                      decoration: const InputDecoration(
                        labelText: 'Week',
                        isDense: true,
                      ),
                      items: [
                        for (var w = 1; w <= weekCount; w++)
                          DropdownMenuItem(value: w, child: Text('W$w')),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          _week = v;
                          _emit();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: widget.bodyBuilder(context, _query)),
        ],
      ),
    );
  }
}
