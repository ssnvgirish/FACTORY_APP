import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/sheet_entities.dart';
import '../bloc/sheet_reports_bloc.dart';

class SheetProductionDetailsFormPage extends StatefulWidget {
  const SheetProductionDetailsFormPage({super.key});

  @override
  State<SheetProductionDetailsFormPage> createState() =>
      _SheetProductionDetailsFormPageState();
}

class _SheetProductionDetailsFormPageState
    extends State<SheetProductionDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machineNumber;
  String? _shift;
  final List<_SheetLineItemData> _items = [];

  int get _totalQty =>
      _items.fold(0, (s, i) => s + (int.tryParse(i.quantityCtrl.text) ?? 0));
  double get _totalWeight => _items.fold(0.0, (s, i) {
    final qty = int.tryParse(i.quantityCtrl.text) ?? 0;
    return s + qty * _ppw(i);
  });
  double get _totalRunFeet => _items.fold(0.0, (s, i) {
    final l = double.tryParse(i.lengthCtrl.text) ?? 0;
    final qty = int.tryParse(i.quantityCtrl.text) ?? 0;
    return s + Calculations.totalRunningFeet(l, qty);
  });

  double _sqft(_SheetLineItemData item) {
    final l = double.tryParse(item.lengthCtrl.text) ?? 0;
    final w = double.tryParse(item.widthCtrl.text) ?? 0;
    return Calculations.sheetSqft(l, w);
  }

  double _ppw(_SheetLineItemData item) {
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

  void _addItem() => setState(() => _items.add(_SheetLineItemData()));
  void _removeItem(int i) => setState(() {
    _items[i].dispose();
    _items.removeAt(i);
  });

  bool _needsTimeOfChange(int i) {
    if (i == 0) return false;
    final prev = _items[i - 1];
    final curr = _items[i];
    return curr.thickness != prev.thickness ||
        curr.density != prev.density ||
        curr.color != prev.color;
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null || _shift == null || _items.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final lineItems = _items.map((item) {
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
        timeOfChange: item.timeOfChange,
        manualWeightPerSqft: item.density == 'Others'
            ? double.tryParse(item.manualWeightCtrl.text)
            : null,
      );
    }).toList();

    context.read<SheetReportsBloc>().add(
      SubmitSheetProductionDetailsReport(
        SheetProductionDetailsReport(
          date: _date,
          machineNumber: _machineNumber!,
          shift: _shift!,
          lineItems: lineItems,
          totalQuantity: _totalQty,
          totalWeight: _totalWeight,
          totalRunningFeet: _totalRunFeet,
          createdBy: authState.user.uid,
          submittedAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SheetReportsBloc, SheetReportsState>(
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
      child: Scaffold(
        appBar: AppBar(title: const Text('New Sheet Production')),
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
                    final p = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (p != null) setState(() => _date = p);
                  },
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _machineNumber,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: ddp.sheetMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _machineNumber = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
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
              const SectionHeader(title: 'Production Line Items'),
              ...List.generate(_items.length, (index) {
                final item = _items[index];
                final showChange = _needsTimeOfChange(index);
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
                        if (showChange) ...[
                          const SizedBox(height: 12),
                          ListTile(
                            dense: true,
                            tileColor: AppTheme.warningYellow.withValues(
                              alpha: 0.1,
                            ),
                            leading: const Icon(
                              Icons.schedule,
                              color: AppTheme.warningYellow,
                            ),
                            title: const Text('Time of Change'),
                            subtitle: Text(
                              item.timeOfChange != null
                                  ? DateFormat(
                                      'hh:mm a',
                                    ).format(item.timeOfChange!)
                                  : 'Tap to set',
                            ),
                            onTap: () async {
                              final t = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (t != null) {
                                setState(
                                  () => item.timeOfChange = DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    t.hour,
                                    t.minute,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              OutlinedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Line Item'),
              ),
              const SizedBox(height: 24),
              AutoCalculatedField(
                label: 'Total Quantity (h)',
                value: '$_totalQty pieces',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Total Weight (k)',
                value: '${_totalWeight.toStringAsFixed(3)} kg',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Total Running Feet (l)',
                value: '${_totalRunFeet.toStringAsFixed(3)} ft',
              ),
              const SizedBox(height: 32),
              BlocBuilder<SheetReportsBloc, SheetReportsState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: state is SheetReportsSubmitting ? null : _submit,
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
}

class _SheetLineItemData {
  String? thickness;
  String? density;
  String? color;
  DateTime? timeOfChange;
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
