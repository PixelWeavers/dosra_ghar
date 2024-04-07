import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:dosra_ghar/views/announcement.dart';
import 'package:dosra_ghar/views/home.dart';
import 'package:dosra_ghar/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dosra_ghar/utils/auth.dart';
import 'package:dosra_ghar/models/user.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

// Only God and I know how this page of code works, so if you are trying to optimize it, increase this counter
// Hours wasted correcting setState = 3

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Sign In",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Welcome To",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DusraGhar",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.w500)),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 280,
              child: Image.asset(
                'assets/images/hostel.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: const Border.fromBorderSide(BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2))),
                child: GFButton(
                  onPressed: () async {
                    UserCredential? userCredential =
                        await authProvider.signInWithGoogle(context);
                    authProvider.testFetch(userCredential);
                    final List<String?> data =
                        utils.extractNameReg(userCredential?.user?.displayName);
                    final String? name = data[0];
                    final String? regNo = data[1];
                    final String? accountType =
                        authProvider.isAccountType(userCredential);
                    final String uid = userCredential?.user?.uid as String;
                    print("This is $uid");
                    final bool userExists =
                        await firestoreService.checkUserExists(uid);
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("User already registered")));
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) {
                          return route is ProfileScreen;
                        },
                      );
                    }
                  },
                  shape: GFButtonShape.standard,
                  color: Colors.white,
                  text: "Get Started",
                  autofocus: true,
                  focusColor: Colors.white,
                  textColor: Colors.black,
                  enableFeedback: true,
                  size: 50,
                  fullWidthButton: true,
                  borderShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2.5)),
                  textStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ))
          ],
        ),
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
      String? selectedHostel,
      List<String?> messTypes,
      String? selectedMessType,
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
                        value: hostel, child: Text(hostel.toString()));
                  }).toList(),
                  value: selectedHostel,
                  onChanged: (newHostel) {
                    setState(() {
                      selectedHostel = newHostel;
                      hostelHint = selectedHostel.toString();
                    });
                  }),
              DropdownButton(
                  padding: const EdgeInsets.all(10),
                  hint: Text(messHint),
                  icon: const Icon(Icons.food_bank),
                  items: messTypes.map((mess) {
                    return DropdownMenuItem(
                        value: mess, child: Text(mess.toString()));
                  }).toList(),
                  onChanged: (newMess) {
                    setState(() {
                      selectedMessType = newMess;
                      messHint = selectedMessType.toString();
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
                        hostelBlock: selectedHostel,
                        messType: selectedMessType,
                        accountType: accountType);

                    firestoreService.addUser(user, context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const Announcement()));
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
