import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapWritingEfficiencyPage extends StatelessWidget {
  const ScrapWritingEfficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Report Writing Efficiency')),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ScrapRegrindState state) {
    if (state is ScrapRegrindLoading) return const LoadingWidget();
    if (state is ScrapWritingEfficiencyLoaded) {
      return PaginatedListView(
        items: state.records,
        onRefresh: () async {
          context.read<ScrapRegrindBloc>().add(LoadScrapWritingEfficiency());
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
      context.read<ScrapRegrindBloc>().add(LoadScrapWritingEfficiency());
    });
    return const LoadingWidget();
  }
}
