/// Switches for testing builds only.
///
/// Every flag here must be set back to `false` before a production release.
class DevFlags {
  DevFlags._();

  /// Signs in with any password (even blank) as long as the phone number
  /// belongs to an existing, active user.
  static const bool bypassPasswordCheck = true;
}
