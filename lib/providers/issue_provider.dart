import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/issue.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IssueProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  List<Issue> _issues = [];
  List<Issue> get issues => _issues; // Getter for issues list
  bool _loading = false;
  bool get loading => _loading; // Getter for loading state

  Future<void> fetchIssues(String? userHostelBlock) async {
    _loading = true;
    notifyListeners(); // Notify listeners about loading state change

    try {
      final query = _firestore.collection('complaints');
      if (userHostelBlock != null) {
        query.where('hostel-block', isEqualTo: userHostelBlock);
      }

      final snapshot = await query.get();
      _issues = snapshot.docs.map((doc) => Issue.fromSnapshot(doc)).toList();
    } catch (error) {
      print(error);
    } finally {
      _loading = false;
      notifyListeners(); // Notify listeners about data update and loading state change
    }
  }

  void fetchDataOnInitialization(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await fetchIssues(userProvider.user?.hostelBlock);
    });
  }
}
