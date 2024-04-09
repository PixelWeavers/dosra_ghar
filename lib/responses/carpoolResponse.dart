import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/bookingResponseModel.dart';
import 'package:dosra_ghar/models/weride_model.dart';
import 'package:flutter/material.dart';

class WeRideProvider extends ChangeNotifier {
  final CollectionReference weRide =
      FirebaseFirestore.instance.collection('carpool');

  Stream<List<Map<String, dynamic>>> perDate(WeRideModel weRideModel) {
    return weRide
        .doc("${weRideModel.source}-${weRideModel.destination}")
        .collection('${weRideModel.date}')
        .snapshots()
        .map((snapshot) {
      List<Map<String, dynamic>> data =
          snapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
      return data;
    });
  }

  Future<void> AddToWeRide(WeRideModel weRideModel) async {
    try {
      await weRide
          .doc("${weRideModel.source}-${weRideModel.destination}")
          .collection('${weRideModel.date}')
          .add({
        'source': weRideModel.source,
        'destination': weRideModel.destination,
        'time': weRideModel.time,
        'bookedBy': weRideModel.bookedBy,
        'regNo': weRideModel.regNo,
        'email': weRideModel.email,
        'uid': weRideModel.uid,
      });
    } catch (error) {
      print('Error adding to WeRide: $error');
      throw error;
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year.toString().padLeft(4, '0')}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  Stream<List<Map<String, dynamic>>> getBookingsByUid(String? uid) {
    return weRide.snapshots().asyncMap((querySnapshot) async {
      List<Map<String, dynamic>> bookings = [];
      for (var sourceDestDoc in querySnapshot.docs) {
        var dateCollections =
            sourceDestDoc.reference.collection(getCurrentDate());
        var dateDocs = await dateCollections.get();
        for (var dateDoc in dateDocs.docs) {
          var bookingsCollection = dateDoc.reference.collection('bookings');
          var userBooking =
              await bookingsCollection.where('uid', isEqualTo: uid).get();
          bookings.addAll(userBooking.docs.map((doc) => doc.data()));
        }
        notifyListeners();
      }
      return bookings;
    });
  }

  Stream<List<BookingResponseModel>> mapBookingResponse(
      Stream<List<Map<String, dynamic>>> stream) {
    return stream.map((snapshot) {
      return snapshot.map((bookingData) {
        return BookingResponseModel(
          source: bookingData['source'],
          destination: bookingData['destination'],
          time: bookingData['time'],
          date: bookingData['date'],
          bookedBy: bookingData['bookedBy'],
          regNo: bookingData['regNo'],
          email: bookingData['email'],
          uid: bookingData['uid'],
        );
      }).toList();
    });
  }
}
