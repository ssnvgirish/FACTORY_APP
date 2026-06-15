import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameCleaningReportFormPage extends StatefulWidget {
  const FrameCleaningReportFormPage({super.key});

  @override
  State<FrameCleaningReportFormPage> createState() =>
      _FrameCleaningReportFormPageState();
}

class _FrameCleaningReportFormPageState
    extends State<FrameCleaningReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machineNumber;
  final _machineConditionCtrl = TextEditingController();
  final _groundConditionCtrl = TextEditingController();
  final _mouldConditionCtrl = TextEditingController();

  int get _totalScore {
    final m = int.tryParse(_machineConditionCtrl.text) ?? 0;
    final g = int.tryParse(_groundConditionCtrl.text) ?? 0;
    final mo = int.tryParse(_mouldConditionCtrl.text) ?? 0;
    return Calculations.cleaningTotalScore(m, g, mo);
  }

  double get _percentage => Calculations.cleaningPercentage(_totalScore);

  @override
  void dispose() {
    _machineConditionCtrl.dispose();
    _groundConditionCtrl.dispose();
    _mouldConditionCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a machine')));
      return;
    }
    if (_totalScore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all ratings')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final report = MachineCleaningReport(
      date: _date,
      machineNumber: _machineNumber!,
      machineCondition: int.parse(_machineConditionCtrl.text),
      groundCondition: int.parse(_groundConditionCtrl.text),
      mouldCondition: int.parse(_mouldConditionCtrl.text),
      totalScore: _totalScore,
      percentage: _percentage,
      createdBy: authState.user.uid,
    );

    context.read<FrameReportsBloc>().add(SubmitMachineCleaningReport(report));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FrameReportsBloc, FrameReportsState>(
      listener: (context, state) {
        if (state is FrameReportsSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.successGreen,
            ),
          );
          Navigator.pop(context);
          context.read<FrameReportsBloc>().add(LoadMachineCleaningReports());
        }
        if (state is FrameReportsError) {
          debugPrint('FrameReportsError: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Cleaning Report')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date picker
                Card(
                  child: ListTile(
                    title: const Text('Date'),
                    subtitle: Text(DateFormat('dd MMM yyyy').format(_date)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Machine number
                DropdownButtonFormField<String>(
                  initialValue: _machineNumber,
                  decoration: const InputDecoration(
                    labelText: 'Machine Number',
                  ),
                  items: ddp.frameMachines
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setState(() => _machineNumber = v),
                  validator: (v) => v == null ? 'Select machine' : null,
                ),
                const SizedBox(height: 16),

                // Machine Condition
                RatingBoxes(
                  label: 'Machine Condition',
                  controller: _machineConditionCtrl,
                  onChanged: () => setState(() {}),
                ),
                const SizedBox(height: 16),

                // Ground Condition
                RatingBoxes(
                  label: 'Ground Condition',
                  controller: _groundConditionCtrl,
                  onChanged: () => setState(() {}),
                ),
                const SizedBox(height: 16),

                // Mould Condition
                RatingBoxes(
                  label: 'Mould & Machinery Parts Condition',
                  controller: _mouldConditionCtrl,
                  onChanged: () => setState(() {}),
                ),
                const SizedBox(height: 24),

                // Auto fields
                AutoCalculatedField(
                  label: 'Total Score',
                  value: '$_totalScore / 30',
                ),
                const SizedBox(height: 12),
                AutoCalculatedField(
                  label: 'Percentage',
                  value: '${_percentage.toStringAsFixed(2)}%',
                ),
                const SizedBox(height: 32),

                BlocBuilder<FrameReportsBloc, FrameReportsState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is FrameReportsSubmitting
                          ? null
                          : _submit,
                      child: state is FrameReportsSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Submit Report'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
