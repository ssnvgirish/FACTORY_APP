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

class FrameProductionDetailsFormPage extends StatefulWidget {
  const FrameProductionDetailsFormPage({super.key});

  @override
  State<FrameProductionDetailsFormPage> createState() =>
      _FrameProductionDetailsFormPageState();
}

class _FrameProductionDetailsFormPageState
    extends State<FrameProductionDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machineNumber;
  String? _shift;
  final List<_LineItemData> _lineItems = [];

  Map<String, Map<String, double>> get _weightTable => ddp.frameWeights;

  int get _totalQuantity => _lineItems.fold(
    0,
    (sum, item) => sum + (int.tryParse(item.quantityCtrl.text) ?? 0),
  );

  double get _totalWeight => _lineItems.fold(0.0, (sum, item) {
    final qty = int.tryParse(item.quantityCtrl.text) ?? 0;
    final ppw = _perPieceWeight(item);
    return sum + qty * ppw;
  });

  double _perPieceWeight(_LineItemData item) {
    final length = double.tryParse(item.lengthCtrl.text) ?? 0;
    if (item.section == null || item.density == null) return 0;
    if (item.density == 'Others') {
      final manual = double.tryParse(item.manualWeightCtrl.text) ?? 0;
      return Calculations.framePerPieceWeight(
        lengthFeet: length,
        weightPerFoot: manual,
      );
    }
    final wpf = Calculations.frameWeightPerFoot(
      section: item.section!,
      density: item.density!,
      weightTable: _weightTable,
    );
    if (wpf == null) return 0;
    return Calculations.framePerPieceWeight(
      lengthFeet: length,
      weightPerFoot: wpf,
    );
  }

  void _addLineItem() {
    setState(() {
      _lineItems.add(_LineItemData());
    });
  }

  void _removeLineItem(int index) {
    setState(() {
      _lineItems[index].dispose();
      _lineItems.removeAt(index);
    });
  }

  bool _needsTimeOfChange(int index) {
    if (index == 0) return false;
    final prev = _lineItems[index - 1];
    final curr = _lineItems[index];
    return curr.section != prev.section ||
        curr.density != prev.density ||
        curr.color != prev.color;
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null || _shift == null) return;
    if (_lineItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one production item')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final items = _lineItems.map((item) {
      final length = double.parse(item.lengthCtrl.text);
      final qty = int.parse(item.quantityCtrl.text);
      final ppw = _perPieceWeight(item);
      return FrameProductionLineItem(
        section: item.section!,
        density: item.density!,
        color: item.color!,
        length: length,
        quantity: qty,
        perPieceWeight: ppw,
        totalWeight: Calculations.totalWeight(qty, ppw),
        timeOfChange: item.timeOfChange,
        manualWeightPerFoot: item.density == 'Others'
            ? double.tryParse(item.manualWeightCtrl.text)
            : null,
      );
    }).toList();

    context.read<FrameReportsBloc>().add(
      SubmitProductionDetailsReport(
        FrameProductionDetailsReport(
          date: _date,
          machineNumber: _machineNumber!,
          shift: _shift!,
          lineItems: items,
          totalQuantity: _totalQuantity,
          totalWeight: _totalWeight,
          createdBy: authState.user.uid,
          submittedAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final item in _lineItems) {
      item.dispose();
    }
    super.dispose();
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
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Production Details')),
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
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _date = picked);
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
              const SectionHeader(title: 'Production Line Items'),
              ...List.generate(_lineItems.length, (index) {
                final item = _lineItems[index];
                final showTimeChange = _needsTimeOfChange(index);
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
                              onPressed: () => _removeLineItem(index),
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
                        const SizedBox(height: 12),
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
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: item.manualWeightCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Weight per foot (kg)',
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
                          items: ddp.frameColors
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
                            labelText: 'Length (feet)',
                          ),
                          validator: (v) =>
                              Validators.positiveNumber(v, 'Length'),
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
                          label: 'Per Piece Weight',
                          value:
                              '${_perPieceWeight(item).toStringAsFixed(3)} kg',
                        ),
                        const SizedBox(height: 8),
                        AutoCalculatedField(
                          label: 'Total Weight',
                          value:
                              '${((int.tryParse(item.quantityCtrl.text) ?? 0) * _perPieceWeight(item)).toStringAsFixed(3)} kg',
                        ),
                        if (showTimeChange) ...[
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
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() {
                                  item.timeOfChange = DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    time.hour,
                                    time.minute,
                                  );
                                });
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
                onPressed: _addLineItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Line Item'),
              ),
              const SizedBox(height: 24),
              AutoCalculatedField(
                label: 'Total Quantity (h)',
                value: '$_totalQuantity pieces',
              ),
              const SizedBox(height: 8),
              AutoCalculatedField(
                label: 'Total Weight (k)',
                value: '${_totalWeight.toStringAsFixed(3)} kg',
              ),
              const SizedBox(height: 32),
              BlocBuilder<FrameReportsBloc, FrameReportsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is FrameReportsSubmitting ? null : _submit,
                    child: state is FrameReportsSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
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
}

class _LineItemData {
  String? section;
  String? density;
  String? color;
  DateTime? timeOfChange;
  final lengthCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final manualWeightCtrl = TextEditingController();

  void dispose() {
    lengthCtrl.dispose();
    quantityCtrl.dispose();
    manualWeightCtrl.dispose();
  }
}
