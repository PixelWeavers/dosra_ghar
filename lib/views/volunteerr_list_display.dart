import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerListScreen extends StatefulWidget {
  @override
  _VolunteerListScreenState createState() => _VolunteerListScreenState();
}

class _VolunteerListScreenState extends State<VolunteerListScreen> {
  List<Volunteer> _volunteers = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    // Dummy data
    _volunteers = [
      Volunteer(
        ngo: 'Sri Arunodayam',
        regNo: 'REG001',
        date: '2024-04-10',
        timeSlot: '10:00 AM - 12:00 PM',
      ),
      Volunteer(
        ngo: 'Dean Foundation',
        regNo: 'REG002',
        date: '2024-04-11',
        timeSlot: '02:00 PM - 04:00 PM',
      ),
      Volunteer(
        ngo: 'annamrita.',
        regNo: 'REG003',
        date: '2024-04-12',
        timeSlot: '09:00 AM - 11:00 AM',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer List'),
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
}
