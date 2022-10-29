import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/models/notes.dart';

import '../models/app_user.dart';

class DataBaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///
  ///fatch current user All Notes data
  Future<List<Note>> getNotesUser() async {
    List<Note> note = [];
    try {
      QuerySnapshot snapshot = await firebaseFirestore
          .collection('appUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notes')
          .get();
      if (snapshot.docs.length > 0) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          note.add(Note.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
          print("********${note[i].toJson()}*******");
        }
        print("Notes lenght${note.length}");
      }
    } catch (e) {
      print('Error @getRequests => $e');
    }
    return note;
  }

////
  /// fatch current user
  Future<AppUser> getUser() async {
    try {
      final snapshot = await firebaseFirestore
          .collection('appUser')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      debugPrint('AppUser: ${snapshot.data()}');
      return AppUser.fromjson(
        snapshot.data(),
      );
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }
}
