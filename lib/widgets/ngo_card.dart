import 'package:dosra_ghar/models/ngo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NgoCard extends StatelessWidget {
  final Ngo ngo;

  const NgoCard({required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        leading: Container(
          width: 120, 
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(ngo.logoUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          ngo.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        subtitle: Text(ngo.description,style:GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),),

      ),
    );
  }
}
