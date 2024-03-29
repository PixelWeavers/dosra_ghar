import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/views/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    UserModel? currentUser = user.user;
    String input = currentUser!.name.toString();

    RegExp regex = RegExp(r"^(.*?)\s(\w+)$");
    Match? match = regex.firstMatch(input);

    String name = "";
    String regNo = "";
    if (match != null) {
      name = match.group(1)!;
      regNo = match.group(2)!;
    } else {
      throw FormatException("Cannot extract name and reg no");
    }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name'),
          Text('Email: ${currentUser.email}'),
          Text('Registration Number : $regNo'),
          Text('Mess: ${currentUser.messType}'),
          Text('Hostel: ${currentUser.hostelBlock}'),
          Text('Account Type: ${currentUser.accountType}')
          // Display other user details as needed
        ],
      ),
    );
  }
}
