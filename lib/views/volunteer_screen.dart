import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/ngo.dart';
import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/ngo_provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/views/volunteerr_list_display.dart';
import 'package:dosra_ghar/widgets/ngo_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VolunteerScreen extends StatefulWidget {
  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  var ngo_name;
  var date;
  var time;

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    if (currentUser != null && currentUser.accountType == "student") {
      final userId = currentUser.regNo;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Volunteer for Food Rescue',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title and description section
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Help reduce food waste by volunteering for pick-up and distribution.',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16.0),
                // Display selected NGO card
                Consumer<VolunteerProvider>(
                  builder: (context, provider, _) {
                    return provider.selectedNgo == null
                        ? Container() // If no NGO is selected, don't display anything
                        : Column(
                            children: [
                              NgoCard(ngo: provider.selectedNgo!),
                              const SizedBox(height: 16.0),
                            ],
                          );
                  },
                ),
                // NGO selection section
                const Text('Select an NGO:'),
                Consumer<VolunteerProvider>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                      child: Container(
                        height: 50,
                        child: DropdownButton<Ngo>(
                          dropdownColor: const Color.fromARGB(255, 90, 89, 89),
                          style: GoogleFonts.poppins(color: Colors.white),
                          hint: Text("Select a NGO     ",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18)),
                          icon: const Icon(Icons.holiday_village_outlined,
                              color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          value: provider.selectedNgo,
                          onChanged: (ngo) {
                            Provider.of<VolunteerProvider>(context,
                                    listen: false)
                                .updateSelectedNgo(ngo!, ngo.name);
                          },
                          items: provider.ngoList
                              .map<DropdownMenuItem<Ngo>>((Ngo ngo) {
                            return DropdownMenuItem<Ngo>(
                              value: ngo,
                              child: Text(ngo.name),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                // Date selection section
                const Text('Select Date:'),
                Consumer<VolunteerProvider>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                      child: Container(
                        height: 50,
                        child: DropdownButton<String>(
                          dropdownColor: const Color.fromARGB(255, 90, 89, 89),
                          style: GoogleFonts.poppins(color: Colors.white),
                          hint: Text("Select a Date       ",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18)),
                          icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          value: provider.selectedDate,
                          onChanged: (date) {
                            Provider.of<VolunteerProvider>(context,
                                    listen: false)
                                .updateSelectedDate(date!);
                          },
                          items: provider.dateSlots
                              .map<DropdownMenuItem<String>>((date) {
                            return DropdownMenuItem<String>(
                              value: date,
                              child: Text(date),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                // Time selection section
                const Text('Select Time Slot:'),
                Consumer<VolunteerProvider>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(),
                        child: DropdownButton<String>(
                          dropdownColor: const Color.fromARGB(255, 90, 89, 89),
                          style: GoogleFonts.poppins(color: Colors.white),
                          hint: Text("Select Time Slot ",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18)),
                          icon: const Icon(Icons.access_time_outlined,
                              color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          value: provider.selectedTimeSlot,
                          onChanged: (timeSlot) {
                            Provider.of<VolunteerProvider>(context,
                                    listen: false)
                                .updateSelectedTimeSlot(timeSlot!);
                          },
                          items: provider.timeSlots
                              .map<DropdownMenuItem<String>>((timeSlot) {
                            return DropdownMenuItem<String>(
                              value: timeSlot,
                              child: Text(timeSlot),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                // Confirmation button
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                    ),
                    onPressed: () {
                      final volunteerProvider = Provider.of<VolunteerProvider>(
                          context,
                          listen: false);

                      ngo_name = volunteerProvider.ngoname.toString();
                      date = volunteerProvider.selectedDate;
                      time = volunteerProvider.selectedTimeSlot;
                      storeVolunteerData(
                          context, ngo_name, date, time, userId!);
                    }, // Pass context for provider access
                    child: const Text('Confirm Slot'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

void storeVolunteerData(
  BuildContext context,
  String ngoName,
  String selectedDate,
  String selectedTimeSlot,
  String regno,
) {
  FirebaseFirestore.instance.collection('volunteers').doc(ngoName).set({
    'ngo': ngoName,
    'regno': regno,
    'date': selectedDate,
    'time_slot': selectedTimeSlot,
    'timestamp': Timestamp.now(),
  }).then((value) {
    // Data stored successfully
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Volunteer data stored successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }).catchError((error) {
    // Error storing data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error storing volunteer data: $error'),
        backgroundColor: Colors.red,
      ),
    );
  });
}
