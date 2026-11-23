import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_app/core/data/firestore_support.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dateKey pads and parseDateKey round-trips to local midnight', () {
    expect(dateKey(DateTime(2026, 3, 5, 18, 30)), '2026-03-05');
    expect(parseDateKey('2026-03-05'), DateTime(2026, 3, 5));
  });

  test('DocRow typed getters with fallbacks', () {
    final row = DocRow('a1', {
      'name': 'x',
      'qty': 3,
      'w': 2,
      'on': false,
      'date': '2026-01-02',
      'at': Timestamp.fromDate(DateTime(2026, 1, 2, 3)),
      'tags': ['p', 'q'],
      'kids': [
        {'k': 1},
      ],
    });
    expect(row.str('name'), 'x');
    expect(row.str('missing'), '');
    expect(row.strOrNull('missing'), isNull);
    expect(row.integer('qty'), 3);
    expect(row.real('w'), 2.0);
    expect(row.realOrNull('missing'), isNull);
    expect(row.flag('on'), isFalse);
    expect(row.flag('missing'), isTrue);
    expect(row.date('date'), DateTime(2026, 1, 2));
    expect(row.timestamp('at'), DateTime(2026, 1, 2, 3));
    expect(row.strings('tags'), ['p', 'q']);
    expect(row.children('kids').single.integer('k'), 1);
  });

  group('Reports', () {
    late FakeFirebaseFirestore db;
    late Reports reports;
    setUp(() async {
      db = FakeFirebaseFirestore();
      reports = Reports(db);
      for (final e in [
        ('M1', '2026-11-01'),
        ('M1', '2026-11-10'),
        ('M2', '2026-11-10'),
      ]) {
        await reports.add('things', {'machineNumber': e.$1, 'date': e.$2});
      }
    });

    test('list filters by machine and inclusive date range, newest first', () async {
      final all = await reports.list('things');
      expect(all, hasLength(3));
      expect(all.first.str('date'), '2026-11-10');

      final m1 = await reports.list(
        'things',
        equalsField: 'machineNumber',
        equalsValue: 'M1',
        startDate: DateTime(2026, 11, 10),
        endDate: DateTime(2026, 11, 10, 23, 59, 59),
      );
      expect(m1.single.str('machineNumber'), 'M1');
      expect(m1.single.id, isNotEmpty);
    });

    test('add stamps a server timestamp; findOne and delete work', () async {
      final id = await reports.add('things', {'machineNumber': 'M3', 'date': '2026-12-01'});
      final found = await reports.findOne('things', {'machineNumber': 'M3', 'date': '2026-12-01'});
      expect(found!.id, id);
      expect(found.data.containsKey('timestamp'), isTrue);
      await reports.delete('things', id);
      expect(await reports.findOne('things', {'machineNumber': 'M3'}), isNull);
    });
  });
}
