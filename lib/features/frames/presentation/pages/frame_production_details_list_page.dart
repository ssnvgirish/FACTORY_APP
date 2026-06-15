import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_production_details_form_page.dart';

class FrameProductionDetailsListPage extends StatelessWidget {
  const FrameProductionDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrameReportsBloc, FrameReportsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Production Details')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FrameProductionDetailsFormPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FrameReportsState state) {
    if (state is FrameReportsLoading) return const LoadingWidget();
    if (state is ProductionDetailsReportsLoaded) {
      return PaginatedListView(
        items: state.reports,
        onRefresh: () async {
          context.read<FrameReportsBloc>().add(LoadProductionDetailsReports());
        },
        emptyMessage: 'No production details reports yet',
        itemBuilder: (context, report, index) {
          return ReportCard(
            title: '${report.machineNumber} — ${report.shift}',
            subtitle:
                '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.lineItems.length} items',
            trailing: '${report.totalWeight.toStringAsFixed(1)} kg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailPage(
                  title: 'Production Details',
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
                                ReportField('Quantity', '${li.quantity}'),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FrameReportsBloc>().add(LoadProductionDetailsReports());
    });
    return const LoadingWidget();
  }
}
