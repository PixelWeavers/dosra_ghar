import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/rating.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0.0;
  var id =1;
  var uid;
  void _submitRating() async {
   // final user = FirebaseAuth.instance.currentUser;
   // final userId = user?.uid;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

   // if (userId != null) {
    id= id+1;
    uid = id.toString();
      final rating = Rating(
        userId: uid,
        rating: _rating,
        timestamp: formattedDate,
      );
  
      await FirebaseFirestore.instance
          .collection('ratings')
          .add(rating.toMap());

      Utils.flushBarErrorMessage('Rating submitted successfully!', context);
    //} else {
     // Utils.flushBarErrorMessage('Please log in to submit a rating.', context);
  //  }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          
          children: [
             Text(
              'Rate the food:',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
               color: Colors.white
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Slider(
                min: 0,
                max: 10,
                activeColor: Colors.deepOrangeAccent,
                divisions: 10,
                value: _rating,
                onChanged: (newValue) {
                  setState(() {
                    _rating = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submitRating,
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 241, 241, 241),
            foregroundColor: Colors.black,
            side: BorderSide( color: Theme.of(context).colorScheme.tertiary, width: 2),
             fixedSize: const Size(150, 50)),child: const Text('Submit Rating'),)
          ],
        ),
      ),
    );
  }
}
