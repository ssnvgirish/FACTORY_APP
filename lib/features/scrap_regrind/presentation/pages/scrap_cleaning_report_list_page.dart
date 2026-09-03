import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/scrap_regrind_bloc.dart';
import 'scrap_cleaning_report_form_page.dart';

class ScrapCleaningReportListPage extends StatelessWidget {
  const ScrapCleaningReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Machine Cleaning Reports',
      machines: ddp.scrapMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ScrapCleaningReportFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<ScrapRegrindBloc>().add(
        LoadScrapCleaningReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
          builder: (context, state) {
            if (state is ScrapRegrindLoading) return const LoadingWidget();
            if (state is ScrapCleaningReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<ScrapRegrindBloc>().add(
                    LoadScrapCleaningReports(
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
                        : () => context.read<ScrapRegrindBloc>().add(
                            DeleteScrapCleaningReport(report.id!),
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
                            ReportField('Total Score', '${report.totalScore}/20'),
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
          },
        );
      },
    );
  }
}
