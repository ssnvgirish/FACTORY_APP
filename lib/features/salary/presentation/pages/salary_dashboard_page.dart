import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/salary_entities.dart';
import '../bloc/salary_bloc.dart';

class SalaryDashboardPage extends StatefulWidget {
  final String? operatorId; // null means show all (for admin/manager)

  const SalaryDashboardPage({super.key, this.operatorId});

  @override
  State<SalaryDashboardPage> createState() => _SalaryDashboardPageState();
}

class _SalaryDashboardPageState extends State<SalaryDashboardPage> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    if (widget.operatorId != null) {
      context.read<SalaryBloc>().add(
        CalculateSalary(
          operatorId: widget.operatorId!,
          year: _selectedYear,
          month: _selectedMonth,
        ),
      );
    } else {
      context.read<SalaryBloc>().add(
        LoadMonthlyCalculations(year: _selectedYear, month: _selectedMonth),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _pickMonth(),
          ),
        ],
      ),
      body: BlocBuilder<SalaryBloc, SalaryState>(
        builder: (context, state) {
          if (state is SalaryLoading) return const LoadingWidget();
          if (state is SalaryError) {
            debugPrint('SalaryError: ${state.message}');
            return EmptyStateWidget(
              message: 'Something went wrong',
              icon: Icons.error_outline,
              actionLabel: 'Retry',
              onAction: _load,
            );
          }
          if (state is SalaryCalculated) {
            return _buildSingleCalculation(state.calculation);
          }
          if (state is SalaryMonthlyLoaded) {
            if (state.calculations.isEmpty) {
              return const EmptyStateWidget(
                message: 'No salary calculations for this month',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.calculations.length,
              itemBuilder: (context, i) =>
                  _SalaryCard(calculation: state.calculations[i]),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildSingleCalculation(SalaryCalculation calc) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Card(
            color: AppTheme.primaryNavy,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    calc.operatorName,
                    style: GoogleFonts.sourceSans3(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat(
                      'MMMM yyyy',
                    ).format(DateTime(calc.year, calc.month)),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '₹${calc.calculatedSalary.toStringAsFixed(2)}',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentAmber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Multiplier: ${calc.multiplier.toStringAsFixed(4)}',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'Fixed Salary: ₹${calc.fixedSalary.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Variable breakdown
          const SectionHeader(title: 'Variable Breakdown'),
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
            label: 'Production Efficiency (c)',
            value: calc.c,
            weightage: calc.wC,
          ),
          _VariableRow(
            label: 'Quality Acceptance (d)',
            value: calc.d,
            weightage: calc.wD,
          ),
          _VariableRow(
            label: 'Packing Efficiency (e)',
            value: calc.e,
            weightage: calc.wE,
          ),
          _VariableRow(
            label: 'Report Writing (f)',
            value: calc.f,
            weightage: calc.wF,
          ),

          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<SalaryBloc>().add(SaveSalaryCalculation(calc));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Salary calculation saved'),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('Save Calculation'),
          ),
        ],
      ),
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
    final multiplier = (value / 100) * (weightage / 100);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Expanded(
              child: Text(
                '${value.toStringAsFixed(1)}%',
                style: GoogleFonts.sourceCodePro(fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '×${weightage.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '=${multiplier.toStringAsFixed(4)}',
                style: GoogleFonts.sourceCodePro(
                  fontSize: 13,
                  color: AppTheme.primaryNavy,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalaryCard extends StatelessWidget {
  final SalaryCalculation calculation;

  const _SalaryCard({required this.calculation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          calculation.operatorName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          'Multiplier: ${calculation.multiplier.toStringAsFixed(4)} | Fixed: ₹${calculation.fixedSalary.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          '₹${calculation.calculatedSalary.toStringAsFixed(0)}',
          style: GoogleFonts.sourceCodePro(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
      ),
    );
  }
}
