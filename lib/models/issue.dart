import 'package:cloud_firestore/cloud_firestore.dart';

class Issue {
  final String title;
  final String description;
  final String room;
  final String hostelBlock;
  final String date;
  final String status;

  const Issue({
    required this.title,
    required this.description,
    required this.room,
    required this.hostelBlock,
    required this.date,
    required this.status,
  });

  factory Issue.fromSnapshot(DocumentSnapshot snapshot) {
    return Issue(
      title: snapshot['title'] as String,
      description: snapshot['description'] as String,
      room: snapshot['room'] as String,
      hostelBlock: snapshot['hostel-block'] as String,
      date: snapshot['date'] as String,
      status: snapshot['status'] as String,
    );
  }
}