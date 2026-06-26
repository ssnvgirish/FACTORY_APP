import 'dart:math';

/// All pure utility functions for production calculations.
class Calculations {
  Calculations._();

  // ═══════════════════════════════════════
  // CLEANING REPORT
  // ═══════════════════════════════════════

  static int cleaningTotalScore(int machine, int ground, int mould) {
    return machine + ground + mould;
  }

  static double cleaningPercentage(int totalScore) {
    return double.parse(((totalScore / 30) * 100).toStringAsFixed(2));
  }

  // ═══════════════════════════════════════
  // TOOLS COUNT (Rating-based: 3 items, 1-10 each, max 30)
  // ═══════════════════════════════════════

  static int toolsTotalScore(
    int condition,
    int availability,
    int organization,
  ) {
    return condition + availability + organization;
  }

  static double toolsPercentage(int totalScore) {
    return double.parse(((totalScore / 30) * 100).toStringAsFixed(2));
  }

  // ═══════════════════════════════════════
  // MACHINE HEALTH (Rating-based: N items, 1-10 each)
  // ═══════════════════════════════════════

  static int healthTotalScore(List<int> ratings) {
    return ratings.fold(0, (sum, r) => sum + r);
  }

  static double healthPercentage(int totalScore, int itemCount) {
    if (itemCount == 0) return 0;
    return double.parse(
      ((totalScore / (itemCount * 10)) * 100).toStringAsFixed(2),
    );
  }

  static Duration maintenanceDuration(DateTime startTime, DateTime endTime) {
    return endTime.difference(startTime);
  }

