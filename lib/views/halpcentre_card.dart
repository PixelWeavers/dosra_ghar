import 'package:flutter/material.dart';

Widget emergencyContactCard(
    EmergencyContact emergencyContact, BuildContext context) {
  var size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.20,
    width: size.width * 0.9,
    child: Card(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  emergencyContact.name,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              "Designation: ${emergencyContact.designation}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Text(
              "Contact: ${emergencyContact.contact}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}

class EmergencyContact {
  final String designation;
  final String name;
  final String contact;

  EmergencyContact({
    required this.designation,
    required this.name,
    required this.contact,
  });
}
