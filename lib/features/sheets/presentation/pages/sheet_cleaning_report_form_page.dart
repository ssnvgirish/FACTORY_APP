import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetCleaningReportFormPage extends StatefulWidget {
  const SheetCleaningReportFormPage({super.key});
  @override
  State<SheetCleaningReportFormPage> createState() =>
      _SheetCleaningReportFormPageState();
}

class _SheetCleaningReportFormPageState
    extends State<SheetCleaningReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machine;
  final _mc = TextEditingController(),
      _gc = TextEditingController(),
      _mo = TextEditingController();

  int get _total =>
      (int.tryParse(_mc.text) ?? 0) +
      (int.tryParse(_gc.text) ?? 0) +
      (int.tryParse(_mo.text) ?? 0);
  double get _pct => Calculations.cleaningPercentage(_total);

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _machine == null) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;
    final auth = context.read<AuthBloc>().state;
    if (auth is! AuthAuthenticated) return;
    context.read<SheetReportsBloc>().add(
      SubmitSheetCleaningReport(
        MachineCleaningReport(
          date: _date,
          machineNumber: _machine!,
          machineCondition: int.parse(_mc.text),
          groundCondition: int.parse(_gc.text),
          mouldCondition: int.parse(_mo.text),
          totalScore: _total,
          percentage: _pct,
          createdBy: auth.user.uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SheetReportsBloc, SheetReportsState>(
      listener: (context, state) {
        if (state is SheetReportsSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.successGreen,
            ),
          );
          Navigator.pop(context);
        }
        if (state is SheetReportsError) {
          debugPrint('SheetReportsError: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Sheet Cleaning Report')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Date'),
                    subtitle: Text(DateFormat('dd MMM yyyy').format(_date)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final p = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (p != null) setState(() => _date = p);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _machine,
                  decoration: const InputDecoration(
                    labelText: 'Machine Number',
                  ),
                  items: ddp.sheetMachines
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setState(() => _machine = v),
                  validator: (v) => v == null ? 'Select machine' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mc,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Machine Condition (1-10)',
                  ),
                  validator: (v) => Validators.integerRange(v, 1, 10),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _gc,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ground Condition (1-10)',
                  ),
                  validator: (v) => Validators.integerRange(v, 1, 10),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mo,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Mould & Machinery Parts (1-10)',
                  ),
                  validator: (v) => Validators.integerRange(v, 1, 10),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 24),
                AutoCalculatedField(
                  label: 'Total Score',
                  value: '$_total / 30',
                ),
                const SizedBox(height: 12),
                AutoCalculatedField(
                  label: 'Percentage',
                  value: '${_pct.toStringAsFixed(2)}%',
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
