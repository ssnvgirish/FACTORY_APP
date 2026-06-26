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

  DateTime? _startTime;
  DateTime? _endTime;
  final _personCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  double get _durationHours {
    if (_startTime == null || _endTime == null) return 0;
    return Calculations.maintenanceDurationHours(_startTime!, _endTime!);
  }

  @override
  void dispose() {
    _personCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMaintenanceItem == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a maintenance item')),
      );
      return;
    }
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select start and end times')),
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

    final entry = FrameMaintenanceEntry(
      maintenanceItem: _selectedMaintenanceItem!,
      startTime: _startTime!,
      endTime: _endTime!,
      personDoingMaintenance: _personCtrl.text,
      description: _descriptionCtrl.text,
      durationHours: _durationHours,
    );

    context.read<FrameReportsBloc>().add(
      SubmitMachineHealthReport(
        MachineHealthReport(
          date: _date,
          machineNumber: _machineNumber!,
          shift: _shift!,
          entries: [entry],
          totalMaintenanceDurationHours: _durationHours,
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Machine Health Report')),
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
                  _startTime = null;
                  _endTime = null;
                  _personCtrl.clear();
                  _descriptionCtrl.clear();
                }),
                validator: (v) =>
                    v == null ? 'Select a maintenance item' : null,
              ),
              if (_selectedMaintenanceItem != null) ...[
                const SizedBox(height: 16),
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                dense: true,
                                title: const Text('Start Time'),
                                subtitle: Text(
                                  _startTime != null
                                      ? DateFormat('HH:mm').format(_startTime!)
                                      : 'Select',
                                ),
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _startTime = DateTime(
                                        _date.year,
                                        _date.month,
                                        _date.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                title: const Text('End Time'),
                                subtitle: Text(
                                  _endTime != null
                                      ? DateFormat('HH:mm').format(_endTime!)
                                      : 'Select',
                                ),
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _endTime = DateTime(
                                        _date.year,
                                        _date.month,
                                        _date.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _personCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Person Doing Maintenance',
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Enter person name'
                              : null,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Description of Maintenance',
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        AutoCalculatedField(
                          label: 'Duration',
                          value: '${_durationHours.toStringAsFixed(2)} hours',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              AutoCalculatedField(
                label: 'Total Maintenance Duration',
                value: '${_durationHours.toStringAsFixed(2)} hours',
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
