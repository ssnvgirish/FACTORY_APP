import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameWritingEfficiencyPage extends StatelessWidget {
  const FrameWritingEfficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Writing Efficiency')),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is FrameWritingEfficiencyLoaded) {
            return PaginatedListView(
              items: state.records,
              onRefresh: () async {
                context.read<FrameReportsBloc>().add(
                  LoadFrameWritingEfficiency(),
                );
              },
              emptyMessage: 'No writing efficiency records yet',
              itemBuilder: (context, record, index) {
                return ReportCard(
                  title: record.machineNumber,
                  subtitle:
                      '${DateFormat('dd MMM yyyy').format(record.date)} — ${record.shift}',
                  trailing: '${record.score}/5',
                  statusColor: record.score >= 4
                      ? AppTheme.successGreen
                      : record.score >= 2
                      ? AppTheme.warningYellow
                      : AppTheme.errorRed,
                );
              },
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<FrameReportsBloc>().add(LoadFrameWritingEfficiency());
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
