import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetHealthReportPage extends StatefulWidget {
  final String machineId;
  const SheetHealthReportPage({super.key, required this.machineId});

  @override
  State<SheetHealthReportPage> createState() => _SheetHealthReportPageState();
}

class _SheetHealthReportPageState extends State<SheetHealthReportPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String _shift = ddp.shifts.first;
  late String _selectedMachine;
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
  void initState() {
    super.initState();
    _selectedMachine = widget.machineId.isNotEmpty
        ? widget.machineId
        : ddp.sheetMachines.first;
    context.read<SheetReportsBloc>().add(
      LoadSheetHealthReports(machineNumber: _selectedMachine),
    );
  }

  @override
  void dispose() {
    _personCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Machine Health Report')),
      body: BlocListener<SheetReportsBloc, SheetReportsState>(
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
        },
        child: BlocBuilder<SheetReportsBloc, SheetReportsState>(
          builder: (context, state) {
            if (state is SheetReportsLoading) return const LoadingWidget();
            return _buildForm();
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                  subtitle: const Text('Date'),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<String>(
                    initialValue: _shift,
                    decoration: const InputDecoration(labelText: 'Shift'),
                    items: ddp.shifts
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => _shift = v!),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Maintenance Item'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedMaintenanceItem,
            decoration: const InputDecoration(
              labelText: 'Select Maintenance Item',
            ),
            items: ddp.maintenanceItems
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (v) => setState(() {
              _selectedMaintenanceItem = v;
              _startTime = null;
              _endTime = null;
              _personCtrl.clear();
              _descriptionCtrl.clear();
            }),
            validator: (v) => v == null ? 'Select a maintenance item' : null,
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
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
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
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
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
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Enter person name' : null,
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
          BlocBuilder<SheetReportsBloc, SheetReportsState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state is SheetReportsSubmitting
                    ? null
                    : _submitReport,
                child: state is SheetReportsSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              );
            },
          ),
        ],
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

    final entry = FrameMaintenanceEntry(
      maintenanceItem: _selectedMaintenanceItem!,
      startTime: _startTime!,
      endTime: _endTime!,
      personDoingMaintenance: _personCtrl.text,
      description: _descriptionCtrl.text,
      durationHours: _durationHours,
    );

    final report = MachineHealthReport(
      date: _selectedDate,
      machineNumber: _selectedMachine,
      shift: _shift,
      entries: [entry],
      totalMaintenanceDurationHours: _durationHours,
      createdBy: '',
    );
    context.read<SheetReportsBloc>().add(SubmitSheetHealthReport(report));
  }
}
