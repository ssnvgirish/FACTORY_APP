import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetWritingEfficiencyPage extends StatefulWidget {
  const SheetWritingEfficiencyPage({super.key});

  @override
  State<SheetWritingEfficiencyPage> createState() =>
      _SheetWritingEfficiencyPageState();
}

class _SheetWritingEfficiencyPageState
    extends State<SheetWritingEfficiencyPage> {
  DateTime? _lastLoadedStartDate;
  DateTime? _lastLoadedEndDate;

  void _loadForDateRange(ReportListQuery query) {
    final isSameStart = _lastLoadedStartDate == query.startDate;
    final isSameEnd = _lastLoadedEndDate == query.endDate;
    if (isSameStart && isSameEnd) return;
    _lastLoadedStartDate = query.startDate;
    _lastLoadedEndDate = query.endDate;
    context.read<SheetReportsBloc>().add(
      LoadSheetWritingEfficiency(
        startDate: query.startDate,
        endDate: query.endDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Report Writing Efficiency',
      machines: ddp.sheetMachines,
      onQueryChanged: _loadForDateRange,
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetWritingEfficiencyLoaded) {
              final records = query.machineNumber == null
                  ? state.records
                  : state.records
                        .where((r) => r.machineNumber == query.machineNumber)
                        .toList();
              return PaginatedListView(
                items: records,
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetWritingEfficiency(
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
                        : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetWritingEfficiency(record.id!),
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
