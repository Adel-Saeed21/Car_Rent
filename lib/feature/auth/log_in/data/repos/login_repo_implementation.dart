import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class LoginRepoImplementation extends ILoginRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  LoginRepoImplementation(this.auth);

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) {
      throw Exception("Failed to get Firebase user.");
    }

    final box = Hive.box<UserData>('userDataBox');
    UserData? currentUser = box.get('currentUser');

    if (currentUser != null) {
      
    } else {
      

      final newUser = UserData(
        uid: user.uid,
        email: user.email,
        name: user.displayName,
        phone: user.phoneNumber,
      );

      await box.put('currentUser', newUser);
      currentUser = newUser;
    }

    return userCredential;
  }
}
