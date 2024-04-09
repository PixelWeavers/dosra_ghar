import 'package:dosra_ghar/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: SizedBox(
        height: 200,
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    issue.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Room: ${issue.room}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      'Status: ${issue.status}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      'Date:',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      formatDate(DateTime.parse(issue.date)), // Pass parsed date
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      'Time:',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      formatTime(DateTime.parse(issue.date)), // Pass parsed date
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to format date
  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // Function to format time
  String formatTime(DateTime date) {
    final formatter = DateFormat('HH:mm:ss');
    return formatter.format(date);
  }
}
