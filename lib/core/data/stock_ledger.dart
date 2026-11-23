import 'package:cloud_firestore/cloud_firestore.dart';

import 'collections.dart';

abstract class StockKind {
  static const frame = 'frame';
  static const sheet = 'sheet';
}

/// One variant's contribution to stock (counts are pieces).
class StockLine {
  const StockLine({
    required this.variant,
    required this.density,
    required this.color,
    this.produced = 0,
    this.packed = 0,
    this.rejected = 0,
    this.packedAmount = 0,
    this.rejectedAmount = 0,
  });

  final String variant; // frame section or sheet thickness
  final String density;
  final String color;
  final int produced;
  final int packed;
  final int rejected;

  /// Weight (frames) or running feet (sheets) represented by [packed] / [rejected].
  final double packedAmount;
  final double rejectedAmount;
}

class StockData {
  const StockData({
    required this.totalProduced,
    required this.totalPacked,
    required this.totalRejected,
    required this.variants,
  });

  final double totalProduced;
  final double totalPacked;
  final double totalRejected;
  final List<StockLine> variants;
}

/// Running stock counters, updated in the same batch as the report write so
/// the dashboard never has to scan every historical report.
class StockLedger {
  StockLedger._();

  static String _slug(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');

  static String variantDocId(String kind, StockLine l) =>
      '${kind}__${_slug(l.variant)}__${_slug(l.density)}__${_slug(l.color)}';

  /// [sign] is `1` when a report is submitted and `-1` when it is deleted.
  /// [producedAmount] is the report-level produced total (weight or feet).
  static void apply(
    WriteBatch batch,
    FirebaseFirestore db, {
    required String kind,
    required List<StockLine> lines,
    double producedAmount = 0,
    int sign = 1,
  }) {
    var packedAmount = 0.0;
    var rejectedAmount = 0.0;
    for (final l in lines) {
      packedAmount += l.packedAmount;
      rejectedAmount += l.rejectedAmount;
      batch.set(db.collection(Col.stockVariants).doc(variantDocId(kind, l)), {
        'kind': kind,
        'variant': l.variant,
        'density': l.density,
        'color': l.color,
        'produced': FieldValue.increment(sign * l.produced),
        'packed': FieldValue.increment(sign * l.packed),
        'rejected': FieldValue.increment(sign * l.rejected),
      }, SetOptions(merge: true));
    }
    batch.set(db.collection(Col.stockTotals).doc(kind), {
      'totalProduced': FieldValue.increment(sign * producedAmount),
      'totalPacked': FieldValue.increment(sign * packedAmount),
      'totalRejected': FieldValue.increment(sign * rejectedAmount),
    }, SetOptions(merge: true));
  }

  static Future<StockData> read(FirebaseFirestore db, String kind) async {
    final totals = await db.collection(Col.stockTotals).doc(kind).get();
    final t = totals.data() ?? const <String, dynamic>{};
    final variants = await db
        .collection(Col.stockVariants)
        .where('kind', isEqualTo: kind)
        .get();
    return StockData(
      totalProduced: (t['totalProduced'] as num?)?.toDouble() ?? 0,
      totalPacked: (t['totalPacked'] as num?)?.toDouble() ?? 0,
      totalRejected: (t['totalRejected'] as num?)?.toDouble() ?? 0,
      variants: variants.docs.map((d) {
        final m = d.data();
        return StockLine(
          variant: m['variant'] as String? ?? '',
          density: m['density'] as String? ?? '',
          color: m['color'] as String? ?? '',
          produced: (m['produced'] as num?)?.toInt() ?? 0,
          packed: (m['packed'] as num?)?.toInt() ?? 0,
          rejected: (m['rejected'] as num?)?.toInt() ?? 0,
        );
      }).toList(),
    );
  }
}
