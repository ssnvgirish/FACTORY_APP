import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapSalaryPage extends StatefulWidget {
  final String? operatorId;

  const ScrapSalaryPage({super.key, this.operatorId});

  @override
  State<ScrapSalaryPage> createState() => _ScrapSalaryPageState();
}

class _ScrapSalaryPageState extends State<ScrapSalaryPage> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    if (widget.operatorId != null) _load();
  }

  void _load() {
    if (widget.operatorId == null) return;
    context.read<ScrapRegrindBloc>().add(
      LoadScrapSalaryCalculation(
        operatorId: widget.operatorId!,
        year: _selectedYear,
        month: _selectedMonth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrap Salary Multiplier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: _pickMonth,
          ),
        ],
      ),
      body: BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
        builder: (context, state) {
          if (state is ScrapRegrindLoading) return const LoadingWidget();
          if (state is ScrapRegrindError) {
            return EmptyStateWidget(
              message: state.message,
              icon: Icons.error_outline,
              actionLabel: 'Retry',
              onAction: _load,
            );
          }
          if (state is ScrapSalaryCalculationLoaded) {
            return _buildCalculation(state.calculation);
          }
          return const EmptyStateWidget(
            message: 'Select an operator to view salary calculation',
          );
        },
      ),
    );
  }

  Widget _buildCalculation(ScrapSalaryCalculation calc) {
    final monthName = DateFormat(
      'MMMM yyyy',
    ).format(DateTime(calc.year, calc.month));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          monthName,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          calc.operatorName,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Variables
        _VariableRow(
          label: 'Machine Cleaning (a)',
          value: calc.a,
          weightage: calc.wA,
        ),
        _VariableRow(
          label: 'Tools Count (b)',
          value: calc.b,
          weightage: calc.wB,
        ),
        _VariableRow(
          label: 'Production Efficiency (e)',
          value: calc.e,
          weightage: calc.wE,
        ),
        _VariableRow(
          label: 'Report Writing (f)',
          value: calc.f,
          weightage: calc.wF,
        ),
        _VariableRow(
          label: 'Scrap Quality (g)',
          value: calc.g,
          weightage: calc.wG,
        ),
        const Divider(height: 32),

        // Results
        _ResultCard(
          label: 'Salary Multiplier',
          value: calc.multiplier.toStringAsFixed(4),
        ),
        const SizedBox(height: 8),
        _ResultCard(
          label: 'Fixed Salary',
          value: '₹ ${calc.fixedSalary.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),
        _ResultCard(
          label: 'Calculated Salary',
          value: '₹ ${calc.calculatedSalary.toStringAsFixed(2)}',
          highlight: true,
        ),
      ],
    );
  }

  void _pickMonth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(_selectedYear, _selectedMonth),
      firstDate: DateTime(2020),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        _selectedYear = picked.year;
        _selectedMonth = picked.month;
      });
      _load();
    }
  }
}

class _VariableRow extends StatelessWidget {
  final String label;
  final double value;
  final double weightage;

  const _VariableRow({
    required this.label,
    required this.value,
    required this.weightage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label)),
          Expanded(
            child: Text(
              '${value.toStringAsFixed(1)}%',
              textAlign: TextAlign.right,
              style: GoogleFonts.sourceCodePro(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '×${weightage.toStringAsFixed(0)}%',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ResultCard({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: highlight
            ? AppTheme.accentAmber.withValues(alpha: 0.15)
            : AppTheme.autoFieldBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlight ? AppTheme.accentAmber : AppTheme.borderGrey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: GoogleFonts.sourceCodePro(
              fontSize: highlight ? 18 : 16,
              fontWeight: FontWeight.w600,
              color: highlight ? AppTheme.accentAmber : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
