import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/utils/report_edit_window.dart';
import '../../../../core/utils/report_week_range.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_production_details_form_page.dart';

class FrameProductionDetailsListPage extends StatelessWidget {
  const FrameProductionDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Production Details',
      machines: ddp.frameMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FrameProductionDetailsFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<FrameReportsBloc>().add(
        LoadProductionDetailsReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<FrameReportsBloc, FrameReportsState>(
          builder: (context, state) {
            if (state is FrameReportsLoading) return const LoadingWidget();
            if (state is ProductionDetailsReportsLoaded) {
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
                  context.read<FrameReportsBloc>().add(
                    LoadProductionDetailsReports(
                      machineNumber: query.machineNumber,
                      startDate: range.start,
                      endDate: range.end,
                      append: true,
                    ),
                  );
                },
                onRefresh: () async {
                  context.read<FrameReportsBloc>().add(
                    LoadProductionDetailsReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No production details reports yet',
                itemBuilder: (context, report, index) {
                  return ReportCard(
                    key: ValueKey(report.id),
                    title: '${report.machineNumber} — ${report.shift}',
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.lineItems.length} items',
                    trailing: '${report.totalWeight.toStringAsFixed(1)} kg',
                    onDelete: report.id == null
                        ? null
                        : () => context.read<FrameReportsBloc>().add(
                            DeleteProductionDetailsReport(report.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Production Details',
                          onEdit: canEditSubmittedReport(report.submittedAt)
                              ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FrameProductionDetailsFormPage(
                                          existing: report,
                                        ),
                                  ),
                                )
                              : null,
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(report.date),
                            ),
                            ReportField('Machine', report.machineNumber),
                            ReportField('Shift', report.shift),
                            ReportField(
                              'Total Quantity',
                              '${report.totalQuantity} pieces',
                            ),
                            ReportField(
                              'Total Weight',
                              '${report.totalWeight.toStringAsFixed(3)} kg',
                            ),
                          ],
                          sections: [
                            ReportSection(
                              title: 'Line Items',
                              items: report.lineItems
                                  .map(
                                    (li) => ReportSectionItem(
                                      fields: [
                                        ReportField('Section', li.section),
                                        ReportField('Density', li.density),
                                        ReportField('Color', li.color),
                                        ReportField('Length', '${li.length} ft'),
                                        ReportField(
                                          'Quantity',
                                          '${li.quantity}',
                                        ),
                                        ReportField(
                                          'Per Piece Weight',
                                          '${li.perPieceWeight.toStringAsFixed(3)} kg',
                                        ),
                                        ReportField(
                                          'Total Weight',
                                          '${li.totalWeight.toStringAsFixed(3)} kg',
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
