import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaundryScheduleScreen
 extends StatelessWidget {
  const LaundryScheduleScreen
  ({super.key, required this.title});

  final String title;

  List<LaundrySchedule> generateLaundrySchedule() {
    List<LaundrySchedule> schedules = [];
    int roomStart = 101;
    int roomEnd = 208;
    List<String> laundryDays = [
      "April 10",
      "April 11",
      "April 12",
      "April 13",
      "April 14",
      "April 15",
      "April 16",
      "April 17",
      "April 18",
      "April 19",
      "April 20",
      "April 21",
      "April 22",
      // Add more laundry days as needed
    ];
    int dayIndex = 0;

    while (roomEnd <= 1547) {
      schedules.add(LaundrySchedule(
        roomRange: "$roomStart - $roomEnd",
        laundryDay: laundryDays[dayIndex],
      ));
      roomStart += 108;
      roomEnd += 108;
      dayIndex = (dayIndex + 1) % laundryDays.length; // Cycle through laundry days
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    List<LaundrySchedule> schedules = generateLaundrySchedule();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 28),),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return RoomCard(
            roomRange: schedules[index].roomRange,
            laundryDay: schedules[index].laundryDay,
          );
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomRange;
  final String laundryDay;

  const RoomCard({
    required this.roomRange,
    required this.laundryDay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Room Range: $roomRange",
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text("Laundry Day: $laundryDay"),
          ],
        ),
      ),
    );
  }
}
class LaundrySchedule {
  final String roomRange;
  final String laundryDay;

  LaundrySchedule({
    required this.roomRange,
    required this.laundryDay,
  });
}