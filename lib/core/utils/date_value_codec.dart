DateTime? dateTimeOrNull(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  if (value is String) {
    return DateTime.tryParse(value);
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt());
  }
  if (value is Map<String, dynamic>) {
    final seconds = value['_seconds'] ?? value['seconds'];
    final nanoseconds = value['_nanoseconds'] ?? value['nanoseconds'] ?? 0;
    if (seconds is num && nanoseconds is num) {
      return DateTime.fromMillisecondsSinceEpoch(
        seconds.toInt() * 1000 + nanoseconds.toInt() ~/ 1000000,
      );
    }
  }

  try {
    final converted = (value as dynamic).toDate();
    if (converted is DateTime) {
      return converted;
    }
  } catch (_) {}

  try {
    final converted = (value as dynamic).toDateTime();
    if (converted is DateTime) {
      return converted;
    }
  } catch (_) {}

  return null;
}

DateTime requireDateTime(dynamic value, String fieldName) {
  final converted = dateTimeOrNull(value);
  if (converted == null) {
    throw FormatException(
      'Expected a DateTime-compatible value for $fieldName, got ${value.runtimeType}.',
    );
  }
  return converted;
}

DateTime writeTimestamp(DateTime? value) => value ?? DateTime.now();
