import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/report_detail_page.dart';
import '../../../../core/widgets/report_list_page_shell.dart';
import '../bloc/scrap_regrind_bloc.dart';
import 'scrap_production_details_form_page.dart';

class ScrapProductionDetailsListPage extends StatelessWidget {
  const ScrapProductionDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportListPageShell(
      title: 'Production Details Reports',
      machines: ddp.scrapMachines,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ScrapProductionDetailsFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      onQueryChanged: (q) => context.read<ScrapRegrindBloc>().add(
        LoadScrapProductionDetailsReports(
          machineNumber: q.machineNumber,
          startDate: q.startDate,
          endDate: q.endDate,
        ),
      ),
      bodyBuilder: (context, query) {
        return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
          builder: (context, state) {
            if (state is ScrapRegrindLoading) return const LoadingWidget();
            if (state is ScrapProductionDetailsReportsLoaded) {
              return PaginatedListView(
                items: state.reports,
                onRefresh: () async {
                  context.read<ScrapRegrindBloc>().add(
                    LoadScrapProductionDetailsReports(
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
                    title: report.machineNumber,
                    subtitle:
                        '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.shift}',
                    trailing: '${report.totalProductionWeight.toStringAsFixed(1)} kg',
                    statusColor: AppTheme.successGreen,
                    onDelete: report.id == null
                        ? null
                        : () => context.read<ScrapRegrindBloc>().add(
                            DeleteScrapProductionDetailsReport(report.id!),
                          ),
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
                              'Total Production Weight',
                              '${report.totalProductionWeight.toStringAsFixed(3)} kg',
                            ),
                          ],
                          sections: [
                            ReportSection(
                              title: 'Line Items',
                              items: report.lineItems
                                  .map(
                                    (li) => ReportSectionItem(
                                      heading: li.product,
                                      fields: [
                                        ReportField(
                                          'Weight per Bag',
                                          '${li.weightPerBag.toStringAsFixed(3)} kg',
                                        ),
                                        ReportField('Total Bags', '${li.totalBags}'),
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
