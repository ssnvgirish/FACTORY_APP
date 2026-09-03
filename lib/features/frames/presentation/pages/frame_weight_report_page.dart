import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameWeightReportListPage extends StatelessWidget {
  const FrameWeightReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Production Weight Reports',
      machines: ddp.frameMachines,
      onQueryChanged: (q) => context.read<FrameReportsBloc>().add(
        LoadProductionWeightReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<FrameReportsBloc, FrameReportsState>(
          builder: (context, state) {
            if (state is FrameReportsLoading) return const LoadingWidget();
            if (state is ProductionWeightReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<FrameReportsBloc>().add(
                    LoadProductionWeightReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No production weight reports yet',
                itemBuilder: (context, report, index) {
                  return ReportCard(
                    key: ValueKey(report.id),
                    title: '${report.machineNumber} — ${report.shift}',
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(report.date)} — Target: ${report.targetWeight.toStringAsFixed(1)} kg',
                    trailing:
                        '${report.efficiencyPercentage.toStringAsFixed(1)}%',
                    statusColor: report.efficiencyPercentage >= 80
                        ? AppTheme.successGreen
                        : report.efficiencyPercentage >= 60
                        ? AppTheme.warningYellow
                        : AppTheme.errorRed,
                    onDelete: report.id == null
                        ? null
                        : () => context.read<FrameReportsBloc>().add(
                            DeleteProductionWeightReport(report.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Production Weight Report',
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(report.date),
                            ),
                            ReportField('Machine', report.machineNumber),
                            ReportField('Shift', report.shift),
                            ReportField(
                              'Production Weight',
                              '${report.productionWeight.toStringAsFixed(3)} kg',
                            ),
                            ReportField(
                              'Maintenance Weight',
                              '${report.maintenanceWeight.toStringAsFixed(3)} kg',
                            ),
                            ReportField(
                              'Total Production Weight',
                              '${report.totalProductionWeight.toStringAsFixed(3)} kg',
                            ),
                            ReportField(
                              'Target Weight',
                              '${report.targetWeight.toStringAsFixed(3)} kg',
                            ),
                            ReportField(
                              'Efficiency',
                              '${report.efficiencyPercentage.toStringAsFixed(1)}%',
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
