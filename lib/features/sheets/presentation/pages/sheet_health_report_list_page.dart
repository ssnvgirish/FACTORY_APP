import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_health_report_page.dart';

class SheetHealthReportListPage extends StatelessWidget {
  const SheetHealthReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetReportsBloc, SheetReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sheet Machine Health Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SheetHealthReportPage(machineId: ''),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SheetReportsState state) {
    if (state is SheetReportsLoading) return const LoadingWidget();
    if (state is SheetHealthReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<SheetReportsBloc>().add(LoadSheetHealthReports());
        },
        emptyMessage: 'No sheet machine health reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: '${report.machineNumber} - ${report.shift}',
            subtitle:
                '${DateFormat('dd MMM yyyy').format(report.date)} - Score: ${report.totalScore}/${report.ratings.length * 10}',
            trailing: '${report.percentage.toStringAsFixed(1)}%',
            statusColor: report.percentage >= 80
                ? AppTheme.successGreen
                : report.percentage >= 50
                ? AppTheme.warningYellow
                : AppTheme.errorRed,
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
                      'Total Score',
                      '${report.totalScore}/${report.ratings.length * 10}',
                    ),
                    ReportField(
                      'Percentage',
                      '${report.percentage.toStringAsFixed(1)}%',
                    ),
                  ],
                  sections: [
                    ReportSection(
                      title: 'Health Ratings',
                      itemLabel: 'Rating',
                      items: report.ratings
                          .map(
                            (r) => ReportSectionItem(
                              heading: r.item,
                              fields: [ReportField('Rating', '${r.rating}/10')],
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
      context.read<SheetReportsBloc>().add(LoadSheetHealthReports());
    });
    return const LoadingWidget();
  }
}
