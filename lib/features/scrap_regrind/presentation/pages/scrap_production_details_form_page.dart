import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapProductionDetailsFormPage extends StatefulWidget {
  const ScrapProductionDetailsFormPage({super.key});

  @override
  State<ScrapProductionDetailsFormPage> createState() =>
      _ScrapProductionDetailsFormPageState();
}

class _ScrapProductionDetailsFormPageState
    extends State<ScrapProductionDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMachine;
  String? _selectedShift;

  final List<_ProductLineData> _lineItems = [];

  double get _totalWeight =>
      _lineItems.fold(0.0, (sum, item) => sum + item.totalWeight);

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
        appBar: AppBar(title: const Text('New Production Details')),
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
                items: AppConstants.scrapPulverizerMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v),
                validator: (v) => v == null ? 'Select a machine' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedShift,
                decoration: const InputDecoration(labelText: 'Shift'),
                items: AppConstants.shifts
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedShift = v),
                validator: (v) => v == null ? 'Select a shift' : null,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Line Items',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addLineItem,
                  ),
                ],
              ),
              const Divider(),

              ..._lineItems.asMap().entries.map(
                (entry) => _ProductLineCard(
                  index: entry.key,
                  data: entry.value,
                  onRemove: () => setState(() {
                    _lineItems.removeAt(entry.key);
                  }),
                  onChanged: () => setState(() {}),
                ),
              ),

              if (_lineItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text('Tap + to add product line items')),
                ),

              const SizedBox(height: 16),
              AutoCalculatedField(
                label: 'Total Production Weight',
                value: '${_totalWeight.toStringAsFixed(2)} kg',
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

  void _addLineItem() {
    setState(() {
      _lineItems.add(_ProductLineData());
    });
  }

  void _submitReport() {
    if (!_formKey.currentState!.validate()) return;
    if (_lineItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one product line item')),
      );
      return;
    }

    final items = _lineItems
        .map(
          (item) => ScrapProductionLineItem(
            product: item.product!,
            weightPerBag: double.parse(item.weightPerBagCtrl.text),
            totalBags: int.parse(item.totalBagsCtrl.text),
            totalWeight: item.totalWeight,
          ),
        )
        .toList();

    final report = ScrapProductionDetailsReport(
      date: _selectedDate,
      machineNumber: _selectedMachine!,
      shift: _selectedShift!,
      lineItems: items,
      totalProductionWeight: _totalWeight,
      createdBy: '', // Set from auth
    );

    context.read<ScrapRegrindBloc>().add(
      SubmitScrapProductionDetailsReport(report),
    );
  }
}

class _ProductLineData {
  String? product;
  final weightPerBagCtrl = TextEditingController();
  final totalBagsCtrl = TextEditingController();

  double get totalWeight {
    final weight = double.tryParse(weightPerBagCtrl.text) ?? 0;
    final bags = int.tryParse(totalBagsCtrl.text) ?? 0;
    return weight * bags;
  }
}

class _ProductLineCard extends StatelessWidget {
  final int index;
  final _ProductLineData data;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _ProductLineCard({
    required this.index,
    required this.data,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product ${index + 1}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: onRemove,
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              initialValue: data.product,
              decoration: const InputDecoration(labelText: 'Product'),
              items: AppConstants.scrapProducts
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) {
                data.product = v;
                onChanged();
              },
              validator: (v) => v == null ? 'Select a product' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: data.weightPerBagCtrl,
              decoration: const InputDecoration(
                labelText: 'Weight per Bag (kg)',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => onChanged(),
              validator: (v) =>
                  (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Enter weight' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: data.totalBagsCtrl,
              decoration: const InputDecoration(
                labelText: 'Total Number of Bags',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => onChanged(),
              validator: (v) =>
                  (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Enter count' : null,
            ),
            const SizedBox(height: 8),
            AutoCalculatedField(
              label: 'Total Weight',
              value: '${data.totalWeight.toStringAsFixed(2)} kg',
            ),
          ],
        ),
      ),
    );
  }
}
