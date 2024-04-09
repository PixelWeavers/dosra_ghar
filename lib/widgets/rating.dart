import 'package:dosra_ghar/views/caters_performance.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/rating.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

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

    // Increment id for rating (optional, if needed)
    // id = id + 1;
    // uid = id.toString();

    // Create a single document with both rating and feedback data
    final ratingData = {
      'userId': UniqueKey().toString(), // Generate a unique user ID
      'rating': _rating,
      'timestamp': formattedDate,
      'feedback': _feedback,
    };

    try {
      // Store all data in a single document within the "ratings" collection
      await FirebaseFirestore.instance.collection('ratings').add(ratingData);

      // Show success message or navigate to another screen
      Utils.flushBarErrorMessage(
          'Rating and feedback submitted successfully!', context);

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
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.feedback_outlined),
                prefixIconColor: Colors.white,
                label: Text('Feedback (optional)',
                    style: GoogleFonts.poppins(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white)),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  _feedback = value;
                });
              },
            ),
            const SizedBox(height: 16),
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
            ElevatedButton(
              onPressed: () {
                _submitRatingAndFeedback();
                // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>StatisticsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                foregroundColor: Colors.black,
                side: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary, width: 2),
                fixedSize: const Size(150, 50),
              ),
              child: const Text('Submit Rating'),
            )
          ],
        ),
      ),
    );
  }
}
