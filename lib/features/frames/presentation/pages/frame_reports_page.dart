import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class FrameReportsPage extends StatelessWidget {
  const FrameReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Frame Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportTile(
            icon: Icons.cleaning_services,
            title: 'Machine Cleaning Report',
            subtitle: 'Weekly — Evaluated by Frames Senior Operator',
            onTap: () => context.push('/frames/cleaning'),
          ),
          _ReportTile(
            icon: Icons.build_circle,
            title: 'Tools Count Report',
            subtitle: 'Weekly — Evaluated by Frames Senior Operator',
            onTap: () => context.push('/frames/tools'),
          ),
          _ReportTile(
            icon: Icons.health_and_safety,
            title: 'Machine Health Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/frames/health'),
          ),
          _ReportTile(
            icon: Icons.precision_manufacturing,
            title: 'Production Details Report',
            subtitle: 'Daily — Evaluated by Machine Operator',
            onTap: () => context.push('/frames/production'),
          ),
          _ReportTile(
            icon: Icons.monitor_weight,
            title: 'Production Weight Report',
            subtitle: 'Daily — Auto-calculated',
            onTap: () => context.push('/frames/weight'),
          ),
          _ReportTile(
            icon: Icons.inventory_2,
            title: 'Shift Packing Report',
            subtitle: 'Daily — Evaluated by Quality Supervisor',
            onTap: () => context.push('/frames/packing'),
          ),
          _ReportTile(
            icon: Icons.timer,
            title: 'Report Writing Efficiency',
            subtitle: 'Daily — Auto-generated',
            onTap: () => context.push('/frames/writing-efficiency'),
          ),
          _ReportTile(
            icon: Icons.report_problem,
            title: 'Customer Rejection Report',
            subtitle: 'Ad hoc — Evaluated by Frames Senior Operator',
            onTap: () => context.push('/frames/customer-rejection'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
            child: Text(
              'Calendar Views',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryNavy,
              ),
            ),
          ),
          _ReportTile(
            icon: Icons.calendar_month,
            title: 'Production Calendar',
            subtitle: 'Monthly calendar with per-day shift weights',
            onTap: () => context.push('/frames/production-calendar'),
          ),
          _ReportTile(
            icon: Icons.calendar_view_month,
            title: 'Packing Calendar',
            subtitle: 'Monthly calendar with per-day packing %',
            onTap: () => context.push('/frames/packing-calendar'),
          ),
          _ReportTile(
            icon: Icons.engineering,
            title: 'Maintenance Calendar',
            subtitle: 'Monthly calendar with per-day health %',
            onTap: () => context.push('/frames/maintenance-calendar'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
            child: Text(
              'Monthly Aggregates',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryNavy,
              ),
            ),
          ),
          _ReportTile(
            icon: Icons.person_search,
            title: 'Operator-wise Monthly',
            subtitle: 'All reports grouped by operator',
            onTap: () => context.push('/frames/operator-monthly'),
          ),
          _ReportTile(
            icon: Icons.precision_manufacturing_outlined,
            title: 'Machine-wise Monthly',
            subtitle: 'All reports grouped by machine',
            onTap: () => context.push('/frames/machine-monthly'),
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
          child: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
