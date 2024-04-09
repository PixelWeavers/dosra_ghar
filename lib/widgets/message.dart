import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class messages extends StatefulWidget {
  final String email;
  const messages({super.key, required this.email});

  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  final String email;
  _messagesState({required this.email});

  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();

  Widget _messageTile(QueryDocumentSnapshot qs, bool isSentByCurrentUser) {
    Timestamp t = qs['time'];
    DateTime d = t.toDate();

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
      child: Column(
        crossAxisAlignment: isSentByCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(),
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: isSentByCurrentUser ? const Color(0xFF833AB4) :  const Color.fromARGB(255, 69, 66, 66),
              title: Text(
                qs['email'],
                style:  GoogleFonts.poppins(fontSize: 18, 
                fontWeight: FontWeight.w600,
                color: Colors.white),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      qs['message'],
                      softWrap: true,
                      style:  GoogleFonts.poppins(fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                    ),
                  ),
                  Text(
                    "${d.hour}:${d.minute}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            bool isSentByCurrentUser = email == qs['email'];

            return _messageTile(qs, isSentByCurrentUser);
          },
        );
      },
    );
  }
}