import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_health_report_form_page.dart';

class FrameHealthReportListPage extends StatelessWidget {
  const FrameHealthReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Machine Health Reports',
      machines: ddp.frameMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FrameHealthReportFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (query) => context.read<FrameReportsBloc>().add(
        LoadMachineHealthReports(
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
    if (state is MachineHealthReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(
            LoadMachineHealthReports(
              machineNumber: query.machineNumber,
              startDate: query.startDate,
              endDate: query.endDate,
            ),
          );
        },
        emptyMessage: 'No machine health reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            key: ValueKey(report.id),
            title: '${report.machineNumber} — ${report.shift}',
            subtitle:
                '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.entries.length} item(s)',
            trailing:
                '${report.totalMaintenanceDurationHours.toStringAsFixed(1)}h',
            statusColor: AppTheme.pendingBlue,
            onDelete: report.id == null
                ? null
                : () => context.read<FrameReportsBloc>().add(
                    DeleteMachineHealthReport(report.id!),
                  ),
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
                      'Total Maintenance Duration',
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
    return const LoadingWidget();
  }
}
