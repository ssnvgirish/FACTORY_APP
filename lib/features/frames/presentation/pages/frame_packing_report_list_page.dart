import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_packing_report_form_page.dart';

class FramePackingReportListPage extends StatelessWidget {
  const FramePackingReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shift Packing Reports')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FramePackingReportFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is ShiftPackingReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<FrameReportsBloc>().add(LoadShiftPackingReports());
              },
              emptyMessage: 'No packing reports yet',
              itemBuilder: (context, report, index) {
                return ReportCard(
                  title: '${report.machineNumber} — ${report.shift}',
                  subtitle:
                      '${DateFormat('dd MMM yyyy').format(report.date)} — Quality: ${report.qualityAcceptancePercentage.toStringAsFixed(1)}%',
                  trailing: '${report.packingEfficiency.toStringAsFixed(1)}%',
                  statusColor: report.packingEfficiency >= 90
                      ? AppTheme.successGreen
                      : AppTheme.warningYellow,
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
                            'Total Rejected Weight',
                            '${report.totalRejectedWeight.toStringAsFixed(3)} kg',
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
                                      ReportField('Section', li.section),
                                      ReportField('Density', li.density),
                                      ReportField('Color', li.color),
                                      ReportField('Length', '${li.length} ft'),
                                      ReportField(
                                        'Production Qty',
                                        '${li.productionQuantity}',
                                      ),
                                      ReportField('Packed', '${li.packed}'),
                                      ReportField(
                                        'Rejected (Quality)',
                                        '${li.rejectedQuality}',
                                      ),
                                      ReportField(
                                        'Rejected Weight',
                                        '${li.rejectedWeight.toStringAsFixed(3)} kg',
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
            context.read<FrameReportsBloc>().add(LoadShiftPackingReports());
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
