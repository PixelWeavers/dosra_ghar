class BookingResponseModel {
  BookingResponseModel(
      {required this.source,
      required this.destination,
      required this.time,
      required this.date,
      required this.bookedBy,
      required this.regNo,
      required this.email,
      required this.uid});
  final String source;
  final String destination;
  final String time;
  final String bookedBy;
  final String email;
  final String regNo;
  final String uid;
  final String date;
}
