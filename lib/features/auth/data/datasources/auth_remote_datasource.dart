import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../auth_identity.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String phone, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _db = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  @override
  Future<UserModel> signIn(String phone, String password) async {
    final UserCredential credential;
    try {
      credential = await _auth.signInWithEmailAndPassword(
        email: AuthIdentity.emailFor(phone),
        password: AuthIdentity.passwordFor(password),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_messageFor(e));
    }

    final user = await _loadProfile(credential.user!.uid);
    if (user == null) {
      await _auth.signOut();
      throw Exception('No account found for this phone number');
    }
    if (!user.isActive) {
      await _auth.signOut();
      throw Exception('Account is deactivated');
    }
    return user;
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final current = _auth.currentUser;
    if (current == null) return null;
    try {
      final user = await _loadProfile(current.uid);
      if (user == null || !user.isActive) {
        await _auth.signOut();
        return null;
      }
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> _loadProfile(String authUid) async {
    final snap = await _db.collection(Col.users).doc(authUid).get();
    if (!snap.exists) return null;
    final row = DocRow.fromSnapshot(snap);
    return UserModel(
      uid: row.str('uid'),
      name: row.str('name'),
      phone: row.str('phone'),
      email: row.str('email'),
      roles: row.strings('roles'),
      assignedMachines: row.strings('assignedMachines'),
      fixedSalary: row.real('fixedSalary'),
      isActive: row.flag('isActive'),
    );
  }

  String _messageFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for this phone number';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect phone number or password';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return e.message ?? 'Sign in failed';
    }
  }
}
