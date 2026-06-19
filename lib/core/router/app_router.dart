import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/reports_tab_page.dart';
import '../../features/dashboard/presentation/pages/report_results_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/frames/presentation/pages/frame_reports_page.dart';
import '../../features/frames/presentation/pages/frame_cleaning_report_list_page.dart';
import '../../features/frames/presentation/pages/frame_tools_count_list_page.dart';
import '../../features/frames/presentation/pages/frame_health_report_list_page.dart';
import '../../features/frames/presentation/pages/frame_pending_approvals_page.dart';
import '../../features/frames/presentation/pages/frame_production_details_list_page.dart';
import '../../features/frames/presentation/pages/frame_weight_report_page.dart';
import '../../features/frames/presentation/pages/frame_packing_report_list_page.dart';
import '../../features/frames/presentation/pages/frame_writing_efficiency_page.dart';
import '../../features/frames/presentation/pages/frame_customer_rejection_list_page.dart';
import '../../features/frames/presentation/pages/frame_production_calendar_page.dart';
import '../../features/frames/presentation/pages/frame_packing_calendar_page.dart';
import '../../features/frames/presentation/pages/frame_maintenance_calendar_page.dart';
import '../../features/frames/presentation/pages/frame_operator_monthly_page.dart';
import '../../features/frames/presentation/pages/frame_machine_monthly_page.dart';
import '../../features/sheets/presentation/pages/sheet_reports_page.dart';
import '../../features/sheets/presentation/pages/sheet_production_details_list_page.dart';
import '../../features/sheets/presentation/pages/sheet_cleaning_report_list_page.dart';
import '../../features/sheets/presentation/pages/sheet_tools_count_list_page.dart';
import '../../features/sheets/presentation/pages/sheet_health_report_list_page.dart';
import '../../features/sheets/presentation/pages/sheet_running_feet_page.dart';
import '../../features/sheets/presentation/pages/sheet_packing_report_list_page.dart';
import '../../features/sheets/presentation/pages/sheet_writing_efficiency_page.dart';
import '../../features/sheets/presentation/pages/sheet_customer_rejection_list_page.dart';
import '../../features/salary/presentation/pages/salary_dashboard_page.dart';
import '../../features/admin/presentation/pages/admin_panel_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_regrind_reports_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_cleaning_report_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_tools_count_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_health_report_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_production_details_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_weight_report_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_writing_efficiency_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_quality_report_list_page.dart';
import '../../features/scrap_regrind/presentation/pages/scrap_salary_page.dart';

class AppRouter {
  final AuthBloc authBloc;
  late final GoRouter router;

