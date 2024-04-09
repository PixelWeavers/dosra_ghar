import 'package:dosra_ghar/models/bookingResponseModel.dart';
import 'package:flutter/material.dart';

Widget commutersListItem(
    BookingResponseModel bookingResponseModel, BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.15,
    width: size.width * 0.9,
    child: Card(
        color: const Color.fromARGB(255, 235, 199, 93),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booking Date: ${bookingResponseModel.date}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Time: ${bookingResponseModel.time}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Booked by: ${bookingResponseModel.bookedBy}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Registration #: ${bookingResponseModel.regNo}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )),
  );
}
