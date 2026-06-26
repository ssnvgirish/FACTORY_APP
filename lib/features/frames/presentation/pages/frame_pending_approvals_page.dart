import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/frame_reports_bloc.dart';

class FramePendingApprovalsPage extends StatelessWidget {
  const FramePendingApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Report History')),
      body: BlocBuilder<FrameReportsBloc, FrameReportsState>(
        builder: (context, state) {
          if (state is FrameReportsLoading) return const LoadingWidget();
          if (state is PendingApprovalsLoaded) {
            return PaginatedListView(
              items: state.reports,
              onRefresh: () async {
                context.read<FrameReportsBloc>().add(LoadPendingApprovals());
              },
              emptyMessage: 'No reports found',
              emptyIcon: Icons.check_circle_outline,
              itemBuilder: (context, report, index) {
                return ReportCard(
                  title: '${report.machineNumber} — ${report.shift}',
                  subtitle:
                      '${DateFormat('dd MMM yyyy').format(report.date)} — ${report.entries.length} item(s)',
                  trailing:
                      '${report.totalMaintenanceDurationHours.toStringAsFixed(1)}h',
                  statusColor: AppTheme.pendingBlue,
                );
              },
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<FrameReportsBloc>().add(LoadPendingApprovals());
          });
          return const LoadingWidget();
        },
      ),
    );
  }
}
