import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/models/notes.dart';

class AddNotesViewModel extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Note note = Note();
  addNotes() async {
    try {
      note.regDateTime = DateTime.now();
      final notes = await firebaseFirestore
          .collection('appUser')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('notes')
          .doc(DateTime.now().toString())
          .set(note.toJson())
          .then((value) => debugPrint('Notes added successfully'));
    } catch (e) {
      debugPrint("Message:$e");
    }
  }
}
