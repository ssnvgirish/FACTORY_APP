import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/admin_entities.dart';
import '../bloc/admin_bloc.dart';

class ReferenceTablesPage extends StatelessWidget {
  const ReferenceTablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reference / Lookup Tables')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LookupTile(
            title: 'Frame Weight Table',
            subtitle: 'Section × Density → Weight per foot',
            lookupType: MasterLookupType.frameWeights,
          ),
          _LookupTile(
            title: 'Sheet Weight Table',
            subtitle: 'Thickness × Density → Weight per sqft',
            lookupType: MasterLookupType.sheetWeights,
          ),
          _LookupTile(
            title: 'Frame Production Targets',
            subtitle: 'Section × Density → Target kg/hr',
            lookupType: MasterLookupType.frameTargets,
          ),
          _LookupTile(
            title: 'Sheet Production Targets',
            subtitle: 'Thickness × Density → Target ft/hr',
            lookupType: MasterLookupType.sheetTargets,
          ),
          _LookupTile(
            title: 'Scrap Production Targets',
            subtitle: 'Target weight per hour by product',
            lookupType: MasterLookupType.scrapTargets,
          ),
          _LookupTile(
            title: 'Salary Weightages',
            subtitle: 'Variable weightages summing to 100%',
            lookupType: MasterLookupType.salaryWeightages,
          ),
        ],
      ),
    );
  }
}

class _LookupTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final MasterLookupType lookupType;

  const _LookupTile({
    required this.title,
    required this.subtitle,
    required this.lookupType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.edit, color: AppTheme.accentAmber),
        onTap: () {
          context.read<AdminBloc>().add(LoadMasterLookup(lookupType));
          if (lookupType == MasterLookupType.frameWeights ||
              lookupType == MasterLookupType.sheetWeights) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    _WeightTableEditPage(title: title, lookupType: lookupType),
              ),
            );
          } else if (lookupType == MasterLookupType.salaryWeightages) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _SalaryWeightagesEditPage(title: title),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    _TargetTableEditPage(title: title, lookupType: lookupType),
              ),
            );
          }
        },
      ),
    );
  }
}

// ─── Weight Table Editor (section/thickness × density → weight) ───

