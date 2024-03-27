import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dosra_ghar/utils/auth.dart';
import 'package:dosra_ghar/models/user.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DusraGhar Authentication",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(68, 135, 236, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "DusraGhar",
              style: GoogleFonts.gudea(
                textStyle: TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              child: SignInButton(
            Buttons.GoogleDark,
            onPressed: () {
              signInWithGoogle(context);
            },
          ))
        ],
      ),
    );
  }
}
