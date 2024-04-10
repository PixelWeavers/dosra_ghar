import 'package:dosra_ghar/models/ngo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NgoCard extends StatelessWidget {
  final Ngo ngo;

  const NgoCard({required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      child: Column(
        children: [
          // Logo container at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity, // Match parent width
              height: 120, // Adjust height as needed
              decoration: BoxDecoration(
                
                image: DecorationImage(
                  image: NetworkImage(ngo.logoUrl),
                  fit: BoxFit.cover, // Ensure full image coverage
                ),
              ),
            ),
          ),
          // Details section below the logo
          Padding(
            padding: const EdgeInsets.all(8.0), // Add some padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left-align content
              children: [
                Text(
                  ngo.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical spacing
                Text(
                  ngo.description,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
