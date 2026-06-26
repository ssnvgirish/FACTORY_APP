import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_production_details_form_page.dart';

class SheetProductionDetailsListPage extends StatelessWidget {
  const SheetProductionDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetReportsBloc, SheetReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sheet Production Details')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SheetProductionDetailsFormPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SheetReportsState state) {
    if (state is SheetReportsLoading) return const LoadingWidget();
    if (state is SheetProductionDetailsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<SheetReportsBloc>().add(
            LoadSheetProductionDetailsReports(),
          );
        },
        emptyMessage: 'No sheet production reports yet',
        itemBuilder: (context, r, i) {
          return ReportCard(
            title: '${r.machineNumber} — ${r.shift}',
            subtitle:
                '${DateFormat('dd MMM yyyy').format(r.date)} — ${r.lineItems.length} items',
            trailing: '${r.totalRunningFeet.toStringAsFixed(1)} ft',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailPage(
                  title: 'Production Details',
                  fields: [
                    ReportField(
                      'Date',
                      DateFormat('dd MMM yyyy').format(r.date),
                    ),
                    ReportField('Machine', r.machineNumber),
                    ReportField('Shift', r.shift),
                    ReportField('Total Quantity', '${r.totalQuantity} pieces'),
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
                                ReportField('Length', '${li.length} in'),
                                ReportField('Width', '${li.width} in'),
                                ReportField('Quantity', '${li.quantity}'),
                                ReportField('SQFT', li.sqft.toStringAsFixed(3)),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SheetReportsBloc>().add(LoadSheetProductionDetailsReports());
    });
    return const LoadingWidget();
  }
}
