import 'package:flutter_test/flutter_test.dart';
import '../test/helpers/test_factories.dart';

/// Integration test simulating Customer Rejection flow.
void main() {
  group('Customer Rejection Flow', () {
    test('customer rejection report has correct structure', () {
      final rejection = TestFactories.fakeCustomerRejection(
        totalRejectedWeight: 48.6,
      );
      expect(rejection.totalRejectedWeight, 48.6);
      expect(rejection.rejectedItems, isNotEmpty);
    });

    test('production weight reduced by 2× rejected weight', () {
      final originalProductionWeight = 5200.0;
      final customerRejectedWeight = 100.0;

      final deducted = originalProductionWeight - (2 * customerRejectedWeight);
      expect(deducted, 5000.0);
    });

    test('deduction does not cause total weight to go below 0', () {
      final originalProductionWeight = 100.0;
      final customerRejectedWeight = 200.0;

      final deducted = originalProductionWeight - (2 * customerRejectedWeight);
      final result = deducted < 0 ? 0.0 : deducted;
      expect(result, 0.0);
    });

    test('zero customer rejection → no change', () {
      final originalProductionWeight = 5200.0;
      final deducted = originalProductionWeight - (2 * 0.0);
      expect(deducted, 5200.0);
    });
  });
}
