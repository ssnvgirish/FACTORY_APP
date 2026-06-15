import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/theme/app_theme.dart';
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
  final TextEditingController _ratingController = TextEditingController();

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
    _ratingController.dispose();
    super.dispose();
  }

  int get _totalScore => int.tryParse(_ratingController.text) ?? 0;

  double get _percentage => Calculations.healthPercentage(_totalScore, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Machine Health')),
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
            const SectionHeader(title: 'Health / Maintenance Report'),
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
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
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
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (v) => setState(() {
                _selectedMaintenanceItem = v;
                _ratingController.clear();
              }),
              validator: (v) => v == null ? 'Select a maintenance item' : null,
            ),
            if (_selectedMaintenanceItem != null) ...[
              const SizedBox(height: 16),
              const SectionHeader(title: 'Health Rating (1 = Low, 10 = Good)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _selectedMaintenanceItem!,
                  helperText: '1 = Poor, 10 = Excellent',
                ),
                validator: (v) => Validators.integerRange(
                  v,
                  1,
                  10,
                  _selectedMaintenanceItem!,
                ),
                onChanged: (_) => setState(() {}),
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    _selectedMaintenanceItem != null) {
                  final ratings = [
                    HealthRatingItem(
                      item: _selectedMaintenanceItem!,
                      rating: _totalScore,
                    ),
                  ];
                  final report = MachineHealthReport(
                    date: _selectedDate,
                    machineNumber: _selectedMachine,
                    shift: _shift,
                    ratings: ratings,
                    totalScore: _totalScore,
                    percentage: _percentage,
                    createdBy: '',
                  );
                  context.read<SheetReportsBloc>().add(
                    SubmitSheetHealthReport(report),
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
