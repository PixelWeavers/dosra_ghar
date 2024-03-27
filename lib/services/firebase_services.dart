import 'package:dosra_ghar/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) {
    final String? _name = user.name;
    final String? _email = user.email;
    final Hostel? _hostelBlock = user.hostelBlock;
    final Mess? _messType = user.messType;

    return users.add({
      'name': _name,
      'email': _email,
      'hostel': _hostelBlock.toString(),
      'mess': _messType.toString()
    });
  }
}
