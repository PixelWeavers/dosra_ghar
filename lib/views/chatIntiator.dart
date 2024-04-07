import 'package:dosra_ghar/views/chatScreen.dart';
import 'package:flutter/material.dart';

class ChatIntiator extends StatelessWidget {
  const ChatIntiator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChatPage(email: "Admin")));
            },
             child: const Text("Chat as Admin")),
             const SizedBox(height: 18,),
             ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChatPage(email: "Hostellor")));
             },
             child: const Text("Chat as Hostellor")),
             
          ],
        ),
      ),
    );
  }
}