import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

/// Data for a single calendar cell: holds day-shift and night-shift values.
class CalendarDayData {
  final String? dayShiftLabel;
  final String? nightShiftLabel;

  const CalendarDayData({this.dayShiftLabel, this.nightShiftLabel});
}

/// A monthly calendar grid that shows per-day shift data under each date.
///
/// [dataForDate] maps a `DateTime` (date-only) to [CalendarDayData].
/// [onDateSelected] fires when the user taps a date that has data.
class ReportCalendarView extends StatefulWidget {
  final DateTime initialMonth;
  final Map<DateTime, CalendarDayData> dataForDate;
  final void Function(DateTime date) onDateSelected;
  final void Function(DateTime month)? onMonthChanged;
  final Color dayShiftColor;
  final Color nightShiftColor;

  const ReportCalendarView({
    super.key,
    required this.initialMonth,
    required this.dataForDate,
    required this.onDateSelected,
    this.onMonthChanged,
    this.dayShiftColor = AppTheme.pendingBlue,
    this.nightShiftColor = AppTheme.accentOrange,
  });

  @override
  State<ReportCalendarView> createState() => _ReportCalendarViewState();
}

class _ReportCalendarViewState extends State<ReportCalendarView> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
      widget.initialMonth.year,
      widget.initialMonth.month,
    );
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    widget.onMonthChanged?.call(_currentMonth);
  }

  void _nextMonth() {
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1);
    if (next.isAfter(DateTime.now())) return;
    setState(() => _currentMonth = next);
    widget.onMonthChanged?.call(_currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    // Monday = 1 in DateTime.weekday
    final startWeekday = firstDay.weekday; // 1=Mon ... 7=Sun

    return Column(
      children: [
        // Month header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _prevMonth,
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),

        // Legend
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              _legendDot(widget.dayShiftColor, 'Day Shift'),
              const SizedBox(width: 16),
              _legendDot(widget.nightShiftColor, 'Night Shift'),
            ],
          ),
        ),

        const SizedBox(height: 4),

        // Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 4),

        // Calendar grid
        _buildGrid(firstDay, daysInMonth, startWeekday),
      ],
    );
  }

  Widget _buildGrid(DateTime firstDay, int daysInMonth, int startWeekday) {
    final cells = <Widget>[];
    // Empty cells for days before the 1st
    for (var i = 1; i < startWeekday; i++) {
      cells.add(const SizedBox());
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final dateKey = DateTime(date.year, date.month, date.day);
      final data = widget.dataForDate[dateKey];
      final isSelected =
          _selectedDate != null &&
          _selectedDate!.year == date.year &&
          _selectedDate!.month == date.month &&
          _selectedDate!.day == date.day;
      final isToday = _isToday(date);

      cells.add(
        GestureDetector(
          onTap: data != null
              ? () {
                  setState(() => _selectedDate = date);
                  widget.onDateSelected(date);
                }
              : null,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? AppTheme.primaryNavy.withValues(alpha: 0.1)
                  : null,
              border: isToday
                  ? Border.all(color: AppTheme.primaryNavy, width: 1.5)
                  : isSelected
                  ? Border.all(color: AppTheme.primaryNavy, width: 1.5)
                  : Border.all(color: AppTheme.borderGrey, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: GoogleFonts.sourceSans3(
                    fontSize: 13,
                    fontWeight: data != null
                        ? FontWeight.w700
                        : FontWeight.w400,
                    color: data != null
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
                if (data != null) ...[
                  if (data.dayShiftLabel != null)
                    _shiftLabel(data.dayShiftLabel!, widget.dayShiftColor),
                  if (data.nightShiftLabel != null)
                    _shiftLabel(data.nightShiftLabel!, widget.nightShiftColor),
                ],
              ],
            ),
          ),
        ),
      );
    }

    // Pad remaining cells to fill last row
    final remainder = cells.length % 7;
    if (remainder != 0) {
      for (var i = 0; i < 7 - remainder; i++) {
        cells.add(const SizedBox());
      }
    }

    final rows = <Widget>[];
    for (var i = 0; i < cells.length; i += 7) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
            height: 64,
            child: Row(
              children: cells
                  .sublist(i, i + 7)
                  .map((c) => Expanded(child: c))
                  .toList(),
            ),
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _shiftLabel(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0.5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.sourceCodePro(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: color, width: 1),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }
}

/// Dropdown to select a machine, then shows the calendar below.
class MachineCalendarScaffold extends StatefulWidget {
  final String title;
  final List<String> machines;
  final Widget Function(String machineNumber) calendarBuilder;

  const MachineCalendarScaffold({
    super.key,
    required this.title,
    required this.machines,
    required this.calendarBuilder,
  });

  @override
  State<MachineCalendarScaffold> createState() =>
      _MachineCalendarScaffoldState();
}

class _MachineCalendarScaffoldState extends State<MachineCalendarScaffold> {
  String? _selectedMachine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _selectedMachine,
              decoration: const InputDecoration(labelText: 'Select Machine'),
              items: widget.machines
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedMachine = v),
            ),
          ),
          if (_selectedMachine != null)
            Expanded(child: widget.calendarBuilder(_selectedMachine!)),
          if (_selectedMachine == null)
            const Expanded(
              child: Center(
                child: Text(
                  'Select a machine to view reports',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
