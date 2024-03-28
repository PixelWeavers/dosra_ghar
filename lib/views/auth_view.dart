import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/views/home.dart';
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

              UserCredential? userCredential =
                  await authProvider.signInWithGoogle(context);
              authProvider.testFetch(userCredential);
              final String? accountType =
                  authProvider.isAccountType(userCredential);
              final String _uid = userCredential?.user?.uid as String;
              print("This is ${_uid}");
              final bool userExists =
                  await firestoreService.checkUserExists(_uid);
              if (!userExists) {
                ProfileCompletionPopUp(
                    firestoreService,
                    userCredential,
                    context,
                    hostelBlocks,
                    _selectedHostel,
                    messTypes,
                    _selectedMessType,
                    accountType);
              } else {
                return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User already registered")));
              }
            },
          ))
        ],
      ),
    );
  }

  Future<dynamic> ProfileCompletionPopUp(
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
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(10),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                  padding: EdgeInsets.all(10),
                  hint: Text(hostelHint),
                  icon: Icon(Icons.house),
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
                  padding: EdgeInsets.all(10),
                  hint: Text(messHint),
                  icon: Icon(Icons.food_bank),
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
                        name: userCredential?.user?.displayName,
                        email: userCredential?.user?.email,
                        hostelBlock: _selectedHostel,
                        messType: _selectedMessType,
                        accountType: accountType);

                    firestoreService.addUser(user, context);
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: Text("Confirm"))
            ],
          ),
        ),
        title: Text("Enter your hostel and mess info"),
      ),
    );
  }
}

// class ProfileSetup extends StatefulWidget {
//   const ProfileSetup({super.key});

//   @override
//   State<ProfileSetup> createState() => _ProfileSetupState();
// }

// class _ProfileSetupState extends State<ProfileSetup> {
//   UserCredential? userCredential =
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         title: Text("Complete Setup",
//             style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         toolbarHeight: 70,
//         backgroundColor: Color.fromRGBO(68, 135, 236, 1),
//       ),
//       body: ,
//     );
//   }
// // }


//  AccountType accountType;

//                if (userCredential?.user?.email?.contains('vitstudent.ac.in') ??
//                   false) {
//                 accountType = AccountType.student;
//               } else if (userCredential?.user?.email?.contains('vit.ac.in') ??
//                   false) {
//                 accountType = AccountType.admin;
//               } else {
//                 accountType = AccountType.student;
//               }
//               if (userCredential != null) {
//                 String name;
//                 Mess? messType;
//                 Hostel? hostelBlock;
//                 showDialog(
//                   context: context,
//                   builder: (context) => Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: nameController,
//                         decoration:
//                             InputDecoration(label: Text("Enter your name")),
//                       ),
//                       Row(
//                         children: [
//                           DropdownButtonFormField<Mess>(
//                             decoration: InputDecoration(
//                                 label: Text("Select your mess")),
//                             items: messTypes
//                                 .map<DropdownMenuItem<Mess>>(
//                                   (Mess mess) => DropdownMenuItem<Mess>(
//                                     value: mess,
//                                     child: Text(mess.name),
//                                   ),
//                                 )
//                                 .toList(),
//                             onChanged: (Mess? value) {
//                               // Define your onChanged function here
//                               messType = value;
//                             },
//                           ),
//                           DropdownButtonFormField<Hostel>(
//                             decoration: InputDecoration(
//                                 label: Text("Select your hostel")),
//                             items: hostelBlocks
//                                 .map<DropdownMenuItem<Hostel>>(
//                                   (Hostel hostel) => DropdownMenuItem<Hostel>(
//                                     value: hostel,
//                                     child: Text(hostel.name),
//                                   ),
//                                 )
//                                 .toList(),
//                             onChanged: (Hostel? value) {
//                               // Define your onChanged function here
//                               hostelBlock = value;
//                             },
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text("Confirm"),
//                       )
//                     ],
//                   ),
//                 ).then((_) {
//                   UserModel user = UserModel(
//                       name: nameController.text,
//                       email: userCredential.user!.email,
//                       hostelBlock: hostelBlock,
//                       messType: messType,
//                       accountType: accountType);
//                 });
//               }
//               ;