import 'package:shared_preferences/shared_preferences.dart';
import '../../../../generated/dataconnect/default.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String phone, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DefaultConnector connector;
  final SharedPreferences sharedPreferences;

  static const _keyLoggedInUserId = 'logged_in_user_id';

  AuthRemoteDataSourceImpl({
    required this.connector,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> signIn(String phone, String password) async {
    final normalizedPhone = _normalizePhone(phone);
    final result = await connector
        .getUserByPhone(phone: normalizedPhone)
        .execute();
    final users = result.data.users;
    if (users.isEmpty) {
      // Also try the raw phone in case it was stored without +91.
      final fallback = await connector.getUserByPhone(phone: phone).execute();
      if (fallback.data.users.isEmpty) {
        throw Exception('No account found for this phone number');
      }
      return _authenticate(fallback.data.users.first, password);
    }
    return _authenticate(users.first, password);
  }

  Future<UserModel> _authenticate(
    GetUserByPhoneUsers user,
    String password,
  ) async {
    if (user.password != password) {
      throw Exception('Incorrect password');
    }
    if (!user.isActive) {
      throw Exception('Account is deactivated');
    }

    await sharedPreferences.setString(_keyLoggedInUserId, user.id);
    return _toModel(user);
  }

  @override
  Future<void> signOut() async {
    await sharedPreferences.remove(_keyLoggedInUserId);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Clear legacy bypass session key if present.
    await sharedPreferences.remove('logged_in_uid');

    final id = sharedPreferences.getString(_keyLoggedInUserId);
    if (id == null || id.isEmpty) return null;

    try {
      final result = await connector
          .getUserById(id: GetUserByIdVariablesId(id: id))
          .execute();
      final user = result.data.user;
      if (user == null || !user.isActive) {
        await sharedPreferences.remove(_keyLoggedInUserId);
        return null;
      }
      return UserModel(
        uid: user.uid,
        name: user.name,
        phone: user.phone,
        email: user.email,
        roles: List<String>.from(user.roles),
        assignedMachines: List<String>.from(user.assignedMachines),
        fixedSalary: user.fixedSalary,
        isActive: user.isActive,
      );
    } catch (_) {
      await sharedPreferences.remove(_keyLoggedInUserId);
      return null;
    }
  }

  UserModel _toModel(GetUserByPhoneUsers user) {
    return UserModel(
      uid: user.uid,
      name: user.name,
      phone: user.phone,
      email: user.email,
      roles: List<String>.from(user.roles),
      assignedMachines: List<String>.from(user.assignedMachines),
      fixedSalary: user.fixedSalary,
      isActive: user.isActive,
    );
  }

  String _normalizePhone(String phone) {
    final trimmed = phone.trim();
    if (trimmed.startsWith('+')) return trimmed;
    if (trimmed.length == 10) return '+91$trimmed';
    return trimmed;
  }
}
