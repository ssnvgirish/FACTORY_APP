import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetToolsCountPage extends StatefulWidget {
  final String machineId;
  const SheetToolsCountPage({super.key, required this.machineId});

  @override
  State<SheetToolsCountPage> createState() => _SheetToolsCountPageState();
}

class _SheetToolsCountPageState extends State<SheetToolsCountPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  late String _selectedMachine;
  final _toolsGivenCtrl = TextEditingController();
  final _toolsAvailableCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMachine = widget.machineId.isNotEmpty
        ? widget.machineId
        : ddp.sheetMachines.first;
    context.read<SheetReportsBloc>().add(
      LoadSheetToolsCountReports(machineNumber: _selectedMachine),
    );
  }

  @override
  void dispose() {
    _toolsGivenCtrl.dispose();
    _toolsAvailableCtrl.dispose();
    super.dispose();
  }

  double get _percentage {
    final given = int.tryParse(_toolsGivenCtrl.text) ?? 0;
    final available = int.tryParse(_toolsAvailableCtrl.text) ?? 0;
    if (given == 0) return 0;
    return (available / given) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Tools Count')),
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
            debugPrint('SheetReportsError: ${state.message}');
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Tools Count Report'),
            Card(
              child: ListTile(
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
                  if (picked != null) setState(() => _selectedDate = picked);
                },
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedMachine,
              decoration: const InputDecoration(labelText: 'Machine'),
              items: ddp.sheetMachines
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedMachine = v!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _toolsGivenCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Number of Tools Given',
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) =>
                  (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Enter a number' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _toolsAvailableCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Number of Tools Available',
              ),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final given = int.parse(_toolsGivenCtrl.text);
                  final available = int.parse(_toolsAvailableCtrl.text);
                  final report = ToolsCountReport(
                    date: _selectedDate,
                    machineNumber: _selectedMachine,
                    totalToolsGiven: given,
                    totalToolsAvailable: available,
                    percentageAvailable: _percentage,
                    createdBy: '',
                  );
                  context.read<SheetReportsBloc>().add(
                    SubmitSheetToolsCountReport(report),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
