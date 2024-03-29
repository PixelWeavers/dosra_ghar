import 'package:dosra_ghar/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  final AuthService _authService = AuthService();

  UserProvider() {
    _authService.userStream.listen((User? user) async {
      if (user != null) {
        String uid = user.uid;
        Map<String, dynamic>? userData =
            await FirestoreServiceProvider().getUserSnapshot(uid);
        if (userData != null) {
          _user = UserModel(
            uid: uid,
            name: userData['name'],
            email: userData['email'],
            hostelBlock: userData['hostel'],
            messType: userData['mess'],
            accountType: userData['account_type'],
          );
          notifyListeners(); // Notify listeners when the user changes
        }
      }
    });
  }

  UserModel? get user => _user;
}
