import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapToolsCountFormPage extends StatefulWidget {
  const ScrapToolsCountFormPage({super.key});

  @override
  State<ScrapToolsCountFormPage> createState() =>
      _ScrapToolsCountFormPageState();
}

class _ScrapToolsCountFormPageState extends State<ScrapToolsCountFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMachine;
  final _toolsGivenCtrl = TextEditingController();
  final _toolsAvailableCtrl = TextEditingController();

  double get _percentage {
    final given = int.tryParse(_toolsGivenCtrl.text) ?? 0;
    final available = int.tryParse(_toolsAvailableCtrl.text) ?? 0;
    if (given == 0) return 0;
    return (available / given) * 100;
  }

  @override
  void dispose() {
    _toolsGivenCtrl.dispose();
    _toolsAvailableCtrl.dispose();
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
        appBar: AppBar(title: const Text('New Tools Count Report')),
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
                items: ddp.scrapMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v),
                validator: (v) => v == null ? 'Select a machine' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _toolsGivenCtrl,
                decoration: const InputDecoration(
                  labelText: 'Total Number of Tools Given',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                    (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Enter a number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _toolsAvailableCtrl,
                decoration: const InputDecoration(
                  labelText: 'Total Number of Tools Available',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                    (int.tryParse(v ?? '') ?? 0) < 0 ? 'Enter a number' : null,
              ),
              const SizedBox(height: 16),
              AutoCalculatedField(
                label: 'Percentage of Tools Available',
                value: '${_percentage.toStringAsFixed(1)}%',
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

    final given = int.parse(_toolsGivenCtrl.text);
    final available = int.parse(_toolsAvailableCtrl.text);

    final report = ScrapToolsCountReport(
      date: _selectedDate,
      machineNumber: _selectedMachine!,
      totalToolsGiven: given,
      totalToolsAvailable: available,
      percentageAvailable: _percentage,
      createdBy: '', // Set from auth
    );

    context.read<ScrapRegrindBloc>().add(SubmitScrapToolsCountReport(report));
  }
}
