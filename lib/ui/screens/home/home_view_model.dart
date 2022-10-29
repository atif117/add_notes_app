import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/models/app_user.dart';
import 'package:notes_app/core/models/notes.dart';
import 'package:notes_app/core/services/database_services.dart';
import 'package:notes_app/ui/screens/auth_services/login_screen.dart';

class HomeViewModel extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DataBaseServices dataBaseServices = DataBaseServices();

  List<Note> notes = [];
  AppUser appUser = AppUser();
  int hours = DateTime.now().hour;
  String? dropItem;

  HomeViewModel() {
    getNotes();
    getAppUser();
  }

  // clear all notes and logout the current user

  changeValue(val) {
    dropItem = val;

    if (dropItem == "logout") {
      logOutUser();
    }
    if (dropItem == "clearall") {
      clearAllNotes();
    }
    notifyListeners();
  }

// fatch notes from firebase
  getNotes() async {
    notes = await dataBaseServices.getNotesUser();

    notifyListeners();
  }

  getAppUser() async {
    appUser = await dataBaseServices.getUser();
  }

  logOutUser() async {
    await firebaseAuth.signOut();
    Get.offAll(LogInScreen());
  }

  clearAllNotes() async {
    WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    try {
      await FirebaseFirestore.instance
          .collection('appUser')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('notes')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          writeBatch.delete(element.reference);
        });
        writeBatch.commit();
      });
    } catch (e) {
      debugPrint("Message:$e");
    }
  }
}