class _WeightTableEditPage extends StatelessWidget {
  final String title;
  final MasterLookupType lookupType;
  const _WeightTableEditPage({required this.title, required this.lookupType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is MasterLookupSaved) {
            context.read<AdminBloc>().add(LoadMasterLookup(lookupType));
          }
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) return const LoadingWidget();
          if (state is MasterWeightsLoaded && state.lookupType == lookupType) {
            if (state.entries.isEmpty) {
              return const EmptyStateWidget(message: 'No entries');
            }
            final sorted = List<MasterWeightEntry>.from(state.entries)
              ..sort(
                (a, b) =>
                    '${a.key1}|${a.key2}'.compareTo('${b.key1}|${b.key2}'),
              );
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sorted.length,
              itemBuilder: (context, i) {
                final e = sorted[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '${e.key1} × ${e.key2}',
                      style: GoogleFonts.sourceCodePro(fontSize: 13),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.weight.toStringAsFixed(3),
                          style: GoogleFonts.sourceCodePro(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AppTheme.accentAmber,
                          ),
                          onPressed: () => _showEditDialog(context, e),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<AdminBloc>().add(
                              DeleteMasterWeightEntry(lookupType, e.id),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final k1 = TextEditingController();
    final k2 = TextEditingController();
    final w = TextEditingController();
    final isFrame = lookupType == MasterLookupType.frameWeights;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Weight Entry'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: k1,
              decoration: InputDecoration(
                labelText: isFrame ? 'Section' : 'Thickness',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: k2,
              decoration: const InputDecoration(labelText: 'Density'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: w,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final entry = MasterWeightEntry(
                id: '',
                key1: k1.text.trim(),
                key2: k2.text.trim(),
                weight: double.tryParse(w.text) ?? 0,
              );
              context.read<AdminBloc>().add(
                SaveMasterWeightEntry(lookupType, entry, isNew: true),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, MasterWeightEntry existing) {
    final w = TextEditingController(text: existing.weight.toStringAsFixed(3));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${existing.key1} × ${existing.key2}'),
        content: TextField(
          controller: w,
          decoration: const InputDecoration(labelText: 'Weight'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final entry = MasterWeightEntry(
                id: existing.id,
                key1: existing.key1,
                key2: existing.key2,
                weight: double.tryParse(w.text) ?? 0,
              );
              context.read<AdminBloc>().add(
                SaveMasterWeightEntry(lookupType, entry),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ─── Target Table Editor (key × density → target value) ───

class _TargetTableEditPage extends StatelessWidget {
  final String title;
  final MasterLookupType lookupType;
  const _TargetTableEditPage({required this.title, required this.lookupType});

  bool get _hasDensity =>
      lookupType == MasterLookupType.frameTargets ||
      lookupType == MasterLookupType.sheetTargets;

  String get _keyLabel {
    if (lookupType == MasterLookupType.frameTargets) return 'Section';
    if (lookupType == MasterLookupType.sheetTargets) return 'Thickness';
    return 'Key';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is MasterLookupSaved) {
            context.read<AdminBloc>().add(LoadMasterLookup(lookupType));
          }
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) return const LoadingWidget();
          if (state is MasterTargetsLoaded && state.lookupType == lookupType) {
            if (state.entries.isEmpty) {
              return const EmptyStateWidget(message: 'No entries');
            }
            final sorted = List<MasterTargetEntry>.from(state.entries)
              ..sort((a, b) {
                final k = a.key.compareTo(b.key);
                if (k != 0) return k;
                return (a.density ?? '').compareTo(b.density ?? '');
              });
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sorted.length,
              itemBuilder: (context, i) {
                final e = sorted[i];
                final displayKey = _hasDensity && e.density != null
                    ? '${e.key} × ${e.density}'
                    : e.key;
                return Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      displayKey,
                      style: GoogleFonts.sourceCodePro(fontSize: 13),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.target.toStringAsFixed(1),
                          style: GoogleFonts.sourceCodePro(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AppTheme.accentAmber,
                          ),
                          onPressed: () => _showEditDialog(context, e),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<AdminBloc>().add(
                              DeleteMasterTargetEntry(lookupType, e.id),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final kCtrl = TextEditingController();
    final dCtrl = TextEditingController();
    final vCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Target'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: kCtrl,
              decoration: InputDecoration(labelText: _keyLabel),
            ),
            if (_hasDensity) ...[
              const SizedBox(height: 8),
              TextField(
                controller: dCtrl,
                decoration: const InputDecoration(labelText: 'Density'),
              ),
            ],
            const SizedBox(height: 8),
            TextField(
              controller: vCtrl,
              decoration: const InputDecoration(labelText: 'Target'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminBloc>().add(
                SaveMasterTargetEntry(
                  lookupType,
                  MasterTargetEntry(
                    id: '',
                    key: kCtrl.text.trim(),
                    density: _hasDensity ? dCtrl.text.trim() : null,
                    target: double.tryParse(vCtrl.text) ?? 0,
                  ),
                  isNew: true,
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, MasterTargetEntry existing) {
    final vCtrl = TextEditingController(
      text: existing.target.toStringAsFixed(1),
    );
    final displayKey = _hasDensity && existing.density != null
        ? '${existing.key} × ${existing.density}'
        : existing.key;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(displayKey),
        content: TextField(
          controller: vCtrl,
          decoration: const InputDecoration(labelText: 'Target'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminBloc>().add(
                SaveMasterTargetEntry(
                  lookupType,
                  MasterTargetEntry(
                    id: existing.id,
                    key: existing.key,
                    density: existing.density,
                    target: double.tryParse(vCtrl.text) ?? 0,
                  ),
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ─── Salary Weightages Editor ───

class _SalaryWeightagesEditPage extends StatelessWidget {
  final String title;
  const _SalaryWeightagesEditPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is MasterLookupSaved) {
            context.read<AdminBloc>().add(const LoadSalaryWeightages());
          }
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) return const LoadingWidget();
          if (state is SalaryWeightagesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.entries.length,
              itemBuilder: (context, i) {
                final e = state.entries[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    title: Text('${e.variable} — ${e.label}'),
                    subtitle: Text('Category: ${e.category}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${e.percentage}%',
                          style: GoogleFonts.sourceCodePro(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AppTheme.accentAmber,
                          ),
                          onPressed: () => _showEditDialog(context, e),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    MasterSalaryWeightageEntry existing,
  ) {
    final pctCtrl = TextEditingController(text: existing.percentage.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${existing.variable} — ${existing.label}'),
        content: TextField(
          controller: pctCtrl,
          decoration: const InputDecoration(labelText: 'Percentage'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminBloc>().add(
                SaveSalaryWeightage(
                  MasterSalaryWeightageEntry(
                    id: existing.id,
                    variable: existing.variable,
                    label: existing.label,
                    category: existing.category,
                    percentage: double.tryParse(pctCtrl.text) ?? 0,
                  ),
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
