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

  static const _keyLoggedInUid = 'logged_in_uid';
  static const _bypassUid = 'girish_admin';

  AuthRemoteDataSourceImpl({
    required this.connector,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> signIn(String phone, String password) async {
    // Temporary bypass: accept any credentials and sign in as admin.
    final userModel = UserModel(
      uid: _bypassUid,
      name: 'Girish',
      phone: phone,
      email: 'girish.admin@factory.local',
      roles: const ['admin'],
      assignedMachines: const [],
      fixedSalary: 0,
      isActive: true,
    );

    // Persist session
    await sharedPreferences.setString(_keyLoggedInUid, _bypassUid);

    return userModel;
  }

  @override
  Future<void> signOut() async {
    await sharedPreferences.remove(_keyLoggedInUid);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final uid = sharedPreferences.getString(_keyLoggedInUid);
    if (uid == null || uid.isEmpty) return null;

    if (uid != _bypassUid) {
      await sharedPreferences.remove(_keyLoggedInUid);
      return null;
    }

    return UserModel(
      uid: _bypassUid,
      name: 'Girish',
      phone: '',
      email: 'girish.admin@factory.local',
      roles: const ['admin'],
      assignedMachines: const [],
      fixedSalary: 0,
      isActive: true,
    );
  }
}
