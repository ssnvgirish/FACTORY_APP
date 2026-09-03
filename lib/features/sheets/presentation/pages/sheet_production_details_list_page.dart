import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/utils/report_edit_window.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_production_details_form_page.dart';

class SheetProductionDetailsListPage extends StatelessWidget {
  const SheetProductionDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Sheet Production Details',
      machines: ddp.sheetMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SheetProductionDetailsFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<SheetReportsBloc>().add(
        LoadSheetProductionDetailsReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            if (state is SheetProductionDetailsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<SheetReportsBloc>().add(
                    LoadSheetProductionDetailsReports(
                      machineNumber: query.machineNumber,
                      startDate: query.startDate,
                      endDate: query.endDate,
                    ),
                  );
                },
                emptyMessage: 'No sheet production reports yet',
                itemBuilder: (context, r, i) {
                  return ReportCard(
                    key: ValueKey(r.id),
                    title: '${r.machineNumber} — ${r.shift}',
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(r.date)} — ${r.lineItems.length} items',
                    trailing: '${r.totalRunningFeet.toStringAsFixed(1)} ft',
                    onDelete: r.id == null
                        ? null
                        : () => context.read<SheetReportsBloc>().add(
                            DeleteSheetProductionDetailsReport(r.id!),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailPage(
                          title: 'Production Details',
                          onEdit: canEditSubmittedReport(r.submittedAt)
                              ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SheetProductionDetailsFormPage(
                                          existing: r,
                                        ),
                                  ),
                                )
                              : null,
                          fields: [
                            ReportField(
                              'Date',
                              DateFormat('dd MMM yyyy').format(r.date),
                            ),
                            ReportField('Machine', r.machineNumber),
                            ReportField('Shift', r.shift),
                            ReportField(
                              'Total Quantity',
                              '${r.totalQuantity} pieces',
                            ),
                            ReportField(
                              'Total Weight',
                              '${r.totalWeight.toStringAsFixed(3)} kg',
                            ),
                            ReportField(
                              'Total Running Feet',
                              '${r.totalRunningFeet.toStringAsFixed(3)} ft',
                            ),
                          ],
                          sections: [
                            ReportSection(
                              title: 'Line Items',
                              items: r.lineItems
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
                                          'Quantity',
                                          '${li.quantity}',
                                        ),
                                        ReportField(
                                          'SQFT',
                                          li.sqft.toStringAsFixed(3),
                                        ),
                                        ReportField(
                                          'Per Piece Weight',
                                          '${li.perPieceWeight.toStringAsFixed(3)} kg',
                                        ),
                                        ReportField(
                                          'Total Weight',
                                          '${li.totalWeight.toStringAsFixed(3)} kg',
                                        ),
                                        ReportField(
                                          'Running Feet',
                                          '${li.totalRunningFeet.toStringAsFixed(3)} ft',
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
