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
        separatorBuilder: (_, _) => const SizedBox(height: 8),
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

class _MasterTableEditPage extends StatefulWidget {
  final _MasterTableInfo info;
  const _MasterTableEditPage({required this.info});

  @override
  State<_MasterTableEditPage> createState() => _MasterTableEditPageState();
}

class _MasterTableEditPageState extends State<_MasterTableEditPage> {
  /// Last successfully loaded rows. Kept so a failed save leaves the list on
  /// screen instead of replacing it with an indefinite spinner.
  List<MasterTableItem>? _items;

  _MasterTableInfo get _info => widget.info;

  void _reload() =>
      context.read<AdminBloc>().add(LoadMasterTable(_info.tableType));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_info.label)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(null),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is MasterTableLoaded &&
              state.tableType == _info.tableType) {
            setState(() => _items = state.items);
          }
          if (state is MasterItemSaved && state.tableType == _info.tableType) {
            _reload();
          }
          if (state is AdminError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(_friendlyError(state.message, _info.label)),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 6),
                ),
              );
          }
        },
        builder: (context, state) {
          final items = _items;
          if (items == null) {
            if (state is AdminError) {
              return EmptyStateWidget(
                message: _friendlyError(state.message, _info.label),
                icon: Icons.error_outline,
                actionLabel: 'Retry',
                onAction: _reload,
              );
            }
            return const LoadingWidget();
          }
          if (items.isEmpty) {
            return const EmptyStateWidget(message: 'No items yet');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, i) => _ItemCard(
              item: items[i],
              info: _info,
              onEdit: () => _showItemDialog(items[i]),
              onDelete: () => _confirmDelete(items[i]),
              onToggleActive: () {
                final item = items[i];
                context.read<AdminBloc>().add(
                  UpdateMasterItemRequested(
                    _info.tableType,
                    item.copyWith(isActive: !item.isActive),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _showItemDialog(MasterTableItem? existing) async {
    final items = _items ?? const <MasterTableItem>[];
    final result = await showDialog<MasterTableItem>(
      context: context,
      builder: (_) => _ItemDialog(
        info: _info,
        existing: existing,
        takenValues: items
            .where((i) => i.id != existing?.id)
            .map((i) => i.value.trim().toLowerCase())
            .toSet(),
        nextSortOrder:
            items.fold(-1, (m, i) => i.sortOrder > m ? i.sortOrder : m) + 1,
      ),
    );
    if (result == null || !mounted) return;

    context.read<AdminBloc>().add(
      existing == null
          ? InsertMasterItemRequested(_info.tableType, result)
          : UpdateMasterItemRequested(_info.tableType, result),
    );
  }

  Future<void> _confirmDelete(MasterTableItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete item?'),
        content: Text(
          '"${item.value}" will be removed from ${_info.label}.\n\n'
          'If it is already used in weight or production-target tables, '
          'deactivate it instead — deleting will be rejected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    context.read<AdminBloc>().add(
      DeleteMasterItemRequested(_info.tableType, item.id),
    );
  }
}

/// Turns raw Data Connect / Postgres failures into something an admin can act
/// on. Master values are referenced by name from the weight and target tables,
/// so constraint violations are the common failure here.
String _friendlyError(String raw, String label) {
  final lower = raw.toLowerCase();
  if (lower.contains('foreign key') ||
      lower.contains('still referenced') ||
      lower.contains('violates')) {
    return 'This $label value is still used by the weight or production-target '
        'tables. Remove those rows under Reference Tables first, or deactivate '
        'this item instead of deleting it.';
  }
  if (lower.contains('unique') || lower.contains('duplicate')) {
    return 'That value already exists in $label.';
  }
  if (lower.contains('permission') || lower.contains('unauthorized')) {
    return 'You do not have permission to change $label.';
  }
  if (lower.contains('socket') ||
      lower.contains('network') ||
      lower.contains('timeout') ||
      lower.contains('unavailable')) {
    return 'Could not reach the server. Check your connection and try again.';
  }
  return '$label could not be saved: $raw';
}

class _ItemDialog extends StatefulWidget {
  final _MasterTableInfo info;
  final MasterTableItem? existing;
  final Set<String> takenValues;
  final int nextSortOrder;

  const _ItemDialog({
    required this.info,
    required this.existing,
    required this.takenValues,
    required this.nextSortOrder,
  });

  @override
  State<_ItemDialog> createState() => _ItemDialogState();
}

class _ItemDialogState extends State<_ItemDialog> {
  late final TextEditingController _valueCtrl;
  late final TextEditingController _typeCtrl;
  late final TextEditingController _displayCtrl;
  late final TextEditingController _sortCtrl;
  String? _valueError;

  bool get _isNew => widget.existing == null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _valueCtrl = TextEditingController(text: existing?.value ?? '');
    _typeCtrl = TextEditingController(text: existing?.type ?? '');
    _displayCtrl = TextEditingController(text: existing?.displayName ?? '');
    _sortCtrl = TextEditingController(
      text: (existing?.sortOrder ?? widget.nextSortOrder).toString(),
    );
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _typeCtrl.dispose();
    _displayCtrl.dispose();
    _sortCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _valueCtrl.text.trim();
    if (value.isEmpty) {
      setState(() => _valueError = 'Required');
      return;
    }
    if (widget.takenValues.contains(value.toLowerCase())) {
      setState(() => _valueError = 'This value already exists');
      return;
    }

    Navigator.pop(
      context,
      MasterTableItem(
        id: widget.existing?.id ?? '',
        value: value,
        type: widget.info.hasType ? _typeCtrl.text.trim() : null,
        displayName: widget.info.hasDisplayName
            ? _displayCtrl.text.trim()
            : null,
        sortOrder: int.tryParse(_sortCtrl.text.trim()) ?? 0,
        isActive: widget.existing?.isActive ?? true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isNew ? 'Add Item' : 'Edit Item'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _valueCtrl,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: widget.info.hasDisplayName ? 'Code' : 'Name / Value',
                errorText: _valueError,
              ),
              onChanged: (_) {
                if (_valueError != null) setState(() => _valueError = null);
              },
              onSubmitted: (_) => _submit(),
            ),
            if (widget.info.hasDisplayName) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _displayCtrl,
                decoration: const InputDecoration(labelText: 'Display Name'),
              ),
            ],
            if (widget.info.hasType) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _typeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Type / Category',
                  hintText: 'e.g. frame, sheet, scrap',
                ),
              ),
            ],
            const SizedBox(height: 8),
            TextField(
              controller: _sortCtrl,
              decoration: const InputDecoration(labelText: 'Sort Order'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(_isNew ? 'Add' : 'Save'),
        ),
      ],
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
