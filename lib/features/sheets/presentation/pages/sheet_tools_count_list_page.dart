import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_tools_count_page.dart';

class SheetToolsCountListPage extends StatelessWidget {
  const SheetToolsCountListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Tools Count Reports',
      machines: ddp.sheetMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SheetToolsCountPage(machineId: ''),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<SheetReportsBloc>().add(
        LoadSheetToolsCountReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) => _buildBody(context, state, query),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    SheetReportsState state,
    ReportListQuery query,
  ) {
    if (state is SheetReportsLoading) return const LoadingWidget();
    if (state is SheetToolsCountReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<SheetReportsBloc>().add(
            LoadSheetToolsCountReports(
              machineNumber: query.machineNumber,
              startDate: query.startDate,
              endDate: query.endDate,
            ),
          );
        },
        emptyMessage: 'No sheet tools count reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            key: ValueKey(report.id),
            title: report.machineNumber,
            subtitle: DateFormat('dd MMM yyyy').format(report.date),
            trailing: '${report.percentageAvailable.toStringAsFixed(1)}%',
            statusColor: report.percentageAvailable >= 80
                ? AppTheme.successGreen
                : AppTheme.errorRed,
            onDelete: report.id == null
                ? null
                : () => context.read<SheetReportsBloc>().add(
                      DeleteSheetToolsCountReport(report.id!),
                    ),
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
    return const LoadingWidget();
  }
}
