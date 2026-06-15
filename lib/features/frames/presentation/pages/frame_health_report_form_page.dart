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

class FrameHealthReportFormPage extends StatefulWidget {
  const FrameHealthReportFormPage({super.key});

  @override
  State<FrameHealthReportFormPage> createState() =>
      _FrameHealthReportFormPageState();
}

class _FrameHealthReportFormPageState extends State<FrameHealthReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machineNumber;
  String? _shift;
  String? _selectedMaintenanceItem;
  final TextEditingController _ratingController = TextEditingController();

  @override
  void dispose() {
    _ratingController.dispose();
    super.dispose();
  }

  int get _totalScore => int.tryParse(_ratingController.text) ?? 0;

  double get _percentage => Calculations.healthPercentage(_totalScore, 1);

  void _submit() async {
    if (_machineNumber == null ||
        _shift == null ||
        _selectedMaintenanceItem == null ||
        _totalScore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
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

    final ratings = [
      HealthRatingItem(item: _selectedMaintenanceItem!, rating: _totalScore),
    ];

    context.read<FrameReportsBloc>().add(
      SubmitMachineHealthReport(
        MachineHealthReport(
          date: _date,
          machineNumber: _machineNumber!,
          shift: _shift!,
          ratings: ratings,
          totalScore: _totalScore,
          percentage: _percentage,
          createdBy: authState.user.uid,
          submittedAt: DateTime.now(),
        ),
      ),
    );
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
        appBar: AppBar(title: const Text('New Health Report')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
              DropdownButtonFormField<String>(
                initialValue: _machineNumber,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: ddp.frameMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _machineNumber = v),
                validator: (v) => v == null ? 'Select machine' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _shift,
                decoration: const InputDecoration(labelText: 'Shift'),
                items: ddp.shifts
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _shift = v),
                validator: (v) => v == null ? 'Select shift' : null,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Maintenance Item'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedMaintenanceItem,
                decoration: const InputDecoration(
                  labelText: 'Select Maintenance Item',
                ),
                items: ddp.maintenanceItems
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (v) => setState(() {
                  _selectedMaintenanceItem = v;
                  _ratingController.clear();
                }),
                validator: (v) =>
                    v == null ? 'Select a maintenance item' : null,
              ),
              if (_selectedMaintenanceItem != null) ...[
                const SizedBox(height: 16),
                const SectionHeader(
                  title: 'Health Rating (1 = Low, 10 = Good)',
                ),
                const SizedBox(height: 8),
                RatingBoxes(
                  label: _selectedMaintenanceItem!,
                  controller: _ratingController,
                  onChanged: () => setState(() {}),
                ),
              ],
              const SizedBox(height: 16),
              AutoCalculatedField(
                label: 'Total Score',
                value: '$_totalScore / 10',
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
                    onPressed: state is FrameReportsSubmitting ? null : _submit,
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
    );
  }
}
