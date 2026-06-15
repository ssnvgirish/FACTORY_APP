import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_calendar_view.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

/// Calendar-based packing report: select machine → view monthly calendar
/// with per-day packing percentage by shift → tap date to see details.
class FramePackingCalendarPage extends StatelessWidget {
  const FramePackingCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MachineCalendarScaffold(
      title: 'Packing Report',
      machines: ddp.frameMachines,
      calendarBuilder: (machine) => _PackingCalendar(machineNumber: machine),
    );
  }
}

class _PackingCalendar extends StatefulWidget {
  final String machineNumber;
  const _PackingCalendar({required this.machineNumber});

  @override
  State<_PackingCalendar> createState() => _PackingCalendarState();
}

class _PackingCalendarState extends State<_PackingCalendar> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadMonth(DateTime.now());
  }

  @override
  void didUpdateWidget(covariant _PackingCalendar old) {
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
      LoadShiftPackingReports(
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

        final reports = state is ShiftPackingReportsLoaded
            ? state.reports
            : <FrameShiftPackingReport>[];

        final dataMap = <DateTime, CalendarDayData>{};
        for (final r in reports) {
          final key = DateTime(r.date.year, r.date.month, r.date.day);
          final existing = dataMap[key];
          final label = '${r.packingEfficiency.toStringAsFixed(0)}%';
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
            : <FrameShiftPackingReport>[];

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
    FrameShiftPackingReport report,
  ) {
    final isDay = report.shift.toLowerCase().contains('day');
    final totalPacked = report.lineItems.fold<int>(0, (s, li) => s + li.packed);
    final totalRejected = report.lineItems.fold<int>(
      0,
      (s, li) => s + li.rejectedQuality,
    );
    final totalProduced = report.lineItems.fold<int>(
      0,
      (s, li) => s + li.productionQuantity,
    );

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
                  '${report.packingEfficiency.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: report.packingEfficiency >= 90
                        ? AppTheme.successGreen
                        : AppTheme.warningYellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _statChip('Produced', '$totalProduced', AppTheme.primaryNavy),
                const SizedBox(width: 8),
                _statChip('Packed', '$totalPacked', AppTheme.successGreen),
                const SizedBox(width: 8),
                _statChip('Rejected', '$totalRejected', AppTheme.errorRed),
              ],
            ),
            const SizedBox(height: 8),
            AutoCalculatedField(
              label: 'Quality Acceptance',
              value:
                  '${report.qualityAcceptancePercentage.toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
