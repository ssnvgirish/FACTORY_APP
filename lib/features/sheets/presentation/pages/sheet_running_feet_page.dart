import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetRunningFeetPage extends StatelessWidget {
  final String machineId;
  const SheetRunningFeetPage({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Running Feet Report')),
      body: BlocBuilder<SheetReportsBloc, SheetReportsState>(
        builder: (context, state) {
          if (state is SheetReportsLoading) return const LoadingWidget();
          if (state is SheetRunningFeetReportsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<SheetReportsBloc>().add(
                  LoadSheetRunningFeetReports(),
                );
              },
              emptyMessage:
                  'No running feet data yet.\nGenerated from production details.',
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, r, i) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${r.date.day}/${r.date.month}/${r.date.year}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const Spacer(),
                            Chip(label: Text(r.shift)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _StatColumn(
                              label: 'Production Ft',
                              value:
                                  '${r.productionRunningFeet.toStringAsFixed(1)} ft',
                            ),
                            _StatColumn(
                              label: 'Target Ft',
                              value:
                                  '${r.targetRunningFeet.toStringAsFixed(1)} ft',
                            ),
                            _StatColumn(
                              label: 'Efficiency',
                              value:
                                  '${r.efficiencyPercentage.toStringAsFixed(1)}%',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<SheetReportsBloc>().add(LoadSheetRunningFeetReports());
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.sourceCodePro(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
