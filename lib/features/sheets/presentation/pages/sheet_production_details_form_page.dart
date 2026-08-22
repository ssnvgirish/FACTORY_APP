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
  final SheetProductionDetailsReport? existing;
  const SheetProductionDetailsFormPage({super.key, this.existing});

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
  final List<_ItemGroup> _groups = [];

  List<_SheetLineItemData> get _items => [
    for (final g in _groups)
      for (final line in g.lines) line._withGroup(g),
  ];

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

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      _date = existing.date;
      _machineNumber = existing.machineNumber;
      _shift = existing.shift;
      _loadExisting(existing);
    } else {
      _groups.add(_ItemGroup()..lines.add(_SheetLineItemData()));
    }
  }

  void _loadExisting(SheetProductionDetailsReport report) {
    _ItemGroup? current;
    for (final li in report.lineItems) {
      final needsNewGroup =
          current == null ||
          current.thickness != li.thickness ||
          current.density != li.density ||
          current.color != li.color;
      if (needsNewGroup) {
        current = _ItemGroup()
          ..thickness = li.thickness
          ..density = li.density
          ..color = li.color
          ..timeOfChange = li.timeOfChange
          ..manualWeightCtrl.text = li.manualWeightPerSqft?.toString() ?? '';
        _groups.add(current);
      }
      final line = _SheetLineItemData();
      line.lengthCtrl.text = li.length.toString();
      line.widthCtrl.text = li.width.toString();
      line.quantityCtrl.text = li.quantity.toString();
      current.lines.add(line);
    }
  }

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
    final wpsqft = Calculations.sheetWeightPerSqft(
      thickness: item.thickness!,
      density: item.density!,
      weightTable: ddp.sheetWeights,
    );
    if (wpsqft == null) return 0;
    return Calculations.sheetPerPieceWeight(sqft, wpsqft);
  }

  bool _missingWeightRow(_ItemGroup group) {
    if (group.thickness == null || group.density == null) return false;
    if (group.density == 'Others') return false;
    return Calculations.sheetWeightPerSqft(
          thickness: group.thickness!,
          density: group.density!,
          weightTable: ddp.sheetWeights,
        ) ==
        null;
  }

  void _addGroup() => setState(() {
    _groups.add(_ItemGroup()..lines.add(_SheetLineItemData()));
  });

  void _removeGroup(int i) => setState(() {
    _groups[i].dispose();
    _groups.removeAt(i);
  });

  void _addLine(_ItemGroup group) =>
      setState(() => group.lines.add(_SheetLineItemData()));

  void _removeLine(_ItemGroup group, int i) => setState(() {
    group.lines[i].dispose();
    group.lines.removeAt(i);
    if (group.lines.isEmpty) {
      _groups.remove(group);
      group.manualWeightCtrl.dispose();
    }
  });

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null || _shift == null || _items.isEmpty) return;

    for (var g = 1; g < _groups.length; g++) {
      if (_groups[g].timeOfChange == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Set time of change for Item Group ${g + 1}'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
        return;
      }
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final lineItems = <SheetProductionLineItem>[];
    for (var gi = 0; gi < _groups.length; gi++) {
      final group = _groups[gi];
      for (var li = 0; li < group.lines.length; li++) {
        final item = group.lines[li]._withGroup(group);
        final l = double.parse(item.lengthCtrl.text);
        final w = double.parse(item.widthCtrl.text);
        final qty = int.parse(item.quantityCtrl.text);
        final sqft = Calculations.sheetSqft(l, w);
        final ppw = _ppw(item);
        lineItems.add(
          SheetProductionLineItem(
            thickness: group.thickness!,
            density: group.density!,
            color: group.color!,
            length: l,
            width: w,
            quantity: qty,
            sqft: sqft,
            perPieceWeight: ppw,
            totalWeight: Calculations.totalWeight(qty, ppw),
            totalRunningFeet: Calculations.totalRunningFeet(l, qty),
            timeOfChange: gi > 0 && li == 0 ? group.timeOfChange : null,
            manualWeightPerSqft: group.density == 'Others'
                ? double.tryParse(group.manualWeightCtrl.text)
                : null,
          ),
        );
      }
    }

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
        replaceId: widget.existing?.id,
      ),
    );
  }

  @override
  void dispose() {
    for (final g in _groups) {
      g.dispose();
    }
    super.dispose();
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
          if (widget.existing != null) Navigator.pop(context);
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.existing == null
                ? 'New Sheet Production'
                : 'Edit Sheet Production',
          ),
        ),
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
              const SectionHeader(title: 'Production Item Groups'),
              if (!ddp.isLoaded) ...[
                const SizedBox(height: 8),
                ListTile(
                  dense: true,
                  tileColor: AppTheme.warningYellow.withValues(alpha: 0.15),
                  leading: const Icon(
                    Icons.cloud_off,
                    color: AppTheme.warningYellow,
                  ),
                  title: const Text(
                    'Master data could not be loaded',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
              ...List.generate(_groups.length, (gi) => _buildGroupCard(gi)),
              OutlinedButton.icon(
                onPressed: _addGroup,
                icon: const Icon(Icons.add),
                label: const Text('Add Item Group'),
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
                      : Text(
                          widget.existing == null
                              ? 'Submit Report'
                              : 'Save Changes',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(int gi) {
    final group = _groups[gi];
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Item Group ${gi + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeGroup(gi),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppTheme.errorRed,
                  ),
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              key: ValueKey('g${gi}_th_${group.thickness}'),
              initialValue: group.thickness,
              decoration: const InputDecoration(labelText: 'Thickness'),
              items: ddp.sheetThicknesses
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => group.thickness = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('g${gi}_d_${group.density}'),
              initialValue: group.density,
              decoration: const InputDecoration(labelText: 'Density'),
              items: ddp.sheetDensities
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => group.density = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            if (group.density == 'Others') ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: group.manualWeightCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight per SQFT (kg)',
                ),
                validator: (v) => Validators.positiveNumber(v, 'Weight'),
                onChanged: (_) => setState(() {}),
              ),
            ],
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('g${gi}_c_${group.color}'),
              initialValue: group.color,
              decoration: const InputDecoration(labelText: 'Colour'),
              items: ddp.sheetColors
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => group.color = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            if (_missingWeightRow(group)) ...[
              const SizedBox(height: 12),
              ListTile(
                dense: true,
                tileColor: AppTheme.errorRed.withValues(alpha: 0.1),
                leading: const Icon(
                  Icons.error_outline,
                  color: AppTheme.errorRed,
                ),
                title: Text(
                  'No weight configured for ${group.thickness} × ${group.density}',
                  style: const TextStyle(
                    color: AppTheme.errorRed,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
            if (gi > 0) ...[
              const SizedBox(height: 12),
              ListTile(
                dense: true,
                tileColor: AppTheme.warningYellow.withValues(alpha: 0.1),
                leading: const Icon(
                  Icons.schedule,
                  color: AppTheme.warningYellow,
                ),
                title: const Text('Time of Change'),
                subtitle: Text(
                  group.timeOfChange != null
                      ? DateFormat('hh:mm a').format(group.timeOfChange!)
                      : 'Required when adding a new item group',
                ),
                onTap: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (t != null) {
                    setState(
                      () => group.timeOfChange = DateTime(
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
            const SizedBox(height: 16),
            Text('Item list', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...List.generate(group.lines.length, (li) {
              final line = group.lines[li];
              final bound = line._withGroup(group);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Line ${li + 1}'),
                        const Spacer(),
                        IconButton(
                          onPressed: () => _removeLine(group, li),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: line.lengthCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Length (inches)',
                      ),
                      validator: (v) => Validators.positiveNumber(v, 'Length'),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: line.widthCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Width (inches)',
                      ),
                      validator: (v) => Validators.positiveNumber(v, 'Width'),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: line.quantityCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      validator: (v) =>
                          Validators.positiveInteger(v, 'Quantity'),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),
                    AutoCalculatedField(
                      label: 'SQFT',
                      value: _sqft(bound).toStringAsFixed(3),
                    ),
                    const SizedBox(height: 8),
                    AutoCalculatedField(
                      label: 'Per Piece Weight',
                      value: '${_ppw(bound).toStringAsFixed(3)} kg',
                    ),
                    const SizedBox(height: 8),
                    AutoCalculatedField(
                      label: 'Total Running Feet',
                      value:
                          '${Calculations.totalRunningFeet(double.tryParse(line.lengthCtrl.text) ?? 0, int.tryParse(line.quantityCtrl.text) ?? 0).toStringAsFixed(3)} ft',
                    ),
                  ],
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: () => _addLine(group),
              icon: const Icon(Icons.add),
              label: const Text('Add line'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemGroup {
  String? thickness;
  String? density;
  String? color;
  DateTime? timeOfChange;
  final manualWeightCtrl = TextEditingController();
  final List<_SheetLineItemData> lines = [];

  void dispose() {
    manualWeightCtrl.dispose();
    for (final l in lines) {
      l.dispose();
    }
  }
}

class _SheetLineItemData {
  String? thickness;
  String? density;
  String? color;
  final lengthCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  final manualWeightCtrl = TextEditingController();

  _SheetLineItemData _withGroup(_ItemGroup group) {
    thickness = group.thickness;
    density = group.density;
    color = group.color;
    if (group.density == 'Others') {
      manualWeightCtrl.text = group.manualWeightCtrl.text;
    }
    return this;
  }

  void dispose() {
    lengthCtrl.dispose();
    widthCtrl.dispose();
    quantityCtrl.dispose();
    manualWeightCtrl.dispose();
  }
}
