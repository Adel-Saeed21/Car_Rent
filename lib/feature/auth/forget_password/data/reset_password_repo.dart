import 'package:carrent/feature/auth/forget_password/data/i_reset_password_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepo extends IResetPasswordRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          break;
        case 'invalid-email':
          throw Exception('Please enter a valid email address.');
        case 'too-many-requests':
          throw Exception('Too many requests. Please try again later.');
        default:
          break;
      }
    } catch (e) {
      throw Exception('Network error. Please check your connection.');
    }
  }
}