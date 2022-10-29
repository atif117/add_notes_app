import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/models/app_user.dart';
import 'package:notes_app/ui/screens/home/home_screen.dart';

class LoginSignupViewModel extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AppUser appUser = AppUser();
  String? userId;

  signUpWithEmailPassword() async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: appUser.email!, password: appUser.password!);
    await addUser();
    Get.offAll(const HomeScreen());
    notifyListeners();
  }

  logInWithEmailAndPassword() async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: appUser.email!, password: appUser.password!);
      userId = credential.user?.uid;
      Get.offAll(const HomeScreen());
    } catch (e) {
      debugPrint("message:$e");
    }
  }

  addUser() async {
    try {
      final user = await firebaseFirestore
          .collection('appUser')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(appUser.toJson())
          .then(
              (value) => (value) => debugPrint('user registered successfully'));
    } catch (e) {
      debugPrint("Message:$e");
    }
  }
}
