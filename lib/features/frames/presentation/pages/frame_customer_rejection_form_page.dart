import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/calculations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameCustomerRejectionFormPage extends StatefulWidget {
  const FrameCustomerRejectionFormPage({super.key});

  @override
  State<FrameCustomerRejectionFormPage> createState() =>
      _FrameCustomerRejectionFormPageState();
}

class _FrameCustomerRejectionFormPageState
    extends State<FrameCustomerRejectionFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _productionDate = DateTime.now();
  DateTime _rejectionDate = DateTime.now();
  String? _machineNumber;
  String? _shift;
  final List<_RejectionLineItem> _items = [];

  Map<String, Map<String, double>> get _weightTable => ddp.frameWeights;

  double _totalRejectedWeight() {
    double total = 0;
    for (final item in _items) {
      final qty = int.tryParse(item.quantityCtrl.text) ?? 0;
      final length = double.tryParse(item.lengthCtrl.text) ?? 0;
      if (item.section == null || item.density == null) continue;
      double wpf = 0;
      if (item.density == 'Others') {
        wpf = double.tryParse(item.manualWeightCtrl.text) ?? 0;
      } else {
        wpf = _weightTable[item.section]?[item.density] ?? 0;
      }
      total += qty * length * wpf;
    }
    return double.parse(total.toStringAsFixed(3));
  }

  void _addItem() => setState(() => _items.add(_RejectionLineItem()));

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null || _shift == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(
        message:
            'This will deduct 2× the rejected weight from the original production report. Continue?',
      ),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final rejectedItems = _items.map((item) {
      final length = double.parse(item.lengthCtrl.text);
      final qty = int.parse(item.quantityCtrl.text);
      double wpf;
      if (item.density == 'Others') {
        wpf = double.parse(item.manualWeightCtrl.text);
      } else {
        wpf = _weightTable[item.section]?[item.density] ?? 0;
      }
      final ppw = Calculations.framePerPieceWeight(
        lengthFeet: length,
        weightPerFoot: wpf,
      );
      return FrameProductionLineItem(
        section: item.section!,
        density: item.density!,
        color: item.color!,
        length: length,
        quantity: qty,
        perPieceWeight: ppw,
        totalWeight: Calculations.totalWeight(qty, ppw),
      );
    }).toList();

    context.read<FrameReportsBloc>().add(
      SubmitCustomerRejectionReport(
        FrameCustomerRejectionReport(
          originalProductionDate: _productionDate,
          rejectionDate: _rejectionDate,
          machineNumber: _machineNumber!,
          shift: _shift!,
          rejectedItems: rejectedItems,
          totalRejectedWeight: _totalRejectedWeight(),
          createdBy: authState.user.uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FrameReportsBloc, FrameReportsState>(
      listener: (context, state) {
        if (state is FrameReportsSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.successGreen,
            ),
          );
          Navigator.pop(context);
        }
        if (state is FrameReportsError) {
          debugPrint('FrameReportsError: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Customer Rejection')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _machineNumber,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: ddp.frameMachines
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
              const SectionHeader(title: 'Rejected Items'),
              ...List.generate(_items.length, (i) {
                final item = _items[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Item ${i + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeItem(i),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppTheme.errorRed,
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: item.section,
                          decoration: const InputDecoration(
                            labelText: 'Section',
                          ),
                          items: ddp.frameSections
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.section = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: item.density,
                          decoration: const InputDecoration(
                            labelText: 'Density',
                          ),
                          items: ddp.frameDensities
                              .map(
                                (d) =>
                                    DropdownMenuItem(value: d, child: Text(d)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.density = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        if (item.density == 'Others') ...[
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: item.manualWeightCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Weight per foot (kg)',
                            ),
                            validator: (v) =>
                                Validators.positiveNumber(v, 'Weight'),
                          ),
                        ],
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: item.color,
                          decoration: const InputDecoration(labelText: 'Color'),
                          items: ddp.frameColors
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => item.color = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: item.lengthCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Length (feet)',
                          ),
                          validator: (v) =>
                              Validators.positiveNumber(v, 'Length'),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
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
                label: 'Total Rejected Weight',
                value: '${_totalRejectedWeight().toStringAsFixed(3)} kg',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Deduction (2× Rejected)',
                value: '${(_totalRejectedWeight() * 2).toStringAsFixed(3)} kg',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RejectionLineItem {
  String? section;
  String? density;
  String? color;
  final lengthCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final manualWeightCtrl = TextEditingController();

  void dispose() {
    lengthCtrl.dispose();
    quantityCtrl.dispose();
    manualWeightCtrl.dispose();
  }
}
