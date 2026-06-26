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
            subtitle: 'Section × Density → Weight per foot (kg)',
            icon: Icons.table_chart,
            lookupType: MasterLookupType.frameWeights,
          ),
          _LookupTile(
            title: 'Sheet Weight Table',
            subtitle: 'Thickness × Density → Weight per sqft (kg)',
            icon: Icons.table_chart,
            lookupType: MasterLookupType.sheetWeights,
          ),
          _LookupTile(
            title: 'Frame Production Targets',
            subtitle: 'Section × Density → Target kg / hr',
            icon: Icons.track_changes,
            lookupType: MasterLookupType.frameTargets,
          ),
          _LookupTile(
            title: 'Sheet Production Targets',
            subtitle: 'Thickness × Density → Target ft / hr',
            icon: Icons.track_changes,
            lookupType: MasterLookupType.sheetTargets,
          ),
          _LookupTile(
            title: 'Scrap Production Targets',
            subtitle: 'Product → Target kg / hr',
            icon: Icons.track_changes,
            lookupType: MasterLookupType.scrapTargets,
          ),
          _LookupTile(
            title: 'Salary Weightages',
            subtitle: 'Variable weightages summing to 100 % per category',
            icon: Icons.percent,
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
  final IconData icon;
  final MasterLookupType lookupType;

  const _LookupTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.lookupType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: AppTheme.accentAmber),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.read<AdminBloc>().add(LoadMasterLookup(lookupType));
          final page = switch (lookupType) {
            MasterLookupType.frameWeights || MasterLookupType.sheetWeights =>
              _WeightMatrixPage(title: title, lookupType: lookupType),
            MasterLookupType.frameTargets || MasterLookupType.sheetTargets =>
              _TargetMatrixPage(title: title, lookupType: lookupType),
            MasterLookupType.scrapTargets => _ScrapTargetPage(title: title),
            MasterLookupType.salaryWeightages => _SalaryWeightagesPage(
              title: title,
            ),
          };
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}

// ─── Weight Matrix Page (section/thickness × density → weight) ────────────

class _WeightMatrixPage extends StatelessWidget {
  final String title;
  final MasterLookupType lookupType;
  const _WeightMatrixPage({required this.title, required this.lookupType});

