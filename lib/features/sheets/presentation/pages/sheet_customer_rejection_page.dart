import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/sheet_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetCustomerRejectionPage extends StatefulWidget {
  final String machineId;
  const SheetCustomerRejectionPage({super.key, required this.machineId});

  @override
  State<SheetCustomerRejectionPage> createState() =>
      _SheetCustomerRejectionPageState();
}

class _SheetCustomerRejectionPageState
    extends State<SheetCustomerRejectionPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _rejectionDate = DateTime.now();
  DateTime _productionDate = DateTime.now();
  late String _selectedMachine;
  String? _shift;
  final List<_RejectionLineItem> _items = [];

  @override
  void initState() {
    super.initState();
    _selectedMachine = widget.machineId.isNotEmpty
        ? widget.machineId
        : ddp.sheetMachines.first;
    context.read<SheetReportsBloc>().add(
      LoadSheetCustomerRejectionReports(machineNumber: _selectedMachine),
    );
  }

  double _sqft(_RejectionLineItem item) {
    final l = double.tryParse(item.lengthCtrl.text) ?? 0;
    final w = double.tryParse(item.widthCtrl.text) ?? 0;
    return Calculations.sheetSqft(l, w);
  }

  double _ppw(_RejectionLineItem item) {
    final sqft = _sqft(item);
    if (item.thickness == null || item.density == null) return 0;
    if (item.density == 'Others') {
      final manual = double.tryParse(item.manualWeightCtrl.text) ?? 0;
      return Calculations.sheetPerPieceWeight(sqft, manual);
    }
    final wpsqft = ddp.sheetWeights[item.thickness]?[item.density];
    if (wpsqft == null) return 0;
    return Calculations.sheetPerPieceWeight(sqft, wpsqft);
  }

  double get _totalRejectedRunningFeet => _items.fold(0.0, (s, item) {
    final l = double.tryParse(item.lengthCtrl.text) ?? 0;
    final qty = int.tryParse(item.quantityCtrl.text) ?? 0;
    return s + Calculations.totalRunningFeet(l, qty);
  });

  int get _totalQty =>
      _items.fold(0, (s, i) => s + (int.tryParse(i.quantityCtrl.text) ?? 0));

  double get _totalWeight => _items.fold(0.0, (s, i) {
    final qty = int.tryParse(i.quantityCtrl.text) ?? 0;
    return s + qty * _ppw(i);
  });

  void _addItem() => setState(() => _items.add(_RejectionLineItem()));

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Customer Rejection')),
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
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SectionHeader(title: 'Customer Rejection Report'),
              Card(
                child: ListTile(
                  title: const Text('Rejection Date'),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(_rejectionDate),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _rejectionDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => _rejectionDate = picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  title: const Text('Original Production Date'),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(_productionDate),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _productionDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => _productionDate = picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedMachine,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: ddp.sheetMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _shift,
                decoration: const InputDecoration(labelText: 'Shift'),
                items: ddp.shifts
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _shift = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Rejected Items'),
              ...List.generate(_items.length, (index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Item ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeItem(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppTheme.errorRed,
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: item.thickness,
                          decoration: const InputDecoration(
                            labelText: 'Thickness',
                          ),
                          items: ddp.sheetThicknesses
                              .map(
                                (t) =>
                                    DropdownMenuItem(value: t, child: Text(t)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.thickness = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: item.density,
                          decoration: const InputDecoration(
                            labelText: 'Density',
                          ),
                          items: ddp.sheetDensities
                              .map(
                                (d) =>
                                    DropdownMenuItem(value: d, child: Text(d)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.density = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        if (item.density == 'Others') ...[
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: item.manualWeightCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Weight per SQFT (kg)',
                            ),
                            validator: (v) =>
                                Validators.positiveNumber(v, 'Weight'),
                            onChanged: (_) => setState(() {}),
                          ),
                        ],
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: item.color,
                          decoration: const InputDecoration(labelText: 'Color'),
                          items: ddp.sheetColors
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.color = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: item.lengthCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Length (inches)',
                          ),
                          validator: (v) =>
                              Validators.positiveNumber(v, 'Length'),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: item.widthCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Width (inches)',
                          ),
                          validator: (v) =>
                              Validators.positiveNumber(v, 'Width'),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: item.quantityCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                          ),
                          validator: (v) =>
                              Validators.positiveInteger(v, 'Quantity'),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        AutoCalculatedField(
                          label: 'SQFT',
                          value: _sqft(item).toStringAsFixed(3),
                        ),
                        const SizedBox(height: 8),
                        AutoCalculatedField(
                          label: 'Per Piece Weight',
                          value: '${_ppw(item).toStringAsFixed(3)} kg',
                        ),
                        const SizedBox(height: 8),
                        AutoCalculatedField(
                          label: 'Total Running Feet',
                          value:
                              '${Calculations.totalRunningFeet(double.tryParse(item.lengthCtrl.text) ?? 0, int.tryParse(item.quantityCtrl.text) ?? 0).toStringAsFixed(3)} ft',
                        ),
                      ],
                    ),
                  ),
                );
              }),
              OutlinedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Rejected Item'),
              ),
              const SizedBox(height: 24),
              AutoCalculatedField(
                label: 'Total Rejected Quantity',
                value: '$_totalQty pieces',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Total Rejected Weight',
                value: '${_totalWeight.toStringAsFixed(3)} kg',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Total Rejected Running Feet',
                value: '${_totalRejectedRunningFeet.toStringAsFixed(3)} ft',
              ),
              const SizedBox(height: 32),
              BlocBuilder<SheetReportsBloc, SheetReportsState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: state is SheetReportsSubmitting
                      ? null
                      : _submitReport,
                  child: state is SheetReportsSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReport() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_shift == null || _items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _items.isEmpty
                ? 'Add at least one rejected item'
                : 'Please select a shift',
          ),
        ),
      );
      return;
    }

    final rejectedItems = _items.map((item) {
      final l = double.parse(item.lengthCtrl.text);
      final w = double.parse(item.widthCtrl.text);
      final qty = int.parse(item.quantityCtrl.text);
      final sqft = Calculations.sheetSqft(l, w);
      final ppw = _ppw(item);
      return SheetProductionLineItem(
        thickness: item.thickness!,
        density: item.density!,
        color: item.color!,
        length: l,
        width: w,
        quantity: qty,
        sqft: sqft,
        perPieceWeight: ppw,
        totalWeight: Calculations.totalWeight(qty, ppw),
        totalRunningFeet: Calculations.totalRunningFeet(l, qty),
        manualWeightPerSqft: item.density == 'Others'
            ? double.tryParse(item.manualWeightCtrl.text)
            : null,
      );
    }).toList();

    final report = SheetCustomerRejectionReport(
      originalProductionDate: _productionDate,
      machineNumber: _selectedMachine,
      shift: _shift!,
      rejectedItems: rejectedItems,
      totalRejectedRunningFeet: _totalRejectedRunningFeet,
      createdBy: '',
    );
    context.read<SheetReportsBloc>().add(
      SubmitSheetCustomerRejectionReport(report),
    );
  }
}

class _RejectionLineItem {
  String? thickness;
  String? density;
  String? color;
  final lengthCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final manualWeightCtrl = TextEditingController();

  void dispose() {
    lengthCtrl.dispose();
    widthCtrl.dispose();
    quantityCtrl.dispose();
    manualWeightCtrl.dispose();
  }
}
