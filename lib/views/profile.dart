import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dosra_ghar/services/firebase_services.dart';
import 'package:dosra_ghar/utils/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().getUserSnapshot(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              Map<String, dynamic>? userData = snapshot.data;
              String name = userData!['name'];
              RegExp regExp = RegExp(r'\d{2}[A-Z]{3}\d{4}');
              String regNo = regExp.stringMatch(name)!;
              RegExp regExp1 = RegExp(r'^[A-Za-z\s]+');
              String extractedName = regExp1.stringMatch(name)!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: $extractedName'),
                  Text('Email: ${userData['email']}'),
                  Text('Hostel: ${userData['hostel']}'),
                  Text('Mess: ${userData['mess']}'),
                  Text('Registration Number: $regNo'),
                  // Add other fields as needed
                ],
              );
            } else {
              return Center(
                child: Text('User not found'),
              );
            }
          }
        },
      ),
    );
  }
}
