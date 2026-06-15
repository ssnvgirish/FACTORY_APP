import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/sheet_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetPackingReportPage extends StatefulWidget {
  final String machineId;
  const SheetPackingReportPage({super.key, required this.machineId});

  @override
  State<SheetPackingReportPage> createState() => _SheetPackingReportPageState();
}

class _SheetPackingReportPageState extends State<SheetPackingReportPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String _shift = ddp.shifts.first;
  late String _selectedMachine;
  final List<_SheetPackingLineForm> _lines = [];

  @override
  void initState() {
    super.initState();
    _selectedMachine = widget.machineId.isNotEmpty
        ? widget.machineId
        : ddp.sheetMachines.first;
    context.read<SheetReportsBloc>().add(
      LoadSheetPackingReports(machineNumber: _selectedMachine),
    );
  }

  void _addLine() {
    setState(() => _lines.add(_SheetPackingLineForm()));
  }

  void _removeLine(int i) {
    setState(() {
      _lines[i].dispose();
      _lines.removeAt(i);
    });
  }

  int get _totalProduced => _lines.fold(
    0,
    (sum, l) => sum + (int.tryParse(l.producedCtrl.text) ?? 0),
  );

  int get _totalPacked =>
      _lines.fold(0, (sum, l) => sum + (int.tryParse(l.packedCtrl.text) ?? 0));

  int get _totalRejected => _lines.fold(
    0,
    (sum, l) => sum + (int.tryParse(l.rejectedCtrl.text) ?? 0),
  );

  double get _qualityAcceptance {
    if (_totalProduced == 0) return 0;
    return Calculations.qualityAcceptancePercentage(
      _totalProduced.toDouble(),
      _totalRejected.toDouble(),
    );
  }

  double get _packingEfficiency {
    if (_totalProduced == 0) return 0;
    return Calculations.packingEfficiency(_totalProduced, _totalPacked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Packing Report')),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader(title: 'Shift Details'),
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
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
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
                const SectionHeader(title: 'Packing Lines'),
                ..._lines.asMap().entries.map(
                  (e) => _buildLineCard(e.key, e.value),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _addLine,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Packing Line'),
                ),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Summary'),
                AutoCalculatedField(
                  label: 'Total Produced',
                  value: _totalProduced.toString(),
                ),
                AutoCalculatedField(
                  label: 'Total Packed',
                  value: _totalPacked.toString(),
                ),
                AutoCalculatedField(
                  label: 'Total Rejected',
                  value: _totalRejected.toString(),
                ),
                const SizedBox(height: 8),
                AutoCalculatedField(
                  label: 'Quality Acceptance (d)',
                  value: '${_qualityAcceptance.toStringAsFixed(2)}%',
                ),
                AutoCalculatedField(
                  label: 'Packing Efficiency (e)',
                  value: '${_packingEfficiency.toStringAsFixed(2)}%',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _lines.isNotEmpty) {
                      final report = SheetShiftPackingReport(
                        date: _selectedDate,
                        machineNumber: _selectedMachine,
                        shift: _shift,
                        lineItems: [],
                        totalRejectedRunningFeet: _totalRejected.toDouble(),
                        qualityAcceptancePercentage: _qualityAcceptance,
                        packingEfficiency: _packingEfficiency,
                        createdBy: '',
                      );
                      context.read<SheetReportsBloc>().add(
                        SubmitSheetPackingReport(report),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineCard(int index, _SheetPackingLineForm line) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Line ${index + 1}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () => _removeLine(index),
                ),
              ],
            ),
            TextFormField(
              controller: line.producedCtrl,
              decoration: const InputDecoration(labelText: 'Produced Qty'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              validator: (v) =>
                  (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: line.packedCtrl,
              decoration: const InputDecoration(labelText: 'Packed Qty'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: line.onlySandingCtrl,
              decoration: const InputDecoration(labelText: 'Only Sanding'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: line.sandingAndPackedCtrl,
              decoration: const InputDecoration(labelText: 'Sanding & Packed'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: line.rejectedCtrl,
              decoration: const InputDecoration(labelText: 'Rejected Qty'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetPackingLineForm {
  final producedCtrl = TextEditingController();
  final packedCtrl = TextEditingController();
  final onlySandingCtrl = TextEditingController();
  final sandingAndPackedCtrl = TextEditingController();
  final rejectedCtrl = TextEditingController();

  void dispose() {
    producedCtrl.dispose();
    packedCtrl.dispose();
    onlySandingCtrl.dispose();
    sandingAndPackedCtrl.dispose();
    rejectedCtrl.dispose();
  }
}
