import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapHealthReportFormPage extends StatefulWidget {
  const ScrapHealthReportFormPage({super.key});

  @override
  State<ScrapHealthReportFormPage> createState() =>
      _ScrapHealthReportFormPageState();
}

class _ScrapHealthReportFormPageState extends State<ScrapHealthReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMachine;
  String? _selectedShift;
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScrapRegrindBloc, ScrapRegrindState>(
      listener: (context, state) {
        if (state is ScrapRegrindSubmitted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        } else if (state is ScrapRegrindError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Machine Health Report')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                title: const Text('Date'),
                subtitle: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedMachine,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: AppConstants.scrapAllMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v),
                validator: (v) => v == null ? 'Select a machine' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedShift,
                decoration: const InputDecoration(labelText: 'Shift'),
                items: AppConstants.shifts
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedShift = v),
                validator: (v) => v == null ? 'Select a shift' : null,
              ),
              const SizedBox(height: 24),

              // Maintenance item dropdown
              const SectionHeader(title: 'Maintenance Item'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedMaintenanceItem,
                decoration: const InputDecoration(
                  labelText: 'Select Maintenance Item',
                ),
                items: AppConstants.scrapMaintenanceItems
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedMaintenanceItem = v),
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
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
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
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
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
              const SizedBox(height: 24),

              BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is ScrapRegrindSubmitting
                        ? null
                        : _submitReport,
                    child: state is ScrapRegrindSubmitting
                        ? const CircularProgressIndicator()
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

  void _submitReport() {
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

    final entry = ScrapMaintenanceEntry(
      maintenanceItem: _selectedMaintenanceItem!,
      startTime: _startTime!,
      endTime: _endTime!,
      personDoingMaintenance: _personCtrl.text,
      description: _descriptionCtrl.text,
      durationHours: _durationHours,
    );

    final report = ScrapMachineHealthReport(
      date: _selectedDate,
      machineNumber: _selectedMachine!,
      shift: _selectedShift!,
      entries: [entry],
      totalMaintenanceDurationHours: _durationHours,
      createdBy: '', // Set from auth
    );

    context.read<ScrapRegrindBloc>().add(SubmitScrapHealthReport(report));
  }
}
