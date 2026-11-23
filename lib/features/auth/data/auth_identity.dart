/// Maps the app's phone + password login onto Firebase Auth email/password.
class AuthIdentity {
  AuthIdentity._();

  static const _emailDomain = 'prabitha.app';

  /// Firebase Auth needs 6+ character passwords; legacy passwords are short
  /// (e.g. `1234`), so a constant prefix is added transparently.
  static const _passwordPrefix = 'prb#';

  static String normalizePhone(String phone) {
    final trimmed = phone.trim();
    if (trimmed.startsWith('+')) return trimmed;
    if (trimmed.length == 10) return '+91$trimmed';
    return trimmed;
  }

  static String emailFor(String phone) {
    final digits = normalizePhone(phone).replaceAll(RegExp(r'[^0-9]'), '');
    return '$digits@$_emailDomain';
  }

  static String passwordFor(String raw) => '$_passwordPrefix$raw';
}
