import 'package:dosra_ghar/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';

class FirestoreServiceProvider extends ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<bool> isAdmin() async {
    try {
      final DocumentSnapshot doc =
          await users.doc(FirebaseAuth.instance.currentUser?.uid).get();
      if (doc.exists) {
        final Map<String, dynamic> userData =
            doc.data() as Map<String, dynamic>;
        if (userData['account_type'] == "admin") {
          return true;
        } else if (userData['account_type'] == "student") {
          return false;
        }
      }
      return false; // Default to false if account_type is not found or is neither admin nor student
    } catch (error) {
      print('Error checking admin status: $error');
      return false;
    }
  }

  Future<bool> checkUserExists(String docID) async {
    final DocumentSnapshot doc = await users.doc(docID).get();
    return doc.exists;
  }

  Future<Map<String, dynamic>?> getUserSnapshot(String docID) async {
    final DocumentSnapshot doc = await users.doc(docID).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  Future<void> addUser(UserModel user, BuildContext context) async {
    String docID = user.uid.toString();
    final bool userExists = await checkUserExists(docID);

    if (!userExists) {
      try {
        await users.doc(docID).set(user.toDocument());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User created successfully")));
        notifyListeners();
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User creation failed")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User already exists")));
    }
  }
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();
  // Get the current user
  Future<User?> getCurrentUserAuth() async {
    return _firebaseAuth.currentUser;
  }

  String getCurrentUID() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final String uid = currentUser?.uid ?? '';
    return uid;
  }
}
