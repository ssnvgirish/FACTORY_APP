import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/scrap_regrind_bloc.dart';
import 'scrap_health_report_form_page.dart';

class ScrapHealthReportListPage extends StatelessWidget {
  const ScrapHealthReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Machine Health Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ScrapHealthReportFormPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ScrapRegrindState state) {
    if (state is ScrapRegrindLoading) return const LoadingWidget();
    if (state is ScrapHealthReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<ScrapRegrindBloc>().add(LoadScrapHealthReports());
        },
        emptyMessage: 'No health reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: report.machineNumber,
            subtitle:
                '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.shift}',
            trailing:
                '${report.totalMaintenanceDurationHours.toStringAsFixed(1)}h',
            statusColor: AppTheme.pendingBlue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailPage(
                  title: 'Machine Health Report',
                  fields: [
                    ReportField(
                      'Date',
                      DateFormat('dd MMM yyyy').format(report.date),
                    ),
                    ReportField('Machine', report.machineNumber),
                    ReportField('Shift', report.shift),
                    ReportField(
                      'Total Maintenance Hours',
                      '${report.totalMaintenanceDurationHours.toStringAsFixed(2)}h',
                    ),
                  ],
                  sections: [
                    ReportSection(
                      title: 'Maintenance Entries',
                      itemLabel: 'Entry',
                      items: report.entries
                          .map(
                            (e) => ReportSectionItem(
                              heading: e.maintenanceItem,
                              fields: [
                                ReportField(
                                  'Start',
                                  DateFormat('hh:mm a').format(e.startTime),
                                ),
                                ReportField(
                                  'End',
                                  DateFormat('hh:mm a').format(e.endTime),
                                ),
                                ReportField(
                                  'Duration',
                                  '${e.durationHours.toStringAsFixed(2)}h',
                                ),
                                ReportField('Person', e.personDoingMaintenance),
                                ReportField('Description', e.description),
                              ],
                            ),
                          )
                          .toList(),
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
      context.read<ScrapRegrindBloc>().add(LoadScrapHealthReports());
    });
    return const LoadingWidget();
  }
}
