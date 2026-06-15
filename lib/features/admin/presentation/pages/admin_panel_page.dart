import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/utils/master_table_seeder.dart';
import '../bloc/admin_bloc.dart';
import 'user_management_page.dart';
import 'reference_tables_page.dart';
import 'master_tables_page.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Management'),
          _AdminTile(
            icon: Icons.people,
            title: 'User Management',
            subtitle: 'Create, edit, activate/deactivate operators',
            color: AppTheme.primaryNavy,
            onTap: () {
              context.read<AdminBloc>().add(LoadUsers());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserManagementPage()),
              );
            },
          ),
          const SizedBox(height: 12),
          _AdminTile(
            icon: Icons.table_chart,
            title: 'Reference Tables',
            subtitle: 'Weight tables, targets, salary weightages',
            color: AppTheme.accentOrange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReferenceTablesPage()),
            ),
          ),
          const SizedBox(height: 12),
          _AdminTile(
            icon: Icons.list_alt,
            title: 'Master Tables',
            subtitle: 'Machines, sections, densities, colors, etc.',
            color: AppTheme.successGreen,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MasterTablesPage()),
              );
            },
          ),
          const SizedBox(height: 12),
          _AdminTile(
            icon: Icons.payments,
            title: 'Salary Calculation Report',
            subtitle: 'View monthly salary calculations for all operators',
            color: AppTheme.primaryNavy,
            onTap: () => context.go('/salary'),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Utilities'),
          _AdminTile(
            icon: Icons.cloud_upload,
            title: 'Seed Master Tables',
            subtitle: 'Populate master tables from defaults',
            color: AppTheme.accentAmber,
            onTap: () => _seedMasterTables(context),
          ),
        ],
      ),
    );
  }

  void _seedMasterTables(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Seeding master tables...')),
    );
    try {
      final result = await MasterTableSeeder.seed();
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Text('Done! $result'),
          backgroundColor: AppTheme.successGreen,
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}

class _AdminTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AdminTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
