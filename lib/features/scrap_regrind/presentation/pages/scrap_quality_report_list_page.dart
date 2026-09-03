import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/scrap_regrind_bloc.dart';
import 'scrap_quality_report_form_page.dart';

class ScrapQualityReportListPage extends StatelessWidget {
  const ScrapQualityReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Scrap Quality Reports',
      machines: ddp.scrapMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ScrapQualityReportFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<ScrapRegrindBloc>().add(
        LoadScrapQualityReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
          builder: (context, state) {
            if (state is ScrapRegrindLoading) return const LoadingWidget();
            if (state is ScrapQualityReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<ScrapRegrindBloc>().add(
                    LoadScrapQualityReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No scrap quality reports yet',
                itemBuilder: (context, report, index) {
                  final subtitle = StringBuffer()
                    ..write(DateFormat('dd MMM yyyy').format(report.date))
                    ..write(' — ')
                    ..write(report.shift);
                  if (report.comments != null && report.comments!.isNotEmpty) {
                    subtitle.write('\n${report.comments}');
                  }
                  return ReportCard(
                    key: ValueKey(report.id),
                    title: '${report.machineNumber} — ${report.product}',
                    subtitle: subtitle.toString(),
                    trailing: '${report.qualityRating}/10',
                    statusColor: report.qualityRating >= 7
                        ? AppTheme.successGreen
                        : report.qualityRating >= 4
                        ? AppTheme.warningYellow
                        : AppTheme.errorRed,
                    onDelete: report.id == null
                        ? null
                        : () => context.read<ScrapRegrindBloc>().add(
                            DeleteScrapQualityReport(report.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Scrap Quality Report',
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(report.date),
                            ),
                            ReportField('Machine', report.machineNumber),
                            ReportField('Shift', report.shift),
                            ReportField('Product', report.product),
                            ReportField('Quality Rating', '${report.qualityRating}/10'),
                            if (report.comments != null && report.comments!.isNotEmpty)
                              ReportField('Comments', report.comments!),
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
