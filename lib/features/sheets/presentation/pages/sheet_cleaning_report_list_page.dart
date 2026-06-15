import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_cleaning_report_form_page.dart';

class SheetCleaningReportListPage extends StatelessWidget {
  const SheetCleaningReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetReportsBloc, SheetReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sheet Cleaning Reports')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SheetCleaningReportFormPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: () {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetCleaningReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetCleaningReports(),
                  );
                },
                emptyMessage: 'No cleaning reports yet',
                itemBuilder: (context, r, i) {
                  return ReportCard(
                    title: r.machineNumber,
                    subtitle: DateFormat('dd MMM yyyy').format(r.date),
                    trailing: '${r.percentage.toStringAsFixed(1)}%',
                    statusColor: r.percentage >= 80
                        ? AppTheme.successGreen
                        : AppTheme.errorRed,
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<SheetReportsBloc>().add(LoadSheetCleaningReports());
            });
            return const LoadingWidget();
          }(),
        );
      },
    );
  }
}
