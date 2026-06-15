import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/services/dropdown_config_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/frames/presentation/bloc/frame_reports_bloc.dart';
import 'features/sheets/presentation/bloc/sheet_reports_bloc.dart';
import 'features/salary/presentation/bloc/salary_bloc.dart';
import 'features/admin/presentation/bloc/admin_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/scrap_regrind/presentation/bloc/scrap_regrind_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  await initDependencies();

  // Load dropdown configs from the backend.
  try {
    await sl<DropdownConfigProvider>().load();
  } catch (e) {
    debugPrint('Dropdown config load failed: $e');
  }

  runApp(const FactoryApp());
}

class FactoryApp extends StatefulWidget {
  const FactoryApp({super.key});

  @override
  State<FactoryApp> createState() => _FactoryAppState();
}

class _FactoryAppState extends State<FactoryApp> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>()..add(AuthCheckRequested());
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider(create: (_) => sl<FrameReportsBloc>()),
        BlocProvider(create: (_) => sl<SheetReportsBloc>()),
        BlocProvider(create: (_) => sl<SalaryBloc>()),
        BlocProvider(create: (_) => sl<AdminBloc>()),
        BlocProvider(create: (_) => sl<DashboardBloc>()),
        BlocProvider(create: (_) => sl<ScrapRegrindBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Factory Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
