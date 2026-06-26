import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapCleaningReportFormPage extends StatefulWidget {
  const ScrapCleaningReportFormPage({super.key});

  @override
  State<ScrapCleaningReportFormPage> createState() =>
      _ScrapCleaningReportFormPageState();
}

class _ScrapCleaningReportFormPageState
    extends State<ScrapCleaningReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMachine;
  int _machineCondition = 1;
  int _groundCondition = 1;

  int get _totalScore => _machineCondition + _groundCondition;
  double get _percentage => (_totalScore / 20) * 100;

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
        appBar: AppBar(title: const Text('New Cleaning Report')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Date picker
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

              // Machine dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedMachine,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: ddp.scrapMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v),
                validator: (v) => v == null ? 'Select a machine' : null,
              ),
              const SizedBox(height: 16),

              // Machine condition slider
              Text('Machine Condition: $_machineCondition / 10'),
              Slider(
                value: _machineCondition.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: _machineCondition.toString(),
                onChanged: (v) => setState(() => _machineCondition = v.round()),
              ),
              const SizedBox(height: 16),

              // Ground condition slider
              Text('Ground Condition: $_groundCondition / 10'),
              Slider(
                value: _groundCondition.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: _groundCondition.toString(),
                onChanged: (v) => setState(() => _groundCondition = v.round()),
              ),
              const SizedBox(height: 16),

              // Auto-calculated fields
              AutoCalculatedField(
                label: 'Total Score',
                value: '$_totalScore / 20',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Percentage',
                value: '${_percentage.toStringAsFixed(1)}%',
              ),
              const SizedBox(height: 24),

              // Submit
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

    final report = ScrapCleaningReport(
      date: _selectedDate,
      machineNumber: _selectedMachine!,
      machineCondition: _machineCondition,
      groundCondition: _groundCondition,
      totalScore: _totalScore,
      percentage: _percentage,
      createdBy: '', // Set from auth
    );

    context.read<ScrapRegrindBloc>().add(SubmitScrapCleaningReport(report));
  }
}
