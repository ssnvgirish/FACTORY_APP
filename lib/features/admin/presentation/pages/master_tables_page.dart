import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/admin_entities.dart';
import '../bloc/admin_bloc.dart';

/// Displays a list of all master dropdown tables for admin management.
class MasterTablesPage extends StatelessWidget {
  const MasterTablesPage({super.key});

  static const _tables = <_MasterTableInfo>[
    _MasterTableInfo(
      MasterTableType.machines,
      'Machines',
      Icons.precision_manufacturing,
      hasType: true,
    ),
    _MasterTableInfo(MasterTableType.shifts, 'Shifts', Icons.schedule),
    _MasterTableInfo(
      MasterTableType.roles,
      'Roles',
      Icons.badge,
      hasDisplayName: true,
    ),
    _MasterTableInfo(
      MasterTableType.frameSections,
      'Frame Sections',
      Icons.view_column,
    ),
    _MasterTableInfo(
      MasterTableType.frameDensities,
      'Frame Densities',
      Icons.density_small,
    ),
    _MasterTableInfo(
      MasterTableType.frameColors,
      'Frame Colors',
      Icons.palette,
    ),
    _MasterTableInfo(
      MasterTableType.sheetThicknesses,
      'Sheet Thicknesses',
      Icons.layers,
    ),
    _MasterTableInfo(
      MasterTableType.sheetDensities,
      'Sheet Densities',
      Icons.density_small,
    ),
    _MasterTableInfo(
      MasterTableType.sheetColors,
      'Sheet Colors',
      Icons.palette,
    ),
    _MasterTableInfo(
      MasterTableType.maintenanceItems,
      'Maintenance Items',
      Icons.build,
      hasType: true,
    ),
    _MasterTableInfo(
      MasterTableType.scrapProducts,
      'Scrap Products',
      Icons.recycling,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Tables')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tables.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final info = _tables[i];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryNavy.withValues(alpha: 0.12),
                child: Icon(info.icon, color: AppTheme.primaryNavy),
              ),
              title: Text(
                info.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.read<AdminBloc>().add(LoadMasterTable(info.tableType));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _MasterTableEditPage(info: info),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MasterTableInfo {
  final MasterTableType tableType;
  final String label;
  final IconData icon;
  final bool hasType;
  final bool hasDisplayName;

  const _MasterTableInfo(
    this.tableType,
    this.label,
    this.icon, {
    this.hasType = false,
    this.hasDisplayName = false,
  });
}

class _MasterTableEditPage extends StatelessWidget {
  final _MasterTableInfo info;
  const _MasterTableEditPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(info.label)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(context, null),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is MasterItemSaved) {
            context.read<AdminBloc>().add(LoadMasterTable(info.tableType));
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
          if (state is MasterTableLoaded && state.tableType == info.tableType) {
            if (state.items.isEmpty) {
              return const EmptyStateWidget(message: 'No items yet');
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length,
              itemBuilder: (context, i) => _ItemCard(
                item: state.items[i],
                info: info,
                onEdit: () => _showItemDialog(context, state.items[i]),
                onDelete: () {
                  context.read<AdminBloc>().add(
                    DeleteMasterItemRequested(
                      info.tableType,
                      state.items[i].id,
                    ),
                  );
                },
                onToggleActive: () {
                  final item = state.items[i];
                  context.read<AdminBloc>().add(
                    UpdateMasterItemRequested(
                      info.tableType,
                      item.copyWith(isActive: !item.isActive),
                    ),
                  );
                },
              ),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  void _showItemDialog(BuildContext context, MasterTableItem? existing) {
    final valueCtrl = TextEditingController(text: existing?.value ?? '');
    final typeCtrl = TextEditingController(text: existing?.type ?? '');
    final displayCtrl = TextEditingController(
      text: existing?.displayName ?? '',
    );
    final sortCtrl = TextEditingController(
      text: (existing?.sortOrder ?? 0).toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Add Item' : 'Edit Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: valueCtrl,
                decoration: InputDecoration(
                  labelText: info.hasDisplayName ? 'Code' : 'Name / Value',
                ),
              ),
              if (info.hasDisplayName) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: displayCtrl,
                  decoration: const InputDecoration(labelText: 'Display Name'),
                ),
              ],
              if (info.hasType) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: typeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Type / Category',
                    hintText: 'e.g. frame, sheet, scrap',
                  ),
                ),
              ],
              const SizedBox(height: 8),
              TextField(
                controller: sortCtrl,
                decoration: const InputDecoration(labelText: 'Sort Order'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final item = MasterTableItem(
                id: existing?.id ?? '',
                value: valueCtrl.text.trim(),
                type: info.hasType ? typeCtrl.text.trim() : null,
                displayName: info.hasDisplayName
                    ? displayCtrl.text.trim()
                    : null,
                sortOrder: int.tryParse(sortCtrl.text) ?? 0,
                isActive: existing?.isActive ?? true,
              );
              if (existing == null) {
                context.read<AdminBloc>().add(
                  InsertMasterItemRequested(info.tableType, item),
                );
              } else {
                context.read<AdminBloc>().add(
                  UpdateMasterItemRequested(info.tableType, item),
                );
              }
              Navigator.pop(ctx);
            },
            child: Text(existing == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final MasterTableItem item;
  final _MasterTableInfo info;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  const _ItemCard({
    required this.item,
    required this.info,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: item.isActive ? null : Colors.grey.shade100,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        title: Text(
          info.hasDisplayName
              ? '${item.value} — ${item.displayName ?? ''}'
              : item.value,
          style: TextStyle(
            decoration: item.isActive ? null : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Text(
          [
            if (item.type != null) 'Type: ${item.type}',
            'Order: ${item.sortOrder}',
            item.isActive ? 'Active' : 'Inactive',
          ].join(' · '),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                item.isActive ? Icons.toggle_on : Icons.toggle_off,
                color: item.isActive ? AppTheme.successGreen : Colors.grey,
              ),
              onPressed: onToggleActive,
              tooltip: item.isActive ? 'Deactivate' : 'Activate',
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: AppTheme.accentAmber,
                size: 20,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
