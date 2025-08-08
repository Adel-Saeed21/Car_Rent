import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepoImplementation extends ILoginRepo {

   final FirebaseAuth auth;
  LoginRepoImplementation(this.auth);

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
