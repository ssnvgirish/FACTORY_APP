import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/report_week_range.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_cleaning_report_form_page.dart';

class FrameCleaningReportListPage extends StatelessWidget {
  const FrameCleaningReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Machine Cleaning Reports',
      machines: ddp.frameMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FrameCleaningReportFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<FrameReportsBloc>().add(
        LoadMachineCleaningReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<FrameReportsBloc, FrameReportsState>(
          builder: (context, state) => _buildBody(context, state, query),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    FrameReportsState state,
    ReportListQuery query,
  ) {
    if (state is FrameReportsLoading) return const LoadingWidget();
    if (state is MachineCleaningReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        hasMore: state.hasMore,
        isLoadingMore: state.isLoadingMore,
        onLoadMore: () {
          if (state.oldestLoadedStart == null || state.isLoadingMore) {
            return;
          }
          final range = ReportWeekRange.previousWeek(state.oldestLoadedStart!);
          context.read<FrameReportsBloc>().add(
            LoadMachineCleaningReports(
              machineNumber: query.machineNumber,
              startDate: range.start,
              endDate: range.end,
              append: true,
            ),
          );
        },
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(
            LoadMachineCleaningReports(
              machineNumber: query.machineNumber,
              startDate: query.startDate,
              endDate: query.endDate,
            ),
          );
        },
        emptyMessage: 'No cleaning reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            key: ValueKey(report.id),
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.percentage.toStringAsFixed(1)}%',
            statusColor: report.percentage >= 80
                ? AppTheme.successGreen
                : AppTheme.errorRed,
            onDelete: report.id == null
                ? null
                : () => context.read<FrameReportsBloc>().add(
                    DeleteMachineCleaningReport(report.id!),
                  ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailPage(
                  title: 'Cleaning Report',
                  fields: [
                    ReportField(
                      'Date',
                      DateFormat('dd MMM yyyy').format(report.date),
                    ),
                    ReportField('Machine', report.machineNumber),
                    ReportField(
                      'Machine Condition',
                      '${report.machineCondition}/10',
                    ),
                    ReportField(
                      'Ground Condition',
                      '${report.groundCondition}/10',
                    ),
                    ReportField(
                      'Mould Condition',
                      '${report.mouldCondition}/10',
                    ),
                    ReportField('Total Score', '${report.totalScore}/30'),
                    ReportField(
                      'Percentage',
                      '${report.percentage.toStringAsFixed(1)}%',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return const LoadingWidget();
  }
}
