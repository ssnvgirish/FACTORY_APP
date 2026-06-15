import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../bloc/sheet_reports_bloc.dart';
import 'sheet_customer_rejection_page.dart';

class SheetCustomerRejectionListPage extends StatelessWidget {
  const SheetCustomerRejectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Customer Rejection Reports')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SheetCustomerRejectionPage(machineId: ''),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SheetReportsBloc, SheetReportsState>(
        builder: (context, state) {
          if (state is SheetReportsLoading) return const LoadingWidget();
          if (state is SheetReportsError) {
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
                    onPressed: () => context.read<SheetReportsBloc>().add(
                      LoadSheetCustomerRejectionReports(),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is SheetCustomerRejectionReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<SheetReportsBloc>().add(
                  LoadSheetCustomerRejectionReports(),
                );
              },
              emptyMessage: 'No sheet customer rejection reports yet',
              itemBuilder: (context, report, index) {
                return ReportCard(
                  title: report.machineNumber,
                  subtitle:
                      'Production date: ${DateFormat('dd MMM yyyy').format(report.originalProductionDate)}',
                  trailing:
                      '${report.totalRejectedRunningFeet.toStringAsFixed(1)} ft',
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
                          ReportField('Machine', report.machineNumber),
                          ReportField('Shift', report.shift),
                          ReportField(
                            'Total Rejected Running Feet',
                            '${report.totalRejectedRunningFeet.toStringAsFixed(3)} ft',
                          ),
                        ],
                        sections: [
                          ReportSection(
                            title: 'Rejected Items',
                            items: report.rejectedItems
                                .map(
                                  (li) => ReportSectionItem(
                                    fields: [
                                      ReportField('Thickness', li.thickness),
                                      ReportField('Density', li.density),
                                      ReportField('Color', li.color),
                                      ReportField('Length', '${li.length} in'),
                                      ReportField('Width', '${li.width} in'),
                                      ReportField('Quantity', '${li.quantity}'),
                                      ReportField(
                                        'SQFT',
                                        '${li.sqft.toStringAsFixed(3)}',
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

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<SheetReportsBloc>().add(
              LoadSheetCustomerRejectionReports(),
            );
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