  static double maintenanceDurationHours(DateTime startTime, DateTime endTime) {
    final diff = endTime.difference(startTime);
    return diff.inMinutes / 60.0;
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  /// Returns capped duration in hours based on maintenance type and machine type.
  static double cappedMaintenanceDuration({
    required String maintenanceItem,
    required double actualHours,
    required bool isFrameMachine,
  }) {
    final maxDurations = isFrameMachine
        ? {'Die Change': 2.0, 'Die Cleaning': 1.0}
        : {'Die Change': 4.0, 'Die Cleaning': 2.0};

    final maxDuration = maxDurations[maintenanceItem];
    if (maxDuration != null && actualHours > maxDuration) {
      return maxDuration;
    }
    return actualHours;
  }

  /// Total maintenance duration of a shift (sum of capped durations).
  static double totalMaintenanceDuration({
    required List<Map<String, dynamic>> entries,
    required bool isFrameMachine,
  }) {
    double total = 0;
    for (final entry in entries) {
      final actual = entry['durationHours'] as double;
      final item = entry['maintenanceItem'] as String;
      total += cappedMaintenanceDuration(
        maintenanceItem: item,
        actualHours: actual,
        isFrameMachine: isFrameMachine,
      );
    }
    return total;
  }

  // ═══════════════════════════════════════
  // FRAME PRODUCTION
  // ═══════════════════════════════════════

  /// Per piece weight for frames: Length × Weight_per_foot
  static double framePerPieceWeight({
    required double lengthFeet,
    required double weightPerFoot,
  }) {
    return double.parse((lengthFeet * weightPerFoot).toStringAsFixed(3));
  }

  /// Total weight = Quantity × Per piece weight
  static double totalWeight(int quantity, double perPieceWeight) {
    return double.parse((quantity * perPieceWeight).toStringAsFixed(3));
  }

  /// Look up frame weight per foot from the weight table.
  static double? frameWeightPerFoot({
    required String section,
    required String density,
    required Map<String, Map<String, double>> weightTable,
  }) {
    return weightTable[section]?[density];
  }

  // ═══════════════════════════════════════
  // SHEET PRODUCTION
  // ═══════════════════════════════════════

  /// SQFT = (Length × Width) / 144  (inches to sqft)
  static double sheetSqft(double lengthInches, double widthInches) {
    return double.parse(
      ((lengthInches * widthInches) / 144).toStringAsFixed(3),
    );
  }

  /// Per piece weight for sheets: SQFT × Weight_per_sqft
  static double sheetPerPieceWeight(double sqft, double weightPerSqft) {
    return double.parse((sqft * weightPerSqft).toStringAsFixed(3));
  }

  /// Total running feet = (Length × Quantity) / 12
  static double totalRunningFeet(double lengthInches, int quantity) {
    return double.parse(((lengthInches * quantity) / 12).toStringAsFixed(3));
  }

  // ═══════════════════════════════════════
  // PRODUCTION WEIGHT / RUNNING FEET CALCULATION
  // ═══════════════════════════════════════

  /// Production efficiency percentage
  static double productionEfficiency(double actual, double target) {
    if (target == 0) return 0;
    return double.parse(((actual / target) * 100).toStringAsFixed(2));
  }

  /// Calculate target weight using time-of-change timestamps.
  /// Each segment has a section, optional density, and duration.
  /// Looks up by "section|density" first, then falls back to "section" alone.
  static double calculateTargetWeight({
    required List<Map<String, dynamic>> segments,
    required Map<String, double> targetPerHour,
  }) {
    double total = 0;
    for (final segment in segments) {
      final section = segment['section'] as String;
      final density = segment['density'] as String? ?? '';
      final hours = segment['durationHours'] as double;
      final targetRate =
          targetPerHour['$section|$density'] ?? targetPerHour[section] ?? 0;
      total += hours * targetRate;
    }
    return double.parse(total.toStringAsFixed(3));
  }

  /// Maintenance weight = maintenance hours × target rate for active section.
  static double maintenanceWeight(double maintenanceHours, double targetRate) {
    return double.parse((maintenanceHours * targetRate).toStringAsFixed(3));
  }

  // ═══════════════════════════════════════
  // PACKING REPORT
  // ═══════════════════════════════════════

  /// Quality acceptance percentage.
  static double qualityAcceptancePercentage(
    double totalProduction,
    double totalRejected,
  ) {
    if (totalProduction == 0) return 0;
    return double.parse(
      (((totalProduction - totalRejected) / totalProduction) * 100)
          .toStringAsFixed(2),
    );
  }

  /// Packing efficiency percentage.
  static double packingEfficiency(int totalProduced, int totalPacked) {
    if (totalProduced == 0) return 0;
    return double.parse(
      ((totalPacked / totalProduced) * 100).toStringAsFixed(2),
    );
  }

  // ═══════════════════════════════════════
  // REPORT WRITING EFFICIENCY
  // ═══════════════════════════════════════

  /// Calculate report writing score based on submission time vs shift end.
  static int reportWritingScore(
    DateTime submissionTime,
    DateTime shiftEndTime,
  ) {
    final diff = submissionTime.difference(shiftEndTime);
    final hours = diff.inMinutes / 60.0;

    if (hours <= 1) return 5;
    if (hours <= 6) return 4;
    if (hours <= 12) return 3;
    if (hours <= 24) return 2;
    return 0;
  }

  /// Get shift end time for a given date and shift.
  static DateTime shiftEndTime(DateTime date, String shift) {
    if (shift == 'Day Shift') {
      return DateTime(date.year, date.month, date.day, 21, 0); // 9 PM
    } else {
      // Night shift ends at 9 AM next day
      return DateTime(date.year, date.month, date.day + 1, 9, 0); // 9 AM
    }
  }

  // ═══════════════════════════════════════
  // SALARY MULTIPLIER
  // ═══════════════════════════════════════

  /// Calculate salary multiplier for a single variable.
  /// multiplier = (variableValue / 100) × (weightage / 100)
  static double variableMultiplier(double variableValue, double weightage) {
    return (variableValue / 100) * (weightage / 100);
  }

  /// Calculate total salary multiplier from all variables.
  static double totalSalaryMultiplier({
    required double a, // Machine Cleaning %
    required double b, // Tools Count %
    required double c, // Production Efficiency %
    required double d, // Quality Acceptance %
    required double e, // Packing Efficiency %
    required double f, // Report Writing Efficiency %
    required double wA,
    required double wB,
    required double wC,
    required double wD,
    required double wE,
    required double wF,
  }) {
    return variableMultiplier(a, wA) +
        variableMultiplier(b, wB) +
        variableMultiplier(c, wC) +
        variableMultiplier(d, wD) +
        variableMultiplier(e, wE) +
        variableMultiplier(f, wF);
  }

  /// Calculate monthly salary.
  static double monthlySalary(double fixedSalary, double multiplier) {
    return double.parse((fixedSalary * multiplier).toStringAsFixed(2));
  }

  /// Calculate monthly average from a list of values.
  static double monthlyAverage(List<double> values) {
    if (values.isEmpty) return 0;
    final sum = values.reduce((a, b) => a + b);
    return double.parse((sum / values.length).toStringAsFixed(2));
  }

  /// Derive production time segments from time-of-change entries.
  /// Returns list of {section, durationHours}.
  static List<Map<String, dynamic>> deriveProductionSegments({
    required List<Map<String, dynamic>> lineItems,
    required DateTime shiftStart,
    required DateTime shiftEnd,
  }) {
    final segments = <Map<String, dynamic>>[];
    if (lineItems.isEmpty) return segments;

    for (int i = 0; i < lineItems.length; i++) {
      final item = lineItems[i];
      final section = item['section'] as String;

      DateTime segStart;
      DateTime segEnd;

      if (i == 0) {
        segStart = shiftStart;
      } else {
        segStart = item['timeOfChange'] as DateTime? ?? shiftStart;
      }

      if (i < lineItems.length - 1) {
        segEnd = lineItems[i + 1]['timeOfChange'] as DateTime? ?? shiftEnd;
      } else {
        segEnd = shiftEnd;
      }

      final hours = segEnd.difference(segStart).inMinutes / 60.0;
      segments.add({'section': section, 'durationHours': max(0, hours)});
    }

    return segments;
  }

  // ═══════════════════════════════════════
  // SCRAP REGRIND SECTION
  // ═══════════════════════════════════════

  /// Scrap cleaning total score (2 items, 1-10 each, max 20).
  static int scrapCleaningTotalScore(
    int machineCondition,
    int groundCondition,
  ) {
    return machineCondition + groundCondition;
  }

  /// Scrap cleaning percentage (max 20).
  static double scrapCleaningPercentage(int totalScore) {
    return double.parse(((totalScore / 20) * 100).toStringAsFixed(2));
  }

  /// Scrap tools count percentage.
  static double scrapToolsPercentage(int toolsAvailable, int toolsGiven) {
    if (toolsGiven == 0) return 0;
    return double.parse(
      ((toolsAvailable / toolsGiven) * 100).toStringAsFixed(2),
    );
  }

  /// Scrap production line item total weight.
  static double scrapLineItemWeight(double weightPerBag, int totalBags) {
    return double.parse((weightPerBag * totalBags).toStringAsFixed(3));
  }

  /// Scrap maintenance weight = maintenance hours × target weight per hour.
  static double scrapMaintenanceWeight(
    double maintenanceHours,
    double targetWeightPerHour,
  ) {
    return double.parse(
      (maintenanceHours * targetWeightPerHour).toStringAsFixed(3),
    );
  }

  /// Scrap production weight target based on shift duration and per-hour targets.
  static double scrapTargetWeight({
    required double shiftDurationHours,
    required double maintenanceDurationHours,
    required double targetWeightPerHour,
  }) {
    final productionHours = shiftDurationHours - maintenanceDurationHours;
    if (productionHours <= 0) return 0;
    return double.parse(
      (productionHours * targetWeightPerHour).toStringAsFixed(3),
    );
  }

  /// Scrap quality rating monthly average (1-10 scale, converted to %).
  static double scrapQualityPercentage(double averageRating) {
    return double.parse(((averageRating / 10) * 100).toStringAsFixed(2));
  }

  /// Scrap report writing efficiency (score 0-5, converted to %).
  static double scrapWritingEfficiencyPercentage(double averageScore) {
    return double.parse(((averageScore / 5) * 100).toStringAsFixed(2));
  }

  /// Calculate scrap salary multiplier from all 5 variables.
  static double scrapTotalSalaryMultiplier({
    required double a, // Machine Cleaning %
    required double b, // Tools Count %
    required double e, // Production Efficiency %
    required double f, // Report Writing Efficiency %
    required double g, // Scrap Quality Rating %
    required double wA,
    required double wB,
    required double wE,
    required double wF,
    required double wG,
  }) {
    return variableMultiplier(a, wA) +
        variableMultiplier(b, wB) +
        variableMultiplier(e, wE) +
        variableMultiplier(f, wF) +
        variableMultiplier(g, wG);
  }
}
