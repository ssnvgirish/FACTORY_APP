import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/report_week_range.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetRunningFeetPage extends StatelessWidget {
  final String machineId;
  const SheetRunningFeetPage({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Running Feet Report')),
      body: BlocBuilder<SheetReportsBloc, SheetReportsState>(
        builder: (context, state) {
          if (state is SheetReportsLoading) return const LoadingWidget();
          if (state is SheetRunningFeetReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              hasMore: state.hasMore,
              isLoadingMore: state.isLoadingMore,
              onLoadMore: () {
                if (state.oldestLoadedStart == null || state.isLoadingMore) {
                  return;
                }
                final range = ReportWeekRange.previousWeek(
                  state.oldestLoadedStart!,
                );
                context.read<SheetReportsBloc>().add(
                  LoadSheetRunningFeetReports(
                    startDate: range.start,
                    endDate: range.end,
                    append: true,
                  ),
                );
              },
              onRefresh: () async {
                final range = ReportWeekRange.initial();
                context.read<SheetReportsBloc>().add(
                  LoadSheetRunningFeetReports(
                    startDate: range.start,
                    endDate: range.end,
                  ),
                );
              },
              emptyMessage:
                  'No running feet data yet.\nGenerated from production details.',
              itemBuilder: (context, r, i) {
                return ReportCard(
                  key: ValueKey(r.id),
                  title: '${r.machineNumber} — ${r.shift}',
                  subtitle:
                      '${DateFormat('dd MMM yyyy').format(r.date)} — Target: ${r.targetRunningFeet.toStringAsFixed(1)} ft',
                  trailing: '${r.efficiencyPercentage.toStringAsFixed(1)}%',
                  statusColor: r.efficiencyPercentage >= 80
                      ? AppTheme.successGreen
                      : r.efficiencyPercentage >= 60
                      ? AppTheme.warningYellow
                      : AppTheme.errorRed,
                  onDelete: r.id == null
                      ? null
                      : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetRunningFeetReport(r.id!),
                          ),
                );
              },
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final range = ReportWeekRange.initial();
            context.read<SheetReportsBloc>().add(
              LoadSheetRunningFeetReports(
                startDate: range.start,
                endDate: range.end,
              ),
            );
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
