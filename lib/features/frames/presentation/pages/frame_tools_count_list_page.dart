import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_tools_count_form_page.dart';

class FrameToolsCountListPage extends StatelessWidget {
  const FrameToolsCountListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameReportsBloc, FrameReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Tools Count Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FrameToolsCountFormPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FrameReportsState state) {
    if (state is FrameReportsLoading) return const LoadingWidget();
    if (state is ToolsCountReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(LoadToolsCountReports());
        },
        emptyMessage: 'No tools count reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.percentageAvailable.toStringAsFixed(1)}%',
            statusColor: report.percentageAvailable >= 80
                ? AppTheme.successGreen
                : AppTheme.errorRed,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FrameReportsBloc>().add(LoadToolsCountReports());
    });
    return const LoadingWidget();
  }
}
