import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class SheetReportsPage extends StatelessWidget {
  const SheetReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportTile(
            icon: Icons.cleaning_services,
            title: 'Machine Cleaning Report',
            subtitle: 'Weekly — Evaluated by Sheet Senior Operator',
            onTap: () => context.push('/sheets/cleaning'),
          ),
          _ReportTile(
            icon: Icons.build_circle,
            title: 'Tools Count Report',
            subtitle: 'Weekly — Evaluated by Sheet Senior Operator',
            onTap: () => context.push('/sheets/tools'),
          ),
          _ReportTile(
            icon: Icons.health_and_safety,
            title: 'Machine Health Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/sheets/health'),
          ),
          _ReportTile(
            icon: Icons.precision_manufacturing,
            title: 'Production Details Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/sheets/production'),
          ),
          _ReportTile(
            icon: Icons.straighten,
            title: 'Running Feet Calculation',
            subtitle: 'Daily — Auto-calculated',
            onTap: () => context.push('/sheets/running-feet'),
          ),
          _ReportTile(
            icon: Icons.inventory_2,
            title: 'Shift Packing Report',
            subtitle: 'Daily — Evaluated by Quality Supervisor',
            onTap: () => context.push('/sheets/packing'),
          ),
          _ReportTile(
            icon: Icons.timer,
            title: 'Report Writing Efficiency',
            subtitle: 'Daily — Auto-generated',
            onTap: () => context.push('/sheets/writing-efficiency'),
          ),
          _ReportTile(
            icon: Icons.report_problem,
            title: 'Customer Rejection Report',
            subtitle: 'Ad hoc — Evaluated by Sheet Senior Operator',
            onTap: () => context.push('/sheets/customer-rejection'),
          ),
        ],
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ReportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.pendingBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.pendingBlue),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
