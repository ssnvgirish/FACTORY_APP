import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_calendar_view.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

/// Calendar-based maintenance report: select machine → view monthly calendar
/// with per-day health percentage by shift → tap date to see details.
class FrameMaintenanceCalendarPage extends StatelessWidget {
  const FrameMaintenanceCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MachineCalendarScaffold(
      title: 'Maintenance Report',
      machines: ddp.frameMachines,
      calendarBuilder: (machine) =>
          _MaintenanceCalendar(machineNumber: machine),
    );
  }
}

class _MaintenanceCalendar extends StatefulWidget {
  final String machineNumber;
  const _MaintenanceCalendar({required this.machineNumber});

  @override
  State<_MaintenanceCalendar> createState() => _MaintenanceCalendarState();
}

class _MaintenanceCalendarState extends State<_MaintenanceCalendar> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadMonth(DateTime.now());
  }

  @override
  void didUpdateWidget(covariant _MaintenanceCalendar old) {
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
      LoadMachineHealthReports(
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

        final reports = state is MachineHealthReportsLoaded
            ? state.reports
            : <MachineHealthReport>[];

        final dataMap = <DateTime, CalendarDayData>{};
        for (final r in reports) {
          final key = DateTime(r.date.year, r.date.month, r.date.day);
          final existing = dataMap[key];
          final label = '${r.percentage.toStringAsFixed(0)}%';
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

        final selectedReports = _selectedDate != null
            ? reports
                  .where(
                    (r) =>
                        r.date.year == _selectedDate!.year &&
                        r.date.month == _selectedDate!.month &&
                        r.date.day == _selectedDate!.day,
                  )
                  .toList()
            : <MachineHealthReport>[];

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

  Widget _shiftDetailCard(BuildContext context, MachineHealthReport report) {
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
                  '${report.percentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: report.percentage >= 80
                        ? AppTheme.successGreen
                        : report.percentage >= 50
                        ? AppTheme.warningYellow
                        : AppTheme.errorRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Score: ${report.totalScore} / ${report.ratings.length * 10}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(height: 16),
            ...report.ratings.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.item,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _ratingColor(
                          item.rating,
                        ).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item.rating}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _ratingColor(item.rating),
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

  Color _ratingColor(int rating) {
    if (rating >= 8) return AppTheme.successGreen;
    if (rating >= 5) return AppTheme.warningYellow;
    return AppTheme.errorRed;
  }
}
