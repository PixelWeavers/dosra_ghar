import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void signInWithGoogle() {
  
  AuthCredential credential = GoogleAuthProvider.credential(accessToken: , idToken: );
  FirebaseAuth.instance.signInWithCredential(credential);
}
