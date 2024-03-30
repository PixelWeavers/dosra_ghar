import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/views/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:modular_ui/modular_ui.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    if (currentUser == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Center(child: CircularProgressIndicator())],
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AuthView()));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User signed out successfully")));
                },
                icon: Icon(Icons.logout_rounded),
              )
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(currentUser.name.toString())),
              Text(currentUser.profileUrl.toString())
            ],
          ));
    }
  }
}
