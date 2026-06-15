import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_cleaning_report_form_page.dart';

class FrameCleaningReportListPage extends StatelessWidget {
  const FrameCleaningReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameReportsBloc, FrameReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Machine Cleaning Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FrameCleaningReportFormPage(),
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
    if (state is MachineCleaningReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(LoadMachineCleaningReports());
        },
        emptyMessage: 'No cleaning reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.percentage.toStringAsFixed(1)}%',
            statusColor: report.percentage >= 80
                ? AppTheme.successGreen
                : AppTheme.errorRed,
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
    // Initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FrameReportsBloc>().add(LoadMachineCleaningReports());
    });
    return const LoadingWidget();
  }
}
