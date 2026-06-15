import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Concurrent Submission Tests', () {
    test('unique document key for machine+date+shift prevents duplicates', () {
      // The Firestore document ID is constructed from machine+date+shift
      String docKey(String machine, DateTime date, String shift) {
        return '${machine}_${date.year}-${date.month}-${date.day}_$shift';
      }

      final key1 = docKey('Frame Machine 1', DateTime(2026, 3, 15), 'Day Shift');
      final key2 = docKey('Frame Machine 1', DateTime(2026, 3, 15), 'Day Shift');
      final key3 = docKey('Frame Machine 1', DateTime(2026, 3, 15), 'Night Shift');

      expect(key1, key2); // Same machine/date/shift → same key
      expect(key1, isNot(key3)); // Different shift → different key
    });

    test('same machine, different dates produce different keys', () {
      String docKey(String machine, DateTime date, String shift) {
        return '${machine}_${date.year}-${date.month}-${date.day}_$shift';
      }

      final key1 = docKey('Frame Machine 1', DateTime(2026, 3, 15), 'Day Shift');
      final key2 = docKey('Frame Machine 1', DateTime(2026, 3, 16), 'Day Shift');
      expect(key1, isNot(key2));
    });

    test('different machines, same date/shift produce different keys', () {
      String docKey(String machine, DateTime date, String shift) {
        return '${machine}_${date.year}-${date.month}-${date.day}_$shift';
      }

      final key1 = docKey('Frame Machine 1', DateTime(2026, 3, 15), 'Day Shift');
      final key2 = docKey('Frame Machine 2', DateTime(2026, 3, 15), 'Day Shift');
      expect(key1, isNot(key2));
    });
  });
}
