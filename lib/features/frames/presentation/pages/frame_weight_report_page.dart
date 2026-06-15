import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameWeightReportListPage extends StatelessWidget {
  const FrameWeightReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Production Weight Reports')),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is ProductionWeightReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<FrameReportsBloc>().add(
                  LoadProductionWeightReports(),
                );
              },
              emptyMessage: 'No production weight reports yet',
              itemBuilder: (context, report, index) {
                return ReportCard(
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<FrameReportsBloc>().add(LoadProductionWeightReports());
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
