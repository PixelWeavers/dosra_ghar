import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/laundry.dart';
import 'package:flutter/material.dart';

class LaundryProvider extends ChangeNotifier {
  final CollectionReference laundryCollection =
      FirebaseFirestore.instance.collection('laundry');

  bool _isCheckedIn = false;

  bool get isCheckedIn => _isCheckedIn;

  Future<void> addLaundryCheckIn(LaundryModel laundry) async {
    try {
      await laundryCollection.add({
        'noClothes': laundry.noClothes,
        'token': laundry.token,
        'isCheckIn': laundry.isCheckIn,
        'date': laundry.date,
        'uid': laundry.uid,
      });
      _isCheckedIn = true; // Updat e the checked-in status
      notifyListeners();
    } catch (e) {
      print('Error adding laundry check-in: $e');
    }
  }
}
