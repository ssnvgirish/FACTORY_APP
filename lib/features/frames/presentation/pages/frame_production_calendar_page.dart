import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_calendar_view.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

/// Calendar-based production report: select machine → view monthly calendar
/// with per-day total weight color-coded by shift → tap date to see details.
class FrameProductionCalendarPage extends StatelessWidget {
  const FrameProductionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MachineCalendarScaffold(
      title: 'Production Report',
      machines: ddp.frameMachines,
      calendarBuilder: (machine) => _ProductionCalendar(machineNumber: machine),
    );
  }
}

class _ProductionCalendar extends StatefulWidget {
  final String machineNumber;
  const _ProductionCalendar({required this.machineNumber});

  @override
  State<_ProductionCalendar> createState() => _ProductionCalendarState();
}

class _ProductionCalendarState extends State<_ProductionCalendar> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadMonth(DateTime.now());
  }

  @override
  void didUpdateWidget(covariant _ProductionCalendar old) {
    super.didUpdateWidget(old);
    if (old.machineNumber != widget.machineNumber) {
      _selectedDate = null;
      _loadMonth(DateTime.now());
    }
  }

  void _loadMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0);
    context.read<FrameReportsBloc>().add(
      LoadProductionDetailsReports(
        machineNumber: widget.machineNumber,
        startDate: start,
        endDate: end,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameReportsBloc, FrameReportsState>(
      builder: (context, state) {
        if (state is FrameReportsLoading) return const LoadingWidget();
        if (state is FrameReportsError) {
          return Center(child: Text(state.message));
        }

        final reports = state is ProductionDetailsReportsLoaded
            ? state.reports
            : <FrameProductionDetailsReport>[];

        // Build calendar data
        final dataMap = <DateTime, CalendarDayData>{};
        for (final r in reports) {
          final key = DateTime(r.date.year, r.date.month, r.date.day);
          final existing = dataMap[key];
          final label = '${r.totalWeight.toStringAsFixed(0)} kg';
          if (r.shift.toLowerCase().contains('day')) {
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

        // Find reports for selected date
        final selectedReports = _selectedDate != null
            ? reports
                  .where(
                    (r) =>
                        r.date.year == _selectedDate!.year &&
                        r.date.month == _selectedDate!.month &&
                        r.date.day == _selectedDate!.day,
                  )
                  .toList()
            : <FrameProductionDetailsReport>[];

        return SingleChildScrollView(
          child: Column(
            children: [
              ReportCalendarView(
                initialMonth: DateTime.now(),
                dataForDate: dataMap,
                onDateSelected: (d) => setState(() => _selectedDate = d),
                onMonthChanged: _loadMonth,
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
                if (selectedReports.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No data for this date'),
                  )
                else
                  ...selectedReports.map((r) => _shiftDetailCard(context, r)),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _shiftDetailCard(
    BuildContext context,
    FrameProductionDetailsReport report,
  ) {
    final isDay = report.shift.toLowerCase().contains('day');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isDay ? AppTheme.pendingBlue : AppTheme.accentOrange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  report.shift,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  '${report.totalWeight.toStringAsFixed(1)} kg',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryNavy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${report.totalQuantity} pieces  •  ${report.lineItems.length} items',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(height: 16),
            // Line items table
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(0.8),
                5: FlexColumnWidth(1.2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryNavy.withValues(alpha: 0.05),
                  ),
                  children: [
                    _headerCell('Section'),
                    _headerCell('Density'),
                    _headerCell('Color'),
                    _headerCell('Length'),
                    _headerCell('Qty'),
                    _headerCell('Weight'),
                  ],
                ),
                ...report.lineItems.map(
                  (li) => TableRow(
                    children: [
                      _dataCell(li.section),
                      _dataCell(li.density),
                      _dataCell(li.color),
                      _dataCell('${li.length}'),
                      _dataCell('${li.quantity}'),
                      _dataCell(li.totalWeight.toStringAsFixed(1)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _dataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }
}
