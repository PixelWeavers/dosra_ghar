import 'package:dosra_ghar/data/bookingResponseDummy.dart';
import 'package:dosra_ghar/models/bookingResponseModel.dart';
import 'package:dosra_ghar/widgets/bookingWidget.dart';
import 'package:dosra_ghar/widgets/commutersListItem.dart';
import 'package:flutter/material.dart';

class Commuters extends StatefulWidget {
  final BookingResponseModel selectedBooking;
  const Commuters({required this.selectedBooking, Key? key}) : super(key: key);

  @override
  State<Commuters> createState() => _CommutersState();
}

class _CommutersState extends State<Commuters> {
  BookingResponseDummy dummyInstance = BookingResponseDummy();
  List<BookingResponseModel> bookingResponsesDummyWithTimeVariation = [
    BookingResponseModel(
      source: "CAM",
      destination: "VAN",
      time: "05:30",
      date: "2024-04-08",
      bookedBy: "Alice Smith",
      regNo: "ABC123",
      email: "alice.smith@example.com",
      uid: "9D2Vv6VLCVWc98HbgBt3TSiU3Yg2",
    ),
    BookingResponseModel(
      source: "ABC",
      destination: "XYZ",
      time: "08:00",
      date: "2024-04-10",
      bookedBy: "John Doe",
      regNo: "DEF456",
      email: "john.doe@example.com",
      uid: "example2",
    ),
    BookingResponseModel(
      source: "DEF",
      destination: "GHI",
      time: "11:30",
      date: "2024-04-12",
      bookedBy: "Jane Smith",
      regNo: "GHI789",
      email: "jane.smith@example.com",
      uid: "example3",
    ),
    BookingResponseModel(
      source: "JKL",
      destination: "MNO",
      time: "12:00",
      date: "2024-04-14",
      bookedBy: "Michael Johnson",
      regNo: "JKL789",
      email: "michael.johnson@example.com",
      uid: "example4",
    ),
    BookingResponseModel(
      source: "PQR",
      destination: "STU",
      time: "18:00",
      date: "2024-04-16",
      bookedBy: "Emma Thompson",
      regNo: "PQR567",
      email: "emma.thompson@example.com",
      uid: "example5",
    ),
    BookingResponseModel(
      source: "UVW",
      destination: "XYZ",
      time: "22:00",
      date: "2024-04-18",
      bookedBy: "Alex Johnson",
      regNo: "UVW890",
      email: "alex.johnson@example.com",
      uid: "example6",
    ),
    BookingResponseModel(
      source: "GHI",
      destination: "JKL",
      time: "08:30",
      date: "2024-04-20",
      bookedBy: "Jane Anderson",
      regNo: "GHI234",
      email: "jane.anderson@example.com",
      uid: "example7",
    ),
  ];

  List<BookingResponseModel> commuters = [];

  @override
  void initState() {
    super.initState();
    commuters = dummyInstance.filterBookingResponsesByTime(
        bookingResponsesDummyWithTimeVariation, widget.selectedBooking.time);
    print(commuters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Commuters",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              bookingHistoryCard(widget.selectedBooking, context),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: commuters.length,
                itemBuilder: (context, index) {
                  return commutersListItem(commuters[index], context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
