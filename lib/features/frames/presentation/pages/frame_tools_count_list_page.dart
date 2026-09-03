import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_tools_count_form_page.dart';

class FrameToolsCountListPage extends StatelessWidget {
  const FrameToolsCountListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Tools Count Reports',
      machines: ddp.frameMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FrameToolsCountFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (query) => context.read<FrameReportsBloc>().add(
        LoadToolsCountReports(
          machineNumber: query.machineNumber,
          startDate: query.startDate,
          endDate: query.endDate,
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
    if (state is ToolsCountReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(
            LoadToolsCountReports(
              machineNumber: query.machineNumber,
              startDate: query.startDate,
              endDate: query.endDate,
            ),
          );
        },
        emptyMessage: 'No tools count reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            key: ValueKey(report.id),
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.percentageAvailable.toStringAsFixed(1)}%',
            statusColor: report.percentageAvailable >= 80
                ? AppTheme.successGreen
                : AppTheme.errorRed,
            onDelete: report.id == null
                ? null
                : () => context.read<FrameReportsBloc>().add(
                    DeleteToolsCountReport(report.id!),
                  ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailPage(
                  title: 'Tools Count Report',
                  fields: [
                    ReportField(
                      'Date',
                      DateFormat('dd MMM yyyy').format(report.date),
                    ),
                    ReportField('Machine', report.machineNumber),
                    ReportField('Tools Given', '${report.totalToolsGiven}'),
                    ReportField(
                      'Tools Available',
                      '${report.totalToolsAvailable}',
                    ),
                    ReportField(
                      'Percentage',
                      '${report.percentageAvailable.toStringAsFixed(1)}%',
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
