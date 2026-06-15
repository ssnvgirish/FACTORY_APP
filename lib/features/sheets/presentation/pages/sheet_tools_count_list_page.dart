import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_tools_count_page.dart';

class SheetToolsCountListPage extends StatelessWidget {
  const SheetToolsCountListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetReportsBloc, SheetReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sheet Tools Count Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SheetToolsCountPage(machineId: ''),
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
    if (state is SheetToolsCountReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<SheetReportsBloc>().add(LoadSheetToolsCountReports());
        },
        emptyMessage: 'No sheet tools count reports yet',
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
      context.read<SheetReportsBloc>().add(LoadSheetToolsCountReports());
    });
    return const LoadingWidget();
  }
}
