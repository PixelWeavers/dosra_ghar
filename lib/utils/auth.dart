import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dosra_ghar/services/firebase_services.dart';
import 'package:dosra_ghar/models/user.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final isValid = isValidDomain(googleUser!.email);
  if (isValid) {
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    GoogleSignIn().signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Sign in with VIT email")));
  }
}

bool isValidDomain(String userEmail) {
  final allowedDomains = ['vitstudent.ac.in', 'vit.ac.in'];

  return allowedDomains.contains(userEmail.split('@')[1]);
}
