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
      _isCheckedIn = true; // Update the checked-in status
      notifyListeners();
    } catch (e) {
      print('Error adding laundry check-in: $e');
    }
  }

  
  Future<String> getLaundryToken() async {
    String token = '';
    try {
      QuerySnapshot querySnapshot = await laundryCollection.get();
      querySnapshot.docs.forEach((doc) {
        String tokenValue = doc['token'].toString();
        token = tokenValue;
      });
    } catch (e) {
      print('Error getting laundry token: $e');
    }
    return token;
  }

  Future<String> getLaundryNoClothes() async {
    String noClothes = '';
    try {
      QuerySnapshot querySnapshot = await laundryCollection.get();
      querySnapshot.docs.forEach((doc) {
        String noClothesValue = doc['noClothes'].toString();
        noClothes = noClothesValue;
      });
    } catch (e) {
      print('Error getting laundry noClothes: $e');
    }
    return noClothes;
  }
}
