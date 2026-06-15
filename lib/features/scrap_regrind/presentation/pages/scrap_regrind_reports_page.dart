import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class ScrapRegrindReportsPage extends StatelessWidget {
  const ScrapRegrindReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrap Regrind Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportTile(
            icon: Icons.cleaning_services,
            title: 'Machine Cleaning Report',
            subtitle: 'Weekly — Evaluated by Senior Operator',
            onTap: () => context.push('/scrap-regrind/cleaning'),
          ),
          _ReportTile(
            icon: Icons.build_circle,
            title: 'Tools Count Report',
            subtitle: 'Weekly — Evaluated by Senior Operator',
            onTap: () => context.push('/scrap-regrind/tools'),
          ),
          _ReportTile(
            icon: Icons.health_and_safety,
            title: 'Machine Health Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/scrap-regrind/health'),
          ),
          _ReportTile(
            icon: Icons.precision_manufacturing,
            title: 'Production Details Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/scrap-regrind/production'),
          ),
          _ReportTile(
            icon: Icons.monitor_weight,
            title: 'Production Weight Report',
            subtitle: 'Daily — Auto-calculated',
            onTap: () => context.push('/scrap-regrind/weight'),
          ),
          _ReportTile(
            icon: Icons.timer,
            title: 'Report Writing Efficiency',
            subtitle: 'Daily — Auto-generated',
            onTap: () => context.push('/scrap-regrind/writing-efficiency'),
          ),
          _ReportTile(
            icon: Icons.verified,
            title: 'Scrap Quality Report',
            subtitle: 'Daily — Evaluated by Frame/Sheet Operator',
            onTap: () => context.push('/scrap-regrind/quality'),
          ),
          _ReportTile(
            icon: Icons.calculate,
            title: 'Salary Multiplier',
            subtitle: 'Monthly — Auto-calculated',
            onTap: () => context.push('/scrap-regrind/salary'),
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
            color: AppTheme.accentAmber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.accentAmber),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
