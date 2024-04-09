import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/models/weride_model.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/responses/carpoolResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final WeRideModel weRideModel = WeRideModel(
      bookedBy: "Raazi",
      email: "test.@",
      regNo: "example",
      uid: "9D2Vv6VLCVWc98HbgBt3TSiU3Yg2",
      source: "VAN",
      destination: "CAM",
      date: "2024-04-08",
      time: "time");
  @override
  Widget build(BuildContext context) {
    final WeRideProvider bookingResponse =
        Provider.of<WeRideProvider>(context, listen: true);
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                final stream =
                    bookingResponse.getBookingsByUid(currentUser?.uid);
                stream.listen((data) {
                  print(data);
                });
              },
              child: Text("Retrieve list by UID")),
          TextButton(
              onPressed: () {
                bookingResponse.AddToWeRide(weRideModel);
              },
              child: Text("Add entry to firestore")),
          TextButton(
              onPressed: () {
                final stream = bookingResponse.perDate(weRideModel);
                stream.listen((data) {
                  print(data);
                });
              },
              child: Text("ByDateFetch")),
          Center(
            child: TextButton(
                onPressed: () {
                  print(currentUser!.uid);
                },
                child: Text("Test data by UID fetch")),
          ),
        ],
      ),
    );
  }
}
