import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/report_week_range.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_cleaning_report_form_page.dart';

class SheetCleaningReportListPage extends StatelessWidget {
  const SheetCleaningReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Cleaning Reports',
      machines: ddp.sheetMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SheetCleaningReportFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<SheetReportsBloc>().add(
        LoadSheetCleaningReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetCleaningReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                hasMore: state.hasMore,
                isLoadingMore: state.isLoadingMore,
                onLoadMore: () {
                  if (state.oldestLoadedStart == null || state.isLoadingMore) {
                    return;
                  }
                  final range = ReportWeekRange.previousWeek(
                    state.oldestLoadedStart!,
                  );
                  context.read<SheetReportsBloc>().add(
                    LoadSheetCleaningReports(
                      machineNumber: query.machineNumber,
                      startDate: range.start,
                      endDate: range.end,
                      append: true,
                    ),
                  );
                },
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetCleaningReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No cleaning reports yet',
                itemBuilder: (context, r, i) {
                  return ReportCard(
                    key: ValueKey(r.id),
                    title: r.machineNumber,
                    subtitle: DateFormat('dd MMM yyyy').format(r.date),
                    trailing: '${r.percentage.toStringAsFixed(1)}%',
                    statusColor: r.percentage >= 80
                        ? AppTheme.successGreen
                        : AppTheme.errorRed,
                    onDelete: r.id == null
                        ? null
                        : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetCleaningReport(r.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Cleaning Report',
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(r.date),
                            ),
                            ReportField('Machine', r.machineNumber),
                            ReportField(
                              'Machine Condition',
                              '${r.machineCondition}/10',
                            ),
                            ReportField(
                              'Ground Condition',
                              '${r.groundCondition}/10',
                            ),
                            ReportField(
                              'Mould Condition',
                              '${r.mouldCondition}/10',
                            ),
                            ReportField('Total Score', '${r.totalScore}/30'),
                            ReportField(
                              'Percentage',
                              '${r.percentage.toStringAsFixed(1)}%',
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
