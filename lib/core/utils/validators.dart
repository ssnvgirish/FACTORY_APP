class Validators {
  Validators._();

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? integerRange(
    String? value,
    int min,
    int max, [
    String fieldName = 'Value',
  ]) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final parsed = int.tryParse(value.trim());
    if (parsed == null) return '$fieldName must be a number';
    if (parsed < min || parsed > max) {
      return '$fieldName must be between $min and $max';
    }
    return null;
  }

  static String? positiveInteger(String? value, [String fieldName = 'Value']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return '$fieldName must be a positive integer';
    }
    return null;
  }

  static String? positiveNumber(String? value, [String fieldName = 'Value']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return '$fieldName must be a positive number';
    }
    return null;
  }

  static String? nonNegativeInteger(
    String? value, [
    String fieldName = 'Value',
  ]) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 0) return '$fieldName must be 0 or greater';
    return null;
  }

  static bool isNotFutureDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final check = DateTime(date.year, date.month, date.day);
    return !check.isAfter(today);
  }

  static String? validateToolsCounts(int given, int available) {
    if (available > given) return 'Available tools cannot exceed tools given';
    return null;
  }

  static String? validateEndTimeAfterStart(DateTime start, DateTime end) {
    if (!end.isAfter(start)) return 'End time must be after start time';
    return null;
  }

  static String? validatePackingQuantities(
    int productionQty,
    int packed,
    int rejected, [
    int onlySanding = 0,
    int sandingAndPacked = 0,
  ]) {
    final total = packed + rejected + onlySanding + sandingAndPacked;
    if (total != productionQty) {
      return 'Classified quantities ($total) must equal production quantity ($productionQty)';
    }
    return null;
  }

  static String? validateWeightagesSum(Map<String, double> weightages) {
    final sum = weightages.values.fold<double>(0, (a, b) => a + b);
    if ((sum - 100).abs() > 0.01) {
      return 'Weightages must sum to 100% (current: ${sum.toStringAsFixed(1)}%)';
    }
    return null;
  }
}
