import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/rating.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0.0;
  var id = 1;
  var uid;
  String _feedback = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submitRatingAndFeedback() async {
    // Get current date
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Increment id for rating
    id = id + 1;
    uid = id.toString();

    // Create rating object
    final rating = Rating(
      userId: uid,
      rating: _rating,
      timestamp: formattedDate,
      feedback: _feedback,
    );

    try {
      // Store rating data in Firestore
      await FirebaseFirestore.instance.collection('ratings').add(rating.toMap());

      // Store feedback data in Firestore
      await FirebaseFirestore.instance.collection('feedback').add({
        'feedback': _feedback,
        'timestamp': Timestamp.now(),
      });

      // Show success message or navigate to another screen
      Utils.flushBarErrorMessage('Rating and feedback submitted successfully!', context);

      // Clear the form after submission
      _formKey.currentState!.reset();
      setState(() {
        _rating = 0;
        _feedback = '';
      });
    } catch (error) {
      // Handle error
      print('Error submitting rating and feedback: $error');
      
    }
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
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.feedback_outlined),
                prefixIconColor: Colors.white,
                label: Text('Feedback (optional)', style: GoogleFonts.poppins(color: Colors.white)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white)),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  _feedback = value;
                });
              },
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitRatingAndFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                foregroundColor: Colors.black,
                side: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
                fixedSize: const Size(150, 50),
              ),
              child: Text('Submit Rating'),
            )
          ],
        ),
      ),
    );
  }
}
