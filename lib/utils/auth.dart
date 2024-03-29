import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final isValid = isValidDomain(googleUser!.email);
    if (isValid) {
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return Future(() => userCredential);
    } else {
      GoogleSignIn().signOut();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign in with VIT email")));
    }
  }

// Dialog profile(UserCredential? userCredential){
// return showDialog(context: context, builder: builder)
// }

  void testFetch(UserCredential? userCredential) {
    print(userCredential?.user?.displayName);
    print(userCredential?.user?.email);
    print(userCredential?.user?.uid);
  }

  String? isAccountType(
    UserCredential? userCredential,
  ) {
    if (userCredential != null) {
      if (userCredential != null &&
          userCredential.user != null &&
          userCredential.user?.email != null &&
          userCredential.user!.email!.contains('vitstudent.ac.in')) {
        return "student";
      } else {
        return "admin";
      }
    } else {
      throw {};
    }
  }

  bool isValidDomain(String userEmail) {
    final allowedDomains = ['vitstudent.ac.in', 'vit.ac.in'];

    return allowedDomains.contains(userEmail.split('@')[1]);
  }

  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  // Initialize with current user
  Future<void> initialize() async {
    final user = await _authService.userStream.first;
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  Future<bool> isUserSignedIn() async {
    final user = await _authService.getCurrentUserAuth();
    return user != null;
  }
}
