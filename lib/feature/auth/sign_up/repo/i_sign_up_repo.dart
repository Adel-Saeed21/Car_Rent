import 'package:carrent/feature/auth/sign_up/data/user_data.dart';

abstract class ISignUpRepo {
  Future<UserData> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<void> logout();

  Future<void> saveUserToHive(UserData user);
}
