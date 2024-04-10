import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/ngo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerListScreen extends StatefulWidget {
  @override
  _VolunteerListScreenState createState() => _VolunteerListScreenState();
}

class _VolunteerListScreenState extends State<VolunteerListScreen> {
  final _firestore = FirebaseFirestore.instance;
  List<Volunteer> _volunteers = [];

  @override
  void initState() {
    super.initState();
    _fetchVolunteers();
  }

  Future<void> _fetchVolunteers() async {
    try {
      final snapshot = await _firestore.collection('volunteers').get();
      _volunteers = snapshot.docs
          .map((doc) {
            String regNo = doc['regno'] as String;
            return Volunteer(
              ngo: doc['ngo'] as String,
              regNo: regNo,
              date: doc['date'] as String,
              timeSlot: doc['time_slot'] as String,
            );
          })
          .toList();
          print(_volunteers);
      setState(() {});
    } catch (error) {
      print('Error fetching volunteers: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching volunteers: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Volunteer List',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),),
      ),
      body: _volunteers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _volunteers.length,
              itemBuilder: (context, index) {
                final volunteer = _volunteers[index];
                return _buildVolunteerCard(volunteer);
              },
            ),
    );
  }

  Widget _buildVolunteerCard(Volunteer volunteer) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              volunteer.ngo,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Registration Number: ${volunteer.regNo}',
              style: GoogleFonts.poppins(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16.0),
                const SizedBox(width: 5.0),
                Text(
                  volunteer.date,
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.access_time_outlined, size: 16.0),
                const SizedBox(width: 5.0),
                Text(
                  volunteer.timeSlot,
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Volunteer {
  final String ngo;
  final String regNo;
  final String date;
  final String timeSlot;

  Volunteer({
    required this.ngo,
    required this.regNo,
    required this.date,
    required this.timeSlot,
  });

  factory Volunteer.fromSnapshot(DocumentSnapshot snapshot) {
    return Volunteer(
      ngo: snapshot['ngo'] as String,
      regNo: snapshot['regno'] as String,
      date: snapshot['date'] as String,
      timeSlot: snapshot['time_slot'] as String,
    );
  }
}
