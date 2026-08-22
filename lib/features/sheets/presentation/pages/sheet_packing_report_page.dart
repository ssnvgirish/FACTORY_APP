import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
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
  DateTime _selectedDate = DateTime.now();
  String? _shift;
  String? _selectedMachine;
  List<_SheetPackingLineForm> _lines = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _selectedMachine = widget.machineId.isNotEmpty ? widget.machineId : null;
  }

  void _loadProductionData() {
    if (_selectedMachine == null || _shift == null) return;
    context.read<SheetReportsBloc>().add(
      LoadSheetProductionDetailsForShift(
        machineNumber: _selectedMachine!,
        date: _selectedDate,
        shift: _shift!,
      ),
    );
  }

  int get _totalProduced =>
      _lines.fold(0, (sum, l) => sum + l.productionQuantity);

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

  void _submit() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    if (_selectedMachine == null || _shift == null || _lines.isEmpty) return;

    final items = _lines.map((l) {
      final packed = int.tryParse(l.packedCtrl.text) ?? 0;
      final rejected = int.tryParse(l.rejectedCtrl.text) ?? 0;
      final onlySanding = int.tryParse(l.onlySandingCtrl.text) ?? 0;
      final sandingAndPacked = int.tryParse(l.sandingAndPackedCtrl.text) ?? 0;
      return SheetPackingLineItem(
        thickness: l.thickness,
        density: l.density,
        color: l.color,
        length: l.length,
        width: l.width,
        productionQuantity: l.productionQuantity,
        perPieceWeight: l.perPieceWeight,
        runningFeetPerItem: l.runningFeetPerItem,
        packed: packed,
        onlySanding: onlySanding,
        sandingAndPacked: sandingAndPacked,
        rejectedQuality: rejected,
      );
    }).toList();

    final totalRejectedFeet = items.fold<double>(
      0,
      (s, i) => s + i.rejectedRunningFeet,
    );

    context.read<SheetReportsBloc>().add(
      SubmitSheetPackingReport(
        SheetShiftPackingReport(
          date: _selectedDate,
          machineNumber: _selectedMachine!,
          shift: _shift!,
          lineItems: items,
          totalRejectedRunningFeet: totalRejectedFeet,
          qualityAcceptancePercentage: _qualityAcceptance,
          packingEfficiency: _packingEfficiency,
          createdBy: authState.user.uid,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Packing Report')),
      body: BlocListener<SheetReportsBloc, SheetReportsState>(
        listener: (context, state) {
          if (state is SheetProductionDetailsForShiftLoaded) {
            setState(() {
              _loaded = true;
              for (final l in _lines) {
                l.dispose();
              }
              _lines = state.report == null
                  ? []
                  : state.report!.lineItems
                        .map(
                          (li) => _SheetPackingLineForm(
                            thickness: li.thickness,
                            density: li.density,
                            color: li.color,
                            length: li.length,
                            width: li.width,
                            productionQuantity: li.quantity,
                            perPieceWeight: li.perPieceWeight,
                            runningFeetPerItem: Calculations.totalRunningFeet(
                              li.length,
                              1,
                            ),
                          ),
                        )
                        .toList();
            });
          }
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
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
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
                    setState(() {
                      _selectedDate = picked;
                      _loaded = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedMachine,
              decoration: const InputDecoration(labelText: 'Machine Number'),
              items: ddp.sheetMachines
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() {
                _selectedMachine = v;
                _loaded = false;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _shift,
              decoration: const InputDecoration(labelText: 'Shift'),
              items: ddp.shifts
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() {
                _shift = v;
                _loaded = false;
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadProductionData,
              icon: const Icon(Icons.download),
              label: const Text('Load Production Data'),
            ),
            const SizedBox(height: 24),
            if (_loaded && _lines.isEmpty)
              const EmptyStateWidget(
                message: 'No production data found for this shift',
              ),
            if (_loaded && _lines.isNotEmpty) ...[
              const SectionHeader(title: 'Classify Production'),
              ...List.generate(_lines.length, (index) {
                final line = _lines[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${line.thickness} — ${line.density} — ${line.color}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'L: ${line.length}in × W: ${line.width}in | Qty: ${line.productionQuantity}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: line.packedCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Packed',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: line.onlySandingCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Only Sanding',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: line.sandingAndPackedCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Sanding & Packed',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: line.rejectedCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Rejected (Quality Issue)',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
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
                onPressed: _submit,
                child: const Text('Submit Packing Report'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SheetPackingLineForm {
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int productionQuantity;
  final double perPieceWeight;
  final double runningFeetPerItem;
  final packedCtrl = TextEditingController();
  final onlySandingCtrl = TextEditingController();
  final sandingAndPackedCtrl = TextEditingController();
  final rejectedCtrl = TextEditingController();

  _SheetPackingLineForm({
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.runningFeetPerItem,
  });

  void dispose() {
    packedCtrl.dispose();
    onlySandingCtrl.dispose();
    sandingAndPackedCtrl.dispose();
    rejectedCtrl.dispose();
  }
}
