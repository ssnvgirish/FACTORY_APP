import '../../../../core/utils/calculations.dart';
import '../../domain/entities/salary_entities.dart';
import '../../domain/repositories/salary_repository.dart';
import '../datasources/salary_remote_datasource.dart';

class SalaryRepositoryImpl implements SalaryRepository {
  final SalaryRemoteDataSource remoteDataSource;

  SalaryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SalaryWeightages> getWeightages() => remoteDataSource.getWeightages();

  @override
  Future<SalaryCalculation> calculateSalary(
    String operatorId,
    int year,
    int month,
  ) async {
    final weightages = await remoteDataSource.getWeightages();
    final aggregates = await remoteDataSource.getOperatorAggregates(
      operatorId,
      year,
      month,
    );
    final fixedSalary = await remoteDataSource.getFixedSalary(operatorId);
    final operatorName = await remoteDataSource.getOperatorName(operatorId);

    final a = aggregates['a'] ?? 0;
    final b = aggregates['b'] ?? 0;
    final c = aggregates['c'] ?? 0;
    final d = aggregates['d'] ?? 0;
    final e = aggregates['e'] ?? 0;
    final f = aggregates['f'] ?? 0;

    final multiplier = Calculations.totalSalaryMultiplier(
      a: a,
      b: b,
      c: c,
      d: d,
      e: e,
      f: f,
      wA: weightages.wA,
      wB: weightages.wB,
      wC: weightages.wC,
      wD: weightages.wD,
      wE: weightages.wE,
      wF: weightages.wF,
    );

    final salary = Calculations.monthlySalary(fixedSalary, multiplier);

    return SalaryCalculation(
      operatorId: operatorId,
      operatorName: operatorName,
      year: year,
      month: month,
      a: a,
      b: b,
      c: c,
      d: d,
      e: e,
      f: f,
      wA: weightages.wA,
      wB: weightages.wB,
      wC: weightages.wC,
      wD: weightages.wD,
      wE: weightages.wE,
      wF: weightages.wF,
      multiplier: multiplier,
      fixedSalary: fixedSalary,
      calculatedSalary: salary,
    );
  }

  @override
  Future<void> saveSalaryCalculation(SalaryCalculation calculation) =>
      remoteDataSource.saveSalaryCalculation(calculation);

  @override
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) => remoteDataSource.getSavedCalculation(operatorId, year, month);

  @override
  Future<List<SalaryCalculation>> getCalculationsForMonth(
    int year,
    int month,
  ) => remoteDataSource.getCalculationsForMonth(year, month);
}
