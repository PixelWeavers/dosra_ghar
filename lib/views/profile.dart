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
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    UserModel? currentUser = user.user;

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
      body: MUIProfileCard(
          name: currentUser!.name.toString(),
          image: Image.network(currentUser!.profileUrl.toString()) ??
              Image.network(
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.reddit.com%2Fr%2Fredditmobile%2Fcomments%2Fav496u%2Fandroid321_whenever_i_download_a_gif_my_phone%2F&psig=AOvVaw1qVFW8-qhVg-nJ-zGQwSWR&ust=1711896828113000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJiSxuWenIUDFQAAAAAdAAAAABAE"),
          designation: currentUser.accountType.toString()),
    );
  }
}
