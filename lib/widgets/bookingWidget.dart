import 'package:flutter/material.dart';
import 'package:dosra_ghar/models/bookingResponseModel.dart';

Widget bookingHistoryCard(
    BookingResponseModel bookingResponseModel, BuildContext context) {
  final size = MediaQuery.of(context).size;
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
                    "${bookingResponseModel.source} - ${bookingResponseModel.destination}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
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