  bool get _isFrame => lookupType == MasterLookupType.frameWeights;

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
              return const EmptyStateWidget(
                message: 'No entries yet. Tap + to add.',
              );
            }
            return _buildMatrix(context, state.entries);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildMatrix(BuildContext context, List<MasterWeightEntry> entries) {
    // Build row/column sets from the data.
    final rowKeys = <String>{};
    final colKeys = <String>{};
    for (final e in entries) {
      rowKeys.add(e.key1);
      colKeys.add(e.key2);
    }
    final rows = rowKeys.toList()..sort();
    final cols = colKeys.toList()..sort();

    // Build a lookup map for fast access.
    final lookup = <String, MasterWeightEntry>{};
    for (final e in entries) {
      lookup['${e.key1}|${e.key2}'] = e;
    }

    const double rowLabelWidth = 120;
    const double cellWidth = 80;
    const double cellHeight = 44;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                _headerCell(
                  _isFrame ? 'Section' : 'Thickness',
                  width: rowLabelWidth,
                  height: cellHeight,
                ),
                ...cols.map(
                  (d) =>
                      _headerCell('ρ $d', width: cellWidth, height: cellHeight),
                ),
              ],
            ),
            const Divider(height: 2, thickness: 2),
            // Data rows
            ...rows.map((rowKey) {
              return Row(
                children: [
                  _labelCell(rowKey, width: rowLabelWidth, height: cellHeight),
                  ...cols.map((colKey) {
                    final entry = lookup['$rowKey|$colKey'];
                    return _dataCell(
                      context,
                      entry: entry,
                      rowKey: rowKey,
                      colKey: colKey,
                      width: cellWidth,
                      height: cellHeight,
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(
    String text, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: AppTheme.accentAmber.withValues(alpha: 0.15),
      child: Text(
        text,
        style: GoogleFonts.sourceCodePro(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _labelCell(
    String text, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Text(
        text,
        style: GoogleFonts.sourceCodePro(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _dataCell(
    BuildContext context, {
    MasterWeightEntry? entry,
    required String rowKey,
    required String colKey,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: entry == null ? null : () => _showEditDialog(context, entry),
      onLongPress: entry == null ? null : () => _confirmDelete(context, entry),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5),
          color: entry == null
              ? Colors.grey.withValues(alpha: 0.05)
              : Colors.white,
        ),
        child: entry == null
            ? const Text('—', style: TextStyle(color: Colors.black26))
            : Text(
                entry.weight.toStringAsFixed(3),
                style: GoogleFonts.sourceCodePro(fontSize: 11),
              ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final k1 = TextEditingController();
    final k2 = TextEditingController();
    final w = TextEditingController();
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
                labelText: _isFrame ? 'Section' : 'Thickness',
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
              context.read<AdminBloc>().add(
                SaveMasterWeightEntry(
                  lookupType,
                  MasterWeightEntry(
                    id: '',
                    key1: k1.text.trim(),
                    key2: k2.text.trim(),
                    weight: double.tryParse(w.text) ?? 0,
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
              context.read<AdminBloc>().add(
                SaveMasterWeightEntry(
                  lookupType,
                  MasterWeightEntry(
                    id: existing.id,
                    key1: existing.key1,
                    key2: existing.key2,
                    weight: double.tryParse(w.text) ?? 0,
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

  void _confirmDelete(BuildContext context, MasterWeightEntry entry) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry'),
        content: Text('Delete ${entry.key1} × ${entry.key2}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<AdminBloc>().add(
                DeleteMasterWeightEntry(lookupType, entry.id),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Target Matrix Page (section/thickness × density → target) ────────────

class _TargetMatrixPage extends StatelessWidget {
  final String title;
  final MasterLookupType lookupType;
  const _TargetMatrixPage({required this.title, required this.lookupType});

  bool get _isFrame => lookupType == MasterLookupType.frameTargets;

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
              return const EmptyStateWidget(
                message: 'No entries yet. Tap + to add.',
              );
            }
            return _buildMatrix(context, state.entries);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildMatrix(BuildContext context, List<MasterTargetEntry> entries) {
    final rowKeys = <String>{};
    final colKeys = <String>{};
    for (final e in entries) {
      rowKeys.add(e.key);
      if (e.density != null) colKeys.add(e.density!);
    }
    final rows = rowKeys.toList()..sort();
    final cols = colKeys.toList()..sort();
    final hasDensity = cols.isNotEmpty;

    final lookup = <String, MasterTargetEntry>{};
    for (final e in entries) {
      lookup[hasDensity && e.density != null
              ? '${e.key}|${e.density}'
              : e.key] =
          e;
    }

    if (!hasDensity) {
      // Simple flat list (scrap targets style).
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: entries.length,
        itemBuilder: (context, i) => _buildFlatRow(context, entries[i]),
      );
    }

    const double rowLabelWidth = 120;
    const double cellWidth = 72;
    const double cellHeight = 44;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _headerCell(
                  _isFrame ? 'Section' : 'Thickness',
                  width: rowLabelWidth,
                  height: cellHeight,
                ),
                ...cols.map(
                  (d) =>
                      _headerCell('ρ $d', width: cellWidth, height: cellHeight),
                ),
              ],
            ),
            const Divider(height: 2, thickness: 2),
            ...rows.map((rowKey) {
              return Row(
                children: [
                  _labelCell(rowKey, width: rowLabelWidth, height: cellHeight),
                  ...cols.map((colKey) {
                    final entry = lookup['$rowKey|$colKey'];
                    return _dataCell(
                      context,
                      entry: entry,
                      rowKey: rowKey,
                      colKey: colKey,
                      width: cellWidth,
                      height: cellHeight,
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatRow(BuildContext context, MasterTargetEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        dense: true,
        title: Text(entry.key, style: GoogleFonts.sourceCodePro(fontSize: 13)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entry.target.toStringAsFixed(1),
              style: GoogleFonts.sourceCodePro(),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                size: 18,
                color: AppTheme.accentAmber,
              ),
              onPressed: () => _showEditDialog(context, entry),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: () => context.read<AdminBloc>().add(
                DeleteMasterTargetEntry(lookupType, entry.id),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(
    String text, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: AppTheme.accentAmber.withValues(alpha: 0.15),
      child: Text(
        text,
        style: GoogleFonts.sourceCodePro(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _labelCell(
    String text, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Text(
        text,
        style: GoogleFonts.sourceCodePro(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _dataCell(
    BuildContext context, {
    MasterTargetEntry? entry,
    required String rowKey,
    required String colKey,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: entry == null ? null : () => _showEditDialog(context, entry),
      onLongPress: entry == null ? null : () => _confirmDelete(context, entry),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5),
          color: entry == null
              ? Colors.grey.withValues(alpha: 0.05)
              : Colors.white,
        ),
        child: entry == null
            ? const Text('—', style: TextStyle(color: Colors.black26))
            : Text(
                entry.target.toStringAsFixed(0),
                style: GoogleFonts.sourceCodePro(fontSize: 11),
              ),
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
              decoration: InputDecoration(
                labelText: _isFrame ? 'Section' : 'Thickness',
                hintText: _isFrame ? 'e.g., 3x2' : 'e.g., 0.5',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dCtrl,
              decoration: const InputDecoration(
                labelText: 'Density *',
                hintText: 'e.g., 0.75',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: vCtrl,
              decoration: InputDecoration(
                labelText: _isFrame ? 'Target (kg/hr)' : 'Target (ft/hr)',
                hintText: _isFrame ? 'e.g., 50.5' : 'e.g., 100.0',
              ),
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
              final section = kCtrl.text.trim();
              final density = dCtrl.text.trim();
              final targetStr = vCtrl.text.trim();

              // Validation
              if (section.isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isFrame
                          ? 'Section is required'
                          : 'Thickness is required',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              if (density.isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Density is required'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              if (targetStr.isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Target value is required'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              final target = double.tryParse(targetStr);
              if (target == null) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Target must be a valid number'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              context.read<AdminBloc>().add(
                SaveMasterTargetEntry(
                  lookupType,
                  MasterTargetEntry(
                    id: '',
                    key: section,
                    density: density,
                    target: target,
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
    final label = existing.density != null
        ? '${existing.key} × ${existing.density}'
        : existing.key;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: TextField(
          controller: vCtrl,
          decoration: InputDecoration(
            labelText: _isFrame ? 'Target (kg/hr)' : 'Target (ft/hr)',
          ),
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

  void _confirmDelete(BuildContext context, MasterTargetEntry entry) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry'),
        content: Text(
          'Delete target for ${entry.key}${entry.density != null ? ' × ${entry.density}' : ''}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<AdminBloc>().add(
                DeleteMasterTargetEntry(lookupType, entry.id),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Scrap Target Page (simple product → target table) ────────────────────

class _ScrapTargetPage extends StatelessWidget {
  final String title;
  const _ScrapTargetPage({required this.title});

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
            context.read<AdminBloc>().add(
              const LoadMasterLookup(MasterLookupType.scrapTargets),
            );
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
          if (state is MasterTargetsLoaded &&
              state.lookupType == MasterLookupType.scrapTargets) {
            if (state.entries.isEmpty) {
              return const EmptyStateWidget(
                message: 'No entries yet. Tap + to add.',
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _tableHeader(),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: state.entries.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) =>
                        _scrapRow(context, state.entries[i]),
                  ),
                ),
              ],
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      color: AppTheme.accentAmber.withValues(alpha: 0.15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Product',
              style: GoogleFonts.sourceCodePro(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            'Target (kg/hr)',
            style: GoogleFonts.sourceCodePro(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 72),
        ],
      ),
    );
  }

  Widget _scrapRow(BuildContext context, MasterTargetEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              entry.key,
              style: GoogleFonts.sourceCodePro(fontSize: 12),
            ),
          ),
          Text(
            entry.target.toStringAsFixed(1),
            style: GoogleFonts.sourceCodePro(fontSize: 12),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                  color: AppTheme.accentAmber,
                ),
                onPressed: () => _showEditDialog(context, entry),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                onPressed: () => context.read<AdminBloc>().add(
                  DeleteMasterTargetEntry(
                    MasterLookupType.scrapTargets,
                    entry.id,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final kCtrl = TextEditingController();
    final vCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Scrap Target'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: kCtrl,
              decoration: const InputDecoration(labelText: 'Product'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: vCtrl,
              decoration: const InputDecoration(labelText: 'Target (kg/hr)'),
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
                  MasterLookupType.scrapTargets,
                  MasterTargetEntry(
                    id: '',
                    key: kCtrl.text.trim(),
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing.key),
        content: TextField(
          controller: vCtrl,
          decoration: const InputDecoration(labelText: 'Target (kg/hr)'),
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
                  MasterLookupType.scrapTargets,
                  MasterTargetEntry(
                    id: existing.id,
                    key: existing.key,
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

// ─── Salary Weightages Page ────────────────────────────────────────────────

class _SalaryWeightagesPage extends StatefulWidget {
  final String title;
  const _SalaryWeightagesPage({required this.title});

  @override
  State<_SalaryWeightagesPage> createState() => _SalaryWeightagesPageState();
}

class _SalaryWeightagesPageState extends State<_SalaryWeightagesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: 'Frame / Sheet'),
            Tab(text: 'Scrap'),
          ],
        ),
      ),
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
            final frameSheet = state.entries
                .where((e) => e.category == 'frame_sheet')
                .toList();
            final scrap = state.entries
                .where((e) => e.category == 'scrap')
                .toList();
            return TabBarView(
              controller: _tab,
              children: [
                _weightageTable(context, frameSheet),
                _weightageTable(context, scrap),
              ],
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _weightageTable(
    BuildContext context,
    List<MasterSalaryWeightageEntry> entries,
  ) {
    if (entries.isEmpty) {
      return const EmptyStateWidget(message: 'No weightages configured.');
    }

    final total = entries.fold<double>(0, (s, e) => s + e.percentage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Table header
        Container(
          color: AppTheme.accentAmber.withValues(alpha: 0.15),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  'Var',
                  style: GoogleFonts.sourceCodePro(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Label',
                  style: GoogleFonts.sourceCodePro(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  '%',
                  style: GoogleFonts.sourceCodePro(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: ListView.separated(
            itemCount: entries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) => _weightageRow(context, entries[i]),
          ),
        ),
        // Total row
        Container(
          color: Colors.grey.withValues(alpha: 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const Spacer(),
              Text(
                'Total: ${total.toStringAsFixed(1)} %',
                style: GoogleFonts.sourceCodePro(
                  fontWeight: FontWeight.bold,
                  color: total == 100 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weightageRow(BuildContext context, MasterSalaryWeightageEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              entry.variable,
              style: GoogleFonts.sourceCodePro(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(entry.label, style: const TextStyle(fontSize: 13)),
          ),
          SizedBox(
            width: 70,
            child: Text(
              '${entry.percentage.toStringAsFixed(1)} %',
              style: GoogleFonts.sourceCodePro(fontSize: 13),
              textAlign: TextAlign.right,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18, color: AppTheme.accentAmber),
            onPressed: () => _showEditDialog(context, entry),
          ),
        ],
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
