import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/dataconnect/default.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/frames/data/datasources/frame_remote_datasource.dart';
import '../../features/frames/data/repositories/frame_repository_impl.dart';
import '../../features/frames/domain/repositories/frame_repository.dart';
import '../../features/frames/presentation/bloc/frame_reports_bloc.dart';
import '../../features/sheets/data/datasources/sheet_remote_datasource.dart';
import '../../features/sheets/data/repositories/sheet_repository_impl.dart';
import '../../features/sheets/domain/repositories/sheet_repository.dart';
import '../../features/sheets/presentation/bloc/sheet_reports_bloc.dart';
import '../../features/salary/data/datasources/salary_remote_datasource.dart';
import '../../features/salary/data/repositories/salary_repository_impl.dart';
import '../../features/salary/domain/repositories/salary_repository.dart';
import '../../features/salary/presentation/bloc/salary_bloc.dart';
import '../../features/admin/data/datasources/admin_remote_datasource.dart';
import '../../features/admin/data/repositories/admin_repository_impl.dart';
import '../../features/admin/domain/repositories/admin_repository.dart';
import '../../features/admin/presentation/bloc/admin_bloc.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/scrap_regrind/data/datasources/scrap_regrind_remote_datasource.dart';
import '../../features/scrap_regrind/data/repositories/scrap_regrind_repository_impl.dart';
import '../../features/scrap_regrind/domain/repositories/scrap_regrind_repository.dart';
import '../../features/scrap_regrind/presentation/bloc/scrap_regrind_bloc.dart';
import '../services/dropdown_config_provider.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DefaultConnector.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(connector: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<FrameRemoteDataSource>(
    () => FrameRemoteDataSourceImpl(connector: sl()),
  );
  sl.registerLazySingleton<SheetRemoteDataSource>(
    () => SheetRemoteDataSourceImpl(connector: sl()),
  );
  sl.registerLazySingleton<SalaryRemoteDataSource>(
    () => SalaryRemoteDataSourceImpl(connector: sl()),
  );
  sl.registerLazySingleton(() => AdminRemoteDatasource(connector: sl()));
  sl.registerLazySingleton(() => DashboardRemoteDatasource(connector: sl()));
  sl.registerLazySingleton<ScrapRegrindRemoteDataSource>(
    () => ScrapRegrindRemoteDataSourceImpl(connector: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FrameRepository>(
    () => FrameRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SheetRepository>(
    () => SheetRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SalaryRepository>(
    () => SalaryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(sl<AdminRemoteDatasource>()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl<DashboardRemoteDatasource>()),
  );
  sl.registerLazySingleton<ScrapRegrindRepository>(
    () => ScrapRegrindRepositoryImpl(remoteDataSource: sl()),
  );

  // Services
  sl.registerLazySingleton(() => DropdownConfigProvider(adminRepository: sl()));

  // BLoCs
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(
    () => FrameReportsBloc(
      frameRepository: sl(),
      frameTargets: sl<DropdownConfigProvider>().frameTargets,
    ),
  );
  sl.registerFactory(() => SheetReportsBloc(sheetRepository: sl()));
  sl.registerFactory(() => SalaryBloc(salaryRepository: sl()));
  sl.registerFactory(() => AdminBloc(sl()));
  sl.registerFactory(() => DashboardBloc(sl()));
  sl.registerFactory(() => ScrapRegrindBloc(scrapRegrindRepository: sl()));
}
