import 'package:dosra_ghar/models/bookingResponseModel.dart';
import 'package:dosra_ghar/views/commuters.dart';
import 'package:dosra_ghar/widgets/bookingWidget.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  List<BookingResponseModel> bookingResponsesDummy = [
    BookingResponseModel(
      source: "CAM",
      destination: "VAN",
      time: "08:30",
      date: "2024-04-08",
      bookedBy: "Raazi Faisal",
      regNo: "22MIA1103",
      email: "raazi.faisal2022@vitstudent.ac.in",
      uid: "9D2Vv6VLCVWc98HbgBt3TSiU3Yg2",
    ),
    BookingResponseModel(
      source: "ABC",
      destination: "XYZ",
      time: "10:00",
      date: "2024-04-10",
      bookedBy: "John Doe",
      regNo: "ABC123",
      email: "john.doe@example.com",
      uid: "example2",
    ),
    BookingResponseModel(
      source: "DEF",
      destination: "GHI",
      time: "12:30",
      date: "2024-04-12",
      bookedBy: "Jane Smith",
      regNo: "DEF456",
      email: "jane.smith@example.com",
      uid: "example3",
    ),
    BookingResponseModel(
      source: "JKL",
      destination: "MNO",
      time: "15:00",
      date: "2024-04-14",
      bookedBy: "Alice Johnson",
      regNo: "JKL789",
      email: "alice.johnson@example.com",
      uid: "example4",
    ),
    BookingResponseModel(
      source: "PQR",
      destination: "STU",
      time: "17:45",
      date: "2024-04-16",
      bookedBy: "Michael Anderson",
      regNo: "PQR567",
      email: "michael.anderson@example.com",
      uid: "example5",
    ),
    BookingResponseModel(
      source: "UVW",
      destination: "XYZ",
      time: "19:15",
      date: "2024-04-18",
      bookedBy: "Emma Thompson",
      regNo: "UVW890",
      email: "emma.thompson@example.com",
      uid: "example6",
    ),
    BookingResponseModel(
      source: "GHI",
      destination: "JKL",
      time: "21:30",
      date: "2024-04-20",
      bookedBy: "Alex Johnson",
      regNo: "GHI234",
      email: "alex.johnson@example.com",
      uid: "example7",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Booking History",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView.builder(
              itemCount: bookingResponsesDummy.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    final BookingResponseModel selectedBooking =
                        bookingResponsesDummy[index];
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            Commuters(selectedBooking: selectedBooking)));
                  },
                  child: bookingHistoryCard(
                      bookingResponsesDummy[index], context))),
        ));
  }
}
