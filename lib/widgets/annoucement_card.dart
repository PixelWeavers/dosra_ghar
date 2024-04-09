import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnnouncementContainer extends StatelessWidget {
  final String title;
  final String description;
  final DateTime timestamp;

  const AnnouncementContainer({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleRow(),
            const SizedBox(height: 8),
            Material(
              color: Colors.black,
              child: Text(description,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
            const SizedBox(height: 8),
            _buildTimestampText(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.black,
          child: Text(title,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ),
        const Icon(
          Icons.info_outline,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildTimestampText() {
    return Material(
      color: Colors.black,
      child: Text(
        '${DateFormat('dd-MM-yyyy').format(timestamp)}  ${DateFormat('HH:mm:ss').format(timestamp)}',
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 212, 211, 211),
        ),
      ),
    );
  }
}
