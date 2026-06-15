import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapWeightReportListPage extends StatelessWidget {
  const ScrapWeightReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Production Weight Reports')),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ScrapRegrindState state) {
    if (state is ScrapRegrindLoading) return const LoadingWidget();
    if (state is ScrapProductionWeightReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<ScrapRegrindBloc>().add(
            LoadScrapProductionWeightReports(),
          );
        },
        emptyMessage: 'No weight reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.totalProductionWeight.toStringAsFixed(1)} kg',
            statusColor: AppTheme.successGreen,
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
                      '${report.totalProductionWeight.toStringAsFixed(3)} kg',
                    ),
                    ReportField(
                      'Maintenance Weight',
                      '${report.maintenanceWeight.toStringAsFixed(3)} kg',
                    ),
                    ReportField(
                      'Total Weight',
                      '${report.totalWeight.toStringAsFixed(3)} kg',
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
      context.read<ScrapRegrindBloc>().add(LoadScrapProductionWeightReports());
    });
    return const LoadingWidget();
  }
}
