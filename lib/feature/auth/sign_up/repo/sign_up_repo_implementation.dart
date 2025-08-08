import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:carrent/feature/auth/sign_up/repo/i_sign_up_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignUpRepoImplementation extends ISignUpRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> logout() async{
    await auth.signOut();
    final box = Hive.box<UserData>('userDataBox');
    await box.clear(); 
     }

  @override
  Future<void> saveUserToHive(UserData user) async {
    final box = Hive.box<UserData>('userDataBox');
    await box.put('currentUser', user);
  }

  @override
  Future<UserData> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final userCred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint("✅ Firebase Auth created user: ${userCred.user?.uid}");
    final uid = userCred.user!.uid;
    final user = UserData(uid: uid, email: email, name: name, phone: phone);
  debugPrint("📌 Saving to Firestore...");
    await firestore.collection("users").doc(uid).set(user.toJson());
    debugPrint("✅ Firestore user saved");
    await saveUserToHive(user);
    debugPrint("✅ User saved to Hive");
    return user;
  }
}
