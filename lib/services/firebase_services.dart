import 'package:dosra_ghar/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  Future<bool> checkUserExists(String docID) async {
    final Stream<DocumentSnapshot> userSnapshot = users.doc(docID).snapshots();
    final DocumentSnapshot doc = await userSnapshot.first;
    return doc.exists;
  }

  Future<void> addUser(UserModel user, BuildContext context) async {
    String docID = user.uid.toString();
    final bool userExists = await checkUserExists(docID);

    if (!userExists) {
      return users.doc(docID).set(user.toDocument()).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User created successfully")));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User creation failed")));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User already exists")));
    }
  }
}
