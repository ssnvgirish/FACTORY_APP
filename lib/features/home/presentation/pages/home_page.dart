import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/wudsy_nfc_logo.png',
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              const Text('Home'),
            ],
          ),
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.window), text: 'Frames'),
              Tab(icon: Icon(Icons.layers), text: 'Sheets'),
              Tab(icon: Icon(Icons.recycling), text: 'Scrap Regrind'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: const TabBarView(
          children: [
            _FrameReportsList(),
            _SheetReportsList(),
            _ScrapRegrindReportsList(),
          ],
        ),
      ),
    );
  }
}

class _FrameReportsList extends StatelessWidget {
  const _FrameReportsList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ReportTile(
          icon: Icons.cleaning_services,
          title: 'Machine Cleaning Report',
          subtitle: 'Weekly — Evaluated by Frames Senior Operator',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/cleaning'),
        ),
        _ReportTile(
          icon: Icons.build_circle,
          title: 'Tools Count Report',
          subtitle: 'Weekly — Evaluated by Frames Senior Operator',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/tools'),
        ),
        _ReportTile(
          icon: Icons.health_and_safety,
          title: 'Machine Health Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/health'),
        ),
        _ReportTile(
          icon: Icons.precision_manufacturing,
          title: 'Production Details Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/production'),
        ),
        _ReportTile(
          icon: Icons.monitor_weight,
          title: 'Production Weight Report',
          subtitle: 'Daily — Auto-calculated',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/weight'),
        ),
        _ReportTile(
          icon: Icons.inventory_2,
          title: 'Shift Packing Report',
          subtitle: 'Daily — Evaluated by Quality Supervisor',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/packing'),
        ),
        _ReportTile(
          icon: Icons.timer,
          title: 'Report Writing Efficiency',
          subtitle: 'Daily — Auto-generated',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/writing-efficiency'),
        ),
        _ReportTile(
          icon: Icons.report_problem,
          title: 'Customer Rejection Report',
          subtitle: 'Ad hoc — Evaluated by Frames Senior Operator',
          color: AppTheme.accentAmber,
          onTap: () => context.push('/frames/customer-rejection'),
        ),
      ],
    );
  }
}

class _SheetReportsList extends StatelessWidget {
  const _SheetReportsList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ReportTile(
          icon: Icons.cleaning_services,
          title: 'Machine Cleaning Report',
          subtitle: 'Weekly — Evaluated by Sheet Senior Operator',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/cleaning'),
        ),
        _ReportTile(
          icon: Icons.build_circle,
          title: 'Tools Count Report',
          subtitle: 'Weekly — Evaluated by Sheet Senior Operator',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/tools'),
        ),
        _ReportTile(
          icon: Icons.health_and_safety,
          title: 'Machine Health Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/health'),
        ),
        _ReportTile(
          icon: Icons.precision_manufacturing,
          title: 'Production Details Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/production'),
        ),
        _ReportTile(
          icon: Icons.straighten,
          title: 'Running Feet Calculation',
          subtitle: 'Daily — Auto-calculated',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/running-feet'),
        ),
        _ReportTile(
          icon: Icons.inventory_2,
          title: 'Shift Packing Report',
          subtitle: 'Daily — Evaluated by Quality Supervisor',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/packing'),
        ),
        _ReportTile(
          icon: Icons.timer,
          title: 'Report Writing Efficiency',
          subtitle: 'Daily — Auto-generated',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/writing-efficiency'),
        ),
        _ReportTile(
          icon: Icons.report_problem,
          title: 'Customer Rejection Report',
          subtitle: 'Ad hoc — Evaluated by Sheet Senior Operator',
          color: AppTheme.pendingBlue,
          onTap: () => context.push('/sheets/customer-rejection'),
        ),
      ],
    );
  }
}

class _ScrapRegrindReportsList extends StatelessWidget {
  const _ScrapRegrindReportsList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ReportTile(
          icon: Icons.cleaning_services,
          title: 'Machine Cleaning Report',
          subtitle: 'Weekly — Evaluated by Senior Operator',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/cleaning'),
        ),
        _ReportTile(
          icon: Icons.build_circle,
          title: 'Tools Count Report',
          subtitle: 'Weekly — Evaluated by Senior Operator',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/tools'),
        ),
        _ReportTile(
          icon: Icons.health_and_safety,
          title: 'Machine Health Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/health'),
        ),
        _ReportTile(
          icon: Icons.precision_manufacturing,
          title: 'Production Details Report',
          subtitle: 'Daily — Evaluated by Machine Operator',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/production'),
        ),
        _ReportTile(
          icon: Icons.monitor_weight,
          title: 'Production Weight Report',
          subtitle: 'Daily — Auto-calculated',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/weight'),
        ),
        _ReportTile(
          icon: Icons.timer,
          title: 'Report Writing Efficiency',
          subtitle: 'Daily — Auto-generated',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/writing-efficiency'),
        ),
        _ReportTile(
          icon: Icons.verified,
          title: 'Scrap Quality Report',
          subtitle: 'Daily — Evaluated by Frame/Sheet Operator',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/quality'),
        ),
        _ReportTile(
          icon: Icons.calculate,
          title: 'Salary Multiplier',
          subtitle: 'Monthly — Auto-calculated',
          color: AppTheme.successGreen,
          onTap: () => context.push('/scrap-regrind/salary'),
        ),
      ],
    );
  }
}

class _ReportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ReportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
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
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
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
