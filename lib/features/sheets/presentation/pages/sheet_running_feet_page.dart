import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetRunningFeetPage extends StatelessWidget {
  final String machineId;
  const SheetRunningFeetPage({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Running Feet Report',
      machines: ddp.sheetMachines,
      onQueryChanged: (q) => context.read<SheetReportsBloc>().add(
        LoadSheetRunningFeetReports(
          machineNumber:
              q.machineNumber ?? (machineId.isEmpty ? null : machineId),
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetRunningFeetReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetRunningFeetReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage:
                    'No running feet data yet.\nGenerated from production details.',
                itemBuilder: (context, r, i) {
                  return ReportCard(
                    key: ValueKey(r.id),
                    title: '${r.machineNumber} — ${r.shift}',
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(r.date)} — Target: ${r.targetRunningFeet.toStringAsFixed(1)} ft',
                    trailing: '${r.efficiencyPercentage.toStringAsFixed(1)}%',
                    statusColor: r.efficiencyPercentage >= 80
                        ? AppTheme.successGreen
                        : r.efficiencyPercentage >= 60
                        ? AppTheme.warningYellow
                        : AppTheme.errorRed,
                    onDelete: r.id == null
                        ? null
                        : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetRunningFeetReport(r.id!),
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
