import 'package:firebase_auth/firebase_auth.dart';
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
            onPressed: () async {
              TextEditingController nameController = TextEditingController();

              final List<Mess?> messTypes = [
                Mess.veg,
                Mess.nonveg,
                Mess.special
              ];
              final List<Hostel?> hostelBlocks = [
                Hostel.blockA,
                Hostel.blockB,
                Hostel.blockC,
                Hostel.blockD1,
                Hostel.blockD2,
              ];
              Mess? _selectedMessType;
              Hostel? _selectedHostel;

              final SignIn signIn = SignIn();

              UserCredential? userCredential =
                  await signIn.signInWithGoogle(context);
              signIn.testFetch(userCredential);
              ProfileCompletionPopUp(context, hostelBlocks, _selectedHostel,
                  messTypes, _selectedMessType);
            },
          ))
        ],
      ),
    );
  }

  Future<dynamic> ProfileCompletionPopUp(
      BuildContext context,
      List<Hostel?> hostelBlocks,
      Hostel? _selectedHostel,
      List<Mess?> messTypes,
      Mess? _selectedMessType) {
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
                  hint: Text("Hostel"),
                  icon: Icon(Icons.house),
                  items: hostelBlocks.map((hostel) {
                    return DropdownMenuItem(
                        child: new Text(hostel.toString()), value: hostel);
                  }).toList(),
                  onChanged: (newHostel) {
                    setState(() {
                      _selectedHostel = newHostel;
                    });
                  }),
              DropdownButton(
                  padding: EdgeInsets.all(10),
                  hint: Text("Mess"),
                  icon: Icon(Icons.food_bank),
                  items: messTypes.map((mess) {
                    return DropdownMenuItem(
                        child: new Text(mess.toString()), value: mess);
                  }).toList(),
                  onChanged: (newMess) {
                    setState(() {
                      _selectedMessType = newMess;
                    });
                  })
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