import 'package:equatable/equatable.dart';

class SalaryCalculation extends Equatable {
  final String? id;
  final String operatorId;
  final String operatorName;
  final int year;
  final int month;
  final double a; // Machine Cleaning %
  final double b; // Tools Count %
  final double c; // Production Efficiency %
  final double d; // Quality Acceptance %
  final double e; // Packing Efficiency %
  final double f; // Report Writing Efficiency %
  final double wA, wB, wC, wD, wE, wF; // weightages
  final double multiplier;
  final double fixedSalary;
  final double calculatedSalary;

  const SalaryCalculation({
    this.id,
    required this.operatorId,
    required this.operatorName,
    required this.year,
    required this.month,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.wA,
    required this.wB,
    required this.wC,
    required this.wD,
    required this.wE,
    required this.wF,
    required this.multiplier,
    required this.fixedSalary,
    required this.calculatedSalary,
  });

  @override
  List<Object?> get props => [id, operatorId, year, month, multiplier, calculatedSalary];
}

class SalaryWeightages extends Equatable {
  final double wA;
  final double wB;
  final double wC;
  final double wD;
  final double wE;
  final double wF;

  const SalaryWeightages({
    required this.wA,
    required this.wB,
    required this.wC,
    required this.wD,
    required this.wE,
    required this.wF,
  });

  double get total => wA + wB + wC + wD + wE + wF;

  @override
  List<Object?> get props => [wA, wB, wC, wD, wE, wF];
}
