import 'package:cloud_firestore/cloud_firestore.dart';

/// `yyyy-MM-dd` — the storage format for every date-only field.
String dateKey(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

/// Parses a stored date (string or Timestamp) to local midnight.
DateTime parseDateKey(Object? v) {
  if (v is String) {
    final p = DateTime.parse(v);
    return DateTime(p.year, p.month, p.day);
  }
  if (v is Timestamp) {
    final d = v.toDate();
    return DateTime(d.year, d.month, d.day);
  }
  throw FormatException('Expected a date string, got ${v.runtimeType}');
}

Timestamp? toTimestamp(DateTime? d) => d == null ? null : Timestamp.fromDate(d);

DateTime? fromTimestamp(Object? v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

/// A document (or an embedded map) with typed, null-tolerant getters.
class DocRow {
  const DocRow(this.id, this.data);

  factory DocRow.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> s) =>
      DocRow(s.id, s.data() ?? <String, dynamic>{});

  final String id;
  final Map<String, dynamic> data;

  String str(String k, [String fallback = '']) {
    final v = data[k];
    return v is String ? v : fallback;
  }

  String? strOrNull(String k) {
    final v = data[k];
    return v is String ? v : null;
  }

  int integer(String k) => (data[k] as num?)?.toInt() ?? 0;

  double real(String k) => (data[k] as num?)?.toDouble() ?? 0;

  double? realOrNull(String k) => (data[k] as num?)?.toDouble();

  bool flag(String k, {bool fallback = true}) {
    final v = data[k];
    return v is bool ? v : fallback;
  }

  DateTime date(String k) => parseDateKey(data[k]);

  DateTime? timestamp(String k) => fromTimestamp(data[k]);

  List<String> strings(String k) =>
      List<String>.from((data[k] as List?) ?? const []);

  List<DocRow> children(String k) => ((data[k] as List?) ?? const [])
      .map((e) => DocRow('', Map<String, dynamic>.from(e as Map)))
      .toList();
}

/// Shared query/write helpers for the report collections.
class Reports {
  Reports(this.db);
  final FirebaseFirestore db;

  /// Equivalent of the old `ListXxx(machineNumber, startDate, endDate)`
  /// queries: optional equality filter, inclusive date range, newest first.
  /// Null filters are ignored.
  Future<List<DocRow>> list(
    String collection, {
    String? equalsField,
    String? equalsValue,
    String dateField = 'date',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query<Map<String, dynamic>> q = db.collection(collection);
    if (equalsField != null && equalsValue != null) {
      q = q.where(equalsField, isEqualTo: equalsValue);
    }
    if (startDate != null) {
      q = q.where(dateField, isGreaterThanOrEqualTo: dateKey(startDate));
    }
    if (endDate != null) {
      q = q.where(dateField, isLessThanOrEqualTo: dateKey(endDate));
    }
    q = q.orderBy(dateField, descending: true);
    final snap = await q.get();
    return snap.docs.map(DocRow.fromSnapshot).toList();
  }

  Future<DocRow?> findOne(String collection, Map<String, Object> equals) async {
    Query<Map<String, dynamic>> q = db.collection(collection);
    equals.forEach((field, value) => q = q.where(field, isEqualTo: value));
    final snap = await q.limit(1).get();
    return snap.docs.isEmpty ? null : DocRow.fromSnapshot(snap.docs.first);
  }

  Map<String, dynamic> stamp(Map<String, dynamic> data) => {
    ...data,
    'timestamp': FieldValue.serverTimestamp(),
  };

  Future<String> add(String collection, Map<String, dynamic> data) async {
    final ref = db.collection(collection).doc();
    await ref.set(stamp(data));
    return ref.id;
  }

  Future<void> delete(String collection, String id) =>
      db.collection(collection).doc(id).delete();
}
