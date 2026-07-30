import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/report_week_range.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetWritingEfficiencyPage extends StatelessWidget {
  const SheetWritingEfficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Report Writing Efficiency')),
      body: BlocBuilder<SheetReportsBloc, SheetReportsState>(
        builder: (context, state) {
          if (state is SheetReportsLoading) return const LoadingWidget();
          if (state is SheetWritingEfficiencyLoaded) {
            return PaginatedListView(
              items: state.records,
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
                  LoadSheetWritingEfficiency(
                    startDate: range.start,
                    endDate: range.end,
                    append: true,
                  ),
                );
              },
              onRefresh: () async {
                final range = ReportWeekRange.initial();
                context.read<SheetReportsBloc>().add(
                  LoadSheetWritingEfficiency(
                    startDate: range.start,
                    endDate: range.end,
                  ),
                );
              },
              emptyMessage: 'No writing efficiency records yet',
              itemBuilder: (context, record, index) {
                return ReportCard(
                  title: record.machineNumber,
                  subtitle:
                      '${DateFormat('dd MMM yyyy').format(record.date)} — ${record.shift}',
                  trailing: '${record.score}/5',
                  statusColor: record.score >= 4
                      ? AppTheme.successGreen
                      : record.score >= 2
                      ? AppTheme.warningYellow
                      : AppTheme.errorRed,
                );
              },
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final range = ReportWeekRange.initial();
            context.read<SheetReportsBloc>().add(
              LoadSheetWritingEfficiency(
                startDate: range.start,
                endDate: range.end,
              ),
            );
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
