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

class FramePackingReportFormPage extends StatefulWidget {
  const FramePackingReportFormPage({super.key});

  @override
  State<FramePackingReportFormPage> createState() =>
      _FramePackingReportFormPageState();
}

class _FramePackingReportFormPageState
    extends State<FramePackingReportFormPage> {
  String? _machineNumber;
  String? _shift;
  DateTime _date = DateTime.now();
  List<_PackingItem> _items = [];
  bool _loaded = false;

  void _loadProductionData() {
    if (_machineNumber == null || _shift == null) return;
    context.read<FrameReportsBloc>().add(
      LoadProductionDetailsForShift(
        machineNumber: _machineNumber!,
        date: _date,
        shift: _shift!,
      ),
    );
  }

  void _submit() async {
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      final packed = int.tryParse(item.packedCtrl.text) ?? 0;
      final rejected = int.tryParse(item.rejectedCtrl.text) ?? 0;
      final error = Validators.validatePackingQuantities(
        item.productionQuantity,
        packed,
        rejected,
      );
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item ${i + 1}: $error'),
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

    final packingItems = _items.map((item) {
      final packed = int.parse(item.packedCtrl.text);
      final rejected = int.parse(item.rejectedCtrl.text);
      return FramePackingLineItem(
        section: item.section,
        density: item.density,
        color: item.color,
        length: item.length,
        productionQuantity: item.productionQuantity,
        perPieceWeight: item.perPieceWeight,
        packed: packed,
        rejectedQuality: rejected,
      );
    }).toList();

    final totalRejectedWeight = packingItems.fold<double>(
      0,
      (sum, item) => sum + item.rejectedWeight,
    );

    final totalProductionWeight = _items.fold<double>(
      0,
      (s, i) => s + i.productionQuantity * i.perPieceWeight,
    );
    final qualityAcceptance = Calculations.qualityAcceptancePercentage(
      totalProductionWeight,
      totalRejectedWeight,
    );
    final totalProduced = _items.fold<int>(
      0,
      (s, i) => s + i.productionQuantity,
    );
    final totalPacked = packingItems.fold<int>(0, (s, i) => s + i.packed);
    final packingEff = Calculations.packingEfficiency(
      totalProduced,
      totalPacked,
    );

    context.read<FrameReportsBloc>().add(
      SubmitShiftPackingReport(
        FrameShiftPackingReport(
          date: _date,
          machineNumber: _machineNumber!,
          shift: _shift!,
          lineItems: packingItems,
          totalRejectedWeight: totalRejectedWeight,
          qualityAcceptancePercentage: qualityAcceptance,
          packingEfficiency: packingEff,
          createdBy: authState.user.uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FrameReportsBloc, FrameReportsState>(
      listener: (context, state) {
        if (state is ProductionDetailsForShiftLoaded && state.report != null) {
          setState(() {
            _loaded = true;
            _items = state.report!.lineItems
                .map(
                  (li) => _PackingItem(
                    section: li.section,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    productionQuantity: li.quantity,
                    perPieceWeight: li.perPieceWeight,
                  ),
                )
                .toList();
          });
        }
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
        appBar: AppBar(title: const Text('New Packing Report')),
        body: ListView(
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
                  if (picked != null) {
                    setState(() {
                      _date = picked;
                      _loaded = false;
                    });
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
              onChanged: (v) => setState(() {
                _machineNumber = v;
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
            if (_loaded && _items.isEmpty)
              const EmptyStateWidget(
                message: 'No production data found for this shift',
              ),
            if (_loaded && _items.isNotEmpty) ...[
              const SectionHeader(title: 'Classify Production'),
              ...List.generate(_items.length, (index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.section} — ${item.density} — ${item.color}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Length: ${item.length}ft | Qty: ${item.productionQuantity} | Weight/pc: ${item.perPieceWeight.toStringAsFixed(3)} kg',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: item.packedCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Packed',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: item.rejectedCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Rejected (Quality Issue)',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 8),
                        Builder(
                          builder: (_) {
                            final packed =
                                int.tryParse(item.packedCtrl.text) ?? 0;
                            final rejected =
                                int.tryParse(item.rejectedCtrl.text) ?? 0;
                            final total = packed + rejected;
                            final isValid = total == item.productionQuantity;
                            return Text(
                              'Total classified: $total / ${item.productionQuantity}',
                              style: TextStyle(
                                color: isValid
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
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

class _PackingItem {
  final String section;
  final String density;
  final String color;
  final double length;
  final int productionQuantity;
  final double perPieceWeight;
  final packedCtrl = TextEditingController();
  final rejectedCtrl = TextEditingController();

  _PackingItem({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.productionQuantity,
    required this.perPieceWeight,
  });
}
