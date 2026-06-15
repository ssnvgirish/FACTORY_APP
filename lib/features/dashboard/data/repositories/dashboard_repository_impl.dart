import '../../domain/entities/dashboard_entities.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource _datasource;

  DashboardRepositoryImpl(this._datasource);

  @override
  Future<DashboardSummary> getDashboardSummary() =>
      _datasource.getDashboardSummary();
}
