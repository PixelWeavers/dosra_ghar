import 'package:dosra_ghar/views/add_found_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:dosra_ghar/views/add_lost_items.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Found Items',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('foundItems').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var item = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,15,8),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18.0,18,18,8),
                          child: Center(
                            child: Image.network(
                              item['imageUrl'],
                              height: 200,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                            
                               const SizedBox(height: 8),
                               Text("A ${item['title']} has been found and is currently in the possession of the warden's office. If you have misplaced your ${item['title']} recently, please come to the warden's office to claim it.",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18),),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text(
              'No items found.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FoundDataAdd()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Lost Item',
      ),
    );
  }
}
