import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/frame_reports_bloc.dart';
import 'frame_customer_rejection_form_page.dart';

class FrameCustomerRejectionListPage extends StatelessWidget {
  const FrameCustomerRejectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Rejection Reports')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FrameCustomerRejectionFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is FrameReportsError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppTheme.errorRed,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(state.message, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<FrameReportsBloc>().add(
                      LoadCustomerRejectionReports(),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is CustomerRejectionReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<FrameReportsBloc>().add(
                  LoadCustomerRejectionReports(),
                );
              },
              emptyMessage: 'No customer rejection reports',
              itemBuilder: (context, report, index) {
                return ReportCard(
                  title: report.machineNumber,
                  subtitle:
                      'Production: ${DateFormat('dd MMM yyyy').format(report.originalProductionDate)}\nRejected: ${DateFormat('dd MMM yyyy').format(report.rejectionDate)}',
                  trailing:
                      '${report.totalRejectedWeight.toStringAsFixed(1)} kg',
                  statusColor: AppTheme.errorRed,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportDetailPage(
                        title: 'Customer Rejection',
                        fields: [
                          ReportField(
                            'Production Date',
                            DateFormat(
                              'dd MMM yyyy',
                            ).format(report.originalProductionDate),
                          ),
                          ReportField(
                            'Rejection Date',
                            DateFormat(
                              'dd MMM yyyy',
                            ).format(report.rejectionDate),
                          ),
                          ReportField('Machine', report.machineNumber),
                          ReportField('Shift', report.shift),
                          ReportField(
                            'Total Rejected Weight',
                            '${report.totalRejectedWeight.toStringAsFixed(3)} kg',
                          ),
                        ],
                        sections: [
                          ReportSection(
                            title: 'Rejected Items',
                            items: report.rejectedItems
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
            context.read<FrameReportsBloc>().add(
              LoadCustomerRejectionReports(),
            );
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
