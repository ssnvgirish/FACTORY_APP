import '../entities/salary_entities.dart';

abstract class SalaryRepository {
  Future<SalaryWeightages> getWeightages();
  Future<SalaryCalculation> calculateSalary(
    String operatorId,
    int year,
    int month,
  );
  Future<void> saveSalaryCalculation(SalaryCalculation calculation);
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  );
  Future<List<SalaryCalculation>> getCalculationsForMonth(int year, int month);
}
