import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('apply increments counters and reversing returns to zero', () async {
    final db = FakeFirebaseFirestore();
    const line = StockLine(variant: '3x2', density: '0.8', color: 'White', produced: 10);
    final b1 = db.batch();
    StockLedger.apply(b1, db, kind: StockKind.frame, lines: [line], producedAmount: 50);
    const pack = StockLine(
      variant: '3x2', density: '0.8', color: 'White',
      packed: 6, rejected: 1, packedAmount: 12, rejectedAmount: 2,
    );
    StockLedger.apply(b1, db, kind: StockKind.frame, lines: [pack]);
    await b1.commit();

    var data = await StockLedger.read(db, StockKind.frame);
    expect(data.totalProduced, 50);
    expect(data.totalPacked, 12);
    expect(data.totalRejected, 2);
    final v = data.variants.single;
    expect([v.variant, v.density, v.color, v.produced, v.packed, v.rejected],
        ['3x2', '0.8', 'White', 10, 6, 1]);

    final b2 = db.batch();
    StockLedger.apply(b2, db, kind: StockKind.frame, lines: [line], producedAmount: 50, sign: -1);
    await b2.commit();
    data = await StockLedger.read(db, StockKind.frame);
    expect(data.totalProduced, 0);
    expect(data.variants.single.produced, 0);
  });

  test('variantDocId slugs non-alphanumerics', () {
    const l = StockLine(variant: '3x2 "A"', density: '0.8', color: 'Off White');
    expect(StockLedger.variantDocId('frame', l), 'frame__3x2_A___0_8__Off_White');
  });

  test('kinds are isolated', () async {
    final db = FakeFirebaseFirestore();
    final b = db.batch();
    StockLedger.apply(b, db, kind: StockKind.sheet,
        lines: [const StockLine(variant: '9mm', density: 'D', color: 'C', produced: 4)], producedAmount: 8);
    await b.commit();
    expect((await StockLedger.read(db, StockKind.frame)).variants, isEmpty);
    expect((await StockLedger.read(db, StockKind.sheet)).totalProduced, 8);
  });
}
