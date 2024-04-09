import 'package:dosra_ghar/models/bookingResponseModel.dart';

class BookingResponseDummy {
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

  List<BookingResponseModel> filterBookingResponsesByTime(
      List<BookingResponseModel> bookingResponses, String referenceTime) {
    // Convert the reference time to hours for easier comparison
    int referenceTimeInHours = int.parse(referenceTime.split(":")[0]);

    return bookingResponses.where((booking) {
      // Convert the booking time to hours
      int bookingTimeInHours = int.parse(booking.time.split(":")[0]);

      // Check if the absolute difference is less than or equal to 3
      return (bookingTimeInHours - referenceTimeInHours).abs() <= 3;
    }).toList();
  }
}


// You can use this list to create list items in your UI with variations in the time field.
