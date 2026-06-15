import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AppUser> signIn(String phone, String password);
  Future<void> signOut();
  Future<AppUser?> getCurrentUser();
}
