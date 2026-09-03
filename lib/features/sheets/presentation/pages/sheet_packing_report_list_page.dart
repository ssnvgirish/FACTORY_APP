import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_packing_report_page.dart';

class SheetPackingReportListPage extends StatelessWidget {
  const SheetPackingReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Shift Packing Reports',
      machines: ddp.sheetMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SheetPackingReportPage(machineId: ''),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<SheetReportsBloc>().add(
        LoadSheetPackingReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetPackingReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetPackingReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No sheet packing reports yet',
                itemBuilder: (context, report, index) {
                  return ReportCard(
                    key: ValueKey(report.id),
                    title: '${report.machineNumber} - ${report.shift}',
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(report.date)} - Quality: ${report.qualityAcceptancePercentage.toStringAsFixed(1)}%',
                    trailing: '${report.packingEfficiency.toStringAsFixed(1)}%',
                    statusColor: report.packingEfficiency >= 90
                        ? AppTheme.successGreen
                        : AppTheme.warningYellow,
                    onDelete: report.id == null
                        ? null
                        : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetPackingReport(report.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Packing Report',
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(report.date),
                            ),
                            ReportField('Machine', report.machineNumber),
                            ReportField('Shift', report.shift),
                            ReportField(
                              'Total Rejected Running Feet',
                              '${report.totalRejectedRunningFeet.toStringAsFixed(3)} ft',
                            ),
                            ReportField(
                              'Quality Acceptance',
                              '${report.qualityAcceptancePercentage.toStringAsFixed(1)}%',
                            ),
                            ReportField(
                              'Packing Efficiency',
                              '${report.packingEfficiency.toStringAsFixed(1)}%',
                            ),
                          ],
                          sections: [
                            ReportSection(
                              title: 'Packing Items',
                              items: report.lineItems
                                  .map(
                                    (li) => ReportSectionItem(
                                      fields: [
                                        ReportField('Thickness', li.thickness),
                                        ReportField('Density', li.density),
                                        ReportField('Color', li.color),
                                        ReportField(
                                          'Length',
                                          '${li.length} in',
                                        ),
                                        ReportField('Width', '${li.width} in'),
                                        ReportField(
                                          'Production Qty',
                                          '${li.productionQuantity}',
                                        ),
                                        ReportField('Packed', '${li.packed}'),
                                        ReportField(
                                          'Only Sanding',
                                          '${li.onlySanding}',
                                        ),
                                        ReportField(
                                          'Sanding & Packed',
                                          '${li.sandingAndPacked}',
                                        ),
                                        ReportField(
                                          'Rejected (Quality)',
                                          '${li.rejectedQuality}',
                                        ),
                                      ],
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
            return const LoadingWidget();
          },
        );
      },
    );
  }
}
