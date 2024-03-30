import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:dosra_ghar/views/home.dart';
import 'package:dosra_ghar/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dosra_ghar/utils/auth.dart';
import 'package:dosra_ghar/models/user.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String? _selectedMessType;
  String? _selectedHostel;
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
            onPressed: () async {
              TextEditingController nameController = TextEditingController();

              final List<String?> messTypes = ['Veg', 'Non-Veg', 'Special'];
              final List<String?> hostelBlocks = [
                'A Block',
                'B Block',
                'C Block',
                'D1 Block',
                'D2 Block'
              ];

              final authProvider =
                  Provider.of<AuthenticationProvider>(context, listen: false);

              final FirestoreServiceProvider firestoreService =
                  FirestoreServiceProvider();
              final Utils utils = Utils();

              UserCredential? userCredential =
                  await authProvider.signInWithGoogle(context);
              authProvider.testFetch(userCredential);
              final List<String?> data =
                  utils.extractNameReg(userCredential?.user?.displayName);
              final String? name = data[0];
              final String? regNo = data[1];
              final String? accountType =
                  authProvider.isAccountType(userCredential);
              final String _uid = userCredential?.user?.uid as String;
              print("This is $_uid");
              final bool userExists =
                  await firestoreService.checkUserExists(_uid);
              if (!userExists) {
                ProfileCompletionPopUp(
                    name,
                    regNo,
                    firestoreService,
                    userCredential,
                    context,
                    hostelBlocks,
                    _selectedHostel,
                    messTypes,
                    _selectedMessType,
                    accountType);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User already registered")));
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                  (route) {
                    return route is ProfileScreen;
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }

  Future<dynamic> ProfileCompletionPopUp(
      String? name,
      String? regNo,
      FirestoreServiceProvider firestoreService,
      UserCredential? userCredential,
      BuildContext context,
      List<String?> hostelBlocks,
      String? _selectedHostel,
      List<String?> messTypes,
      String? _selectedMessType,
      String? accountType) {
    String hostelHint = "Hostel";
    String messHint = "Mess";
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(10),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                  padding: const EdgeInsets.all(10),
                  hint: Text(hostelHint),
                  icon: const Icon(Icons.house),
                  items: hostelBlocks.map((hostel) {
                    return DropdownMenuItem(
                        child: new Text(hostel.toString()), value: hostel);
                  }).toList(),
                  value: _selectedHostel,
                  onChanged: (newHostel) {
                    setState(() {
                      _selectedHostel = newHostel;
                      hostelHint = _selectedHostel.toString();
                    });
                  }),
              DropdownButton(
                  padding: const EdgeInsets.all(10),
                  hint: Text(messHint),
                  icon: const Icon(Icons.food_bank),
                  items: messTypes.map((mess) {
                    return DropdownMenuItem(
                        child: new Text(mess.toString()), value: mess);
                  }).toList(),
                  onChanged: (newMess) {
                    setState(() {
                      _selectedMessType = newMess;
                      messHint = _selectedMessType.toString();
                    });
                  }),
              ElevatedButton(
                  onPressed: () {
                    final UserModel user = UserModel(
                        uid: userCredential?.user?.uid,
                        name: name,
                        regNo: regNo,
                        email: userCredential?.user?.email,
                        profileUrl: userCredential?.user?.photoURL,
                        hostelBlock: _selectedHostel,
                        messType: _selectedMessType,
                        accountType: accountType);

                    firestoreService.addUser(user, context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: const Text("Confirm"))
            ],
          ),
        ),
        title: const Text("Enter your hostel and mess info"),
      ),
    );
  }
}
