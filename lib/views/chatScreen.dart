import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/widgets/message.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'login.dart';

class ChatPage extends StatefulWidget {
  String email;
  ChatPage({required this.email});
  @override
  _ChatPageState createState() => _ChatPageState(email: email);
}

class _ChatPageState extends State<ChatPage> {
  String email;
  _ChatPageState({required this.email});

  final fs = FirebaseFirestore.instance;
 // final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String sender = email;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Chat',style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(
                email: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'message',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(),
                          borderRadius: new BorderRadius.circular(10),
                        ),
              
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {},
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        fs.collection('Messages').doc().set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'email': email,
                        });
              
                        message.clear();
                      }
                    },
                    icon: Icon(Icons.send_sharp , color: Colors.white,size: 36,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}