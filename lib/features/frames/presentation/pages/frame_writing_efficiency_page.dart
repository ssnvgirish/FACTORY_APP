import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameWritingEfficiencyPage extends StatelessWidget {
  const FrameWritingEfficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Report Writing Efficiency',
      machines: ddp.frameMachines,
      onQueryChanged: (q) => context.read<FrameReportsBloc>().add(
        LoadFrameWritingEfficiency(startDate: q.startDate, endDate: q.endDate),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<FrameReportsBloc, FrameReportsState>(
          builder: (context, state) {
            if (state is FrameReportsLoading) return const LoadingWidget();
            if (state is FrameWritingEfficiencyLoaded) {
              final records = query.machineNumber == null
                  ? state.records
                  : state.records
                        .where((r) => r.machineNumber == query.machineNumber)
                        .toList();
              return PaginatedListView(
                items: records,
                onRefresh: () async {
                  context.read<FrameReportsBloc>().add(
                    LoadFrameWritingEfficiency(
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No writing efficiency records yet',
                itemBuilder: (context, record, index) {
                  return ReportCard(
                    key: ValueKey(record.id),
                    title: record.machineNumber,
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(record.date)} — ${record.shift}',
                    trailing: '${record.score}/5',
                    statusColor: record.score >= 4
                        ? AppTheme.successGreen
                        : record.score >= 2
                        ? AppTheme.warningYellow
                        : AppTheme.errorRed,
                    onDelete: record.id == null
                        ? null
                        : () => context.read<FrameReportsBloc>().add(
                            DeleteFrameWritingEfficiencyRecord(record.id!),
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
