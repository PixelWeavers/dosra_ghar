import 'package:dosra_ghar/responses/carpoolResponse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch bookings by UID', () async {
    final bookingResponse = WeRideProvider();
    final String uid =
        'example'; // Replace 'example' with a valid UID from your Firestore data

    final Stream<List<Map<String, dynamic>>> stream =
        bookingResponse.getBookingsByUid(uid);

    // Listen to the stream and wait for data
    final List<Map<String, dynamic>> bookings = await stream.first;

    // Verify that bookings list is not empty
    expect(bookings.isNotEmpty, true);

    // Print the bookings for verification
    print(bookings);
  });
}
