import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Creates a Firebase Auth account without signing the current admin out.
abstract class UserAccountCreator {
  /// Returns the new account's Auth uid.
  Future<String> create({required String email, required String password});
}

class SecondaryAppAccountCreator implements UserAccountCreator {
  static const _appName = 'account-creator';

  Future<FirebaseApp> _app() async {
    try {
      return Firebase.app(_appName);
    } catch (_) {
      return Firebase.initializeApp(
        name: _appName,
        options: Firebase.app().options,
      );
    }
  }

  @override
  Future<String> create({required String email, required String password}) async {
    final auth = FirebaseAuth.instanceFor(app: await _app());
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('A user with this phone number already exists');
      }
      rethrow;
    } finally {
      await auth.signOut();
    }
  }
}