  AppRouter({required this.authBloc}) {
    router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final authState = authBloc.state;
        final isAuthenticated = authState is AuthAuthenticated;
        final isOnLogin = state.matchedLocation == '/login';
        final isOnSplash = state.matchedLocation == '/splash';

        // Still loading auth — stay on splash
        if (authState is AuthInitial || authState is AuthLoading) {
          return isOnSplash ? null : '/splash';
        }

        // Auth resolved — redirect away from splash
        if (isOnSplash) {
          return isAuthenticated ? '/home' : '/login';
        }

        if (!isAuthenticated && !isOnLogin) return '/login';
        if (isAuthenticated && isOnLogin) return '/home';
        return null;
      },
      routes: [
        GoRoute(path: '/splash', builder: (_, s) => const SplashPage()),
        GoRoute(path: '/login', builder: (_, s) => const LoginPage()),
        ShellRoute(
          builder: (context, state, child) => _ScaffoldWithNav(child: child),
          routes: [
            GoRoute(path: '/home', builder: (_, s) => const HomePage()),
            GoRoute(
              path: '/report',
              builder: (_, s) => const ReportsTabPage(),
              routes: [
                GoRoute(
                  path: 'results/:type/:targetId/:targetName/:startTime/:endTime',
                  builder: (_, s) {
                    final type = s.pathParameters['type'] == 'machine'
                        ? ReportGenerationType.machineAndTimeRange
                        : ReportGenerationType.operatorWise;
                    final targetId = s.pathParameters['targetId'] ?? '';
                    final targetName = s.pathParameters['targetName'] ?? '';
                    final startTime =
                        int.tryParse(s.pathParameters['startTime'] ?? '0');
                    final endTime =
                        int.tryParse(s.pathParameters['endTime'] ?? '0');
                    final request = ReportRequest(
                      type: type,
                      target: ReportTarget(id: targetId, name: targetName),
                      start: startTime != null && startTime > 0
                          ? DateTime.fromMillisecondsSinceEpoch(startTime)
                          : null,
                      end: endTime != null && endTime > 0
                          ? DateTime.fromMillisecondsSinceEpoch(endTime)
                          : null,
                    );
                    return ReportResultsPage(request: request);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/dashboard',
              builder: (_, s) => const DashboardPage(),
            ),
            GoRoute(
              path: '/frames',
              builder: (_, s) => const FrameReportsPage(),
              routes: [
                GoRoute(
                  path: 'cleaning',
                  builder: (_, s) => const FrameCleaningReportListPage(),
                ),
                GoRoute(
                  path: 'tools',
                  builder: (_, s) => const FrameToolsCountListPage(),
                ),
                GoRoute(
                  path: 'health',
                  builder: (_, s) => const FrameHealthReportListPage(),
                ),
                GoRoute(
                  path: 'approvals',
                  builder: (_, s) => const FramePendingApprovalsPage(),
                ),
                GoRoute(
                  path: 'production',
                  builder: (_, s) => const FrameProductionDetailsListPage(),
                ),
                GoRoute(
                  path: 'weight',
                  builder: (_, s) => const FrameWeightReportListPage(),
                ),
                GoRoute(
                  path: 'packing',
                  builder: (_, s) => const FramePackingReportListPage(),
                ),
                GoRoute(
                  path: 'writing-efficiency',
                  builder: (_, s) => const FrameWritingEfficiencyPage(),
                ),
                GoRoute(
                  path: 'customer-rejection',
                  builder: (_, s) => const FrameCustomerRejectionListPage(),
                ),
                GoRoute(
                  path: 'production-calendar',
                  builder: (_, s) => const FrameProductionCalendarPage(),
                ),
                GoRoute(
                  path: 'packing-calendar',
                  builder: (_, s) => const FramePackingCalendarPage(),
                ),
                GoRoute(
                  path: 'maintenance-calendar',
                  builder: (_, s) => const FrameMaintenanceCalendarPage(),
                ),
                GoRoute(
                  path: 'operator-monthly',
                  builder: (_, s) => const FrameOperatorMonthlyReportsPage(),
                ),
                GoRoute(
                  path: 'machine-monthly',
                  builder: (_, s) => const FrameMachineMonthlyReportsPage(),
                ),
              ],
            ),
            GoRoute(
              path: '/sheets',
              builder: (_, s) => const SheetReportsPage(),
              routes: [
                GoRoute(
                  path: 'production',
                  builder: (_, s) => const SheetProductionDetailsListPage(),
                ),
                GoRoute(
                  path: 'cleaning',
                  builder: (_, s) => const SheetCleaningReportListPage(),
                ),
                GoRoute(
                  path: 'tools',
                  builder: (_, s) => const SheetToolsCountListPage(),
                ),
                GoRoute(
                  path: 'health',
                  builder: (_, s) => const SheetHealthReportListPage(),
                ),
                GoRoute(
                  path: 'running-feet',
                  builder: (_, s) => const SheetRunningFeetPage(machineId: ''),
                ),
                GoRoute(
                  path: 'packing',
                  builder: (_, s) => const SheetPackingReportListPage(),
                ),
                GoRoute(
                  path: 'writing-efficiency',
                  builder: (_, s) => const SheetWritingEfficiencyPage(),
                ),
                GoRoute(
                  path: 'customer-rejection',
                  builder: (_, s) => const SheetCustomerRejectionListPage(),
                ),
              ],
            ),
            GoRoute(
              path: '/salary',
              builder: (_, s) => const SalaryDashboardPage(),
            ),
            GoRoute(
              path: '/salary/:operatorId',
              builder: (_, state) => SalaryDashboardPage(
                operatorId: state.pathParameters['operatorId'],
              ),
            ),
            GoRoute(
              path: '/scrap-regrind',
              builder: (_, s) => const ScrapRegrindReportsPage(),
              routes: [
                GoRoute(
                  path: 'cleaning',
                  builder: (_, s) => const ScrapCleaningReportListPage(),
                ),
                GoRoute(
                  path: 'tools',
                  builder: (_, s) => const ScrapToolsCountListPage(),
                ),
                GoRoute(
                  path: 'health',
                  builder: (_, s) => const ScrapHealthReportListPage(),
                ),
                GoRoute(
                  path: 'production',
                  builder: (_, s) => const ScrapProductionDetailsListPage(),
                ),
                GoRoute(
                  path: 'weight',
                  builder: (_, s) => const ScrapWeightReportListPage(),
                ),
                GoRoute(
                  path: 'writing-efficiency',
                  builder: (_, s) => const ScrapWritingEfficiencyPage(),
                ),
                GoRoute(
                  path: 'quality',
                  builder: (_, s) => const ScrapQualityReportListPage(),
                ),
                GoRoute(
                  path: 'salary',
                  builder: (_, s) => const ScrapSalaryPage(),
                ),
              ],
            ),
            GoRoute(path: '/admin', builder: (_, s) => const AdminPanelPage()),
          ],
        ),
      ],
    );
  }
}

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        final destinations = _buildDestinations(user);

        return Scaffold(
          body: SizedBox.expand(child: child),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex(context, destinations),
            onDestinationSelected: (i) =>
                _onDestinationSelected(context, i, destinations),
            destinations: destinations.map((d) => d.destination).toList(),
          ),
        );
      },
    );
  }

  List<_NavItem> _buildDestinations(AppUser? user) {
    final items = <_NavItem>[
      const _NavItem(
        path: '/home',
        destination: NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
      ),
      const _NavItem(
        path: '/report',
        destination: NavigationDestination(
          icon: Icon(Icons.dashboard),
          label: 'Report',
        ),
      ),
    ];

    if (user != null && user.roles.contains('admin')) {
      items.add(
        const _NavItem(
          path: '/admin',
          destination: NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ),
      );
    }

    return items;
  }

  int _currentIndex(BuildContext context, List<_NavItem> items) {
    final location = GoRouterState.of(context).matchedLocation;
    // Frame/sheet/scrap sub-routes should highlight the Home tab
    if (location.startsWith('/frames') ||
        location.startsWith('/sheets') ||
        location.startsWith('/scrap-regrind')) {
      return 0;
    }
    for (var i = 0; i < items.length; i++) {
      if (location.startsWith(items[i].path)) return i;
    }
    return 0;
  }

  void _onDestinationSelected(
    BuildContext context,
    int index,
    List<_NavItem> items,
  ) {
    if (index < items.length) {
      context.go(items[index].path);
    }
  }
}

class _NavItem {
  final String path;
  final NavigationDestination destination;
  const _NavItem({required this.path, required this.destination});
}

/// Converts a Bloc stream into a ChangeNotifier for GoRouter refresh.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
