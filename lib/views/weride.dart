import 'package:dosra_ghar/models/weride_model.dart';
import 'package:dosra_ghar/widgets/dropdownitem.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class WeRide extends StatefulWidget {
  const WeRide({super.key});

  @override
  State<WeRide> createState() => _WeRideState();
}

class _WeRideState extends State<WeRide> {
  static const List<String> places = [
    "Campus",
    "Airport",
    "Vandlur",
    "Tambaram"
  ];
  String? selectedSource = "";
  String? selectedDestination = "";
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = const TimeOfDay(hour: 00, minute: 00);
  String? formattedTime;
  String? formattedDate;
  List<DropdownMenuItem<String>> dropdownPlaces = places.map((place) {
    return DropdownMenuItem<String>(
      value: place.substring(0, 3).toUpperCase(),
      child: Text(place),
    );
  }).toList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: const [],
        backgroundColor: Colors.black,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "We",
              style: GoogleFonts.londrinaSolid(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.amber,
                      fontSize: 32)),
            ),
            Text(
              "Ride",
              style: GoogleFonts.londrinaSolid(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.green[700],
                      fontSize: 32)),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.8,
                      child: const Center(
                        child: Text(
                          "Book Your Ride",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber),
                      height: size.height * 0.55,
                      width: size.width * 0.85,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                dropDownItem(dropdownPlaces, context, "Source",
                                    (value) {
                                  setState(() {
                                    selectedSource = value;
                                  });
                                }),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                const Text(
                                  "To",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                dropDownItem(
                                    dropdownPlaces, context, "Destination",
                                    (value) {
                                  setState(() {
                                    selectedDestination = value;
                                  });
                                }),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                const Text(
                                  "Time and Date",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GFButton(
                                    onPressed: () async {
                                      selectedTime =
                                          await showIntervalTimePicker(
                                              context: context,
                                              visibleStep:
                                                  VisibleStep.thirtieths,
                                              interval: 30,
                                              initialTime: selectedTime ??
                                                  TimeOfDay(
                                                      hour: 00, minute: 00));
                                      formattedTime =
                                          selectedTime!.format(context);
                                    },
                                    shape: GFButtonShape.standard,
                                    color: Colors.black,
                                    text: "Choose Time",
                                    elevation: 0,
                                    focusColor: Colors.black,
                                    textColor: Colors.white,
                                    size: 50,
                                    fullWidthButton: true,
                                    borderShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                            width: 2.5)),
                                    textStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: GFButton(
                                      onPressed: () async {
                                        selectedDate = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030, 12, 12));
                                        formattedDate = selectedDate
                                            .toString()
                                            .split(' ')
                                            .first;
                                      },
                                      shape: GFButtonShape.standard,
                                      color: Colors.black,
                                      text: "Choose Date",
                                      elevation: 0,
                                      focusColor: Colors.black,
                                      textColor: Colors.white,
                                      size: 50,
                                      fullWidthButton: true,
                                      borderShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: const BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2.5)),
                                      textStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ))
                              ],
                            ),
                          )
                        ],
                      )),
                ]),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
              height: size.height * 0.075,
              width: size.width * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.5),
                  shape: BoxShape.rectangle,
                  border: const Border.fromBorderSide(BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                      width: 2))),
              child: GFButton(
                onPressed: () {
                  if (selectedSource != selectedDestination) {
                    WeRideModel weRideModel = WeRideModel(
                        source: selectedSource,
                        destination: selectedDestination,
                        date: formattedDate,
                        time: formattedTime);
                    print(selectedSource);
                    print(selectedDestination);
                    print(formattedDate);
                    print(formattedTime);
                  } else if (selectedSource == "" ||
                      selectedDestination == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Source or Destination cannot be empty!")));
                  } else if (selectedSource == selectedDestination) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Source and Destination cannot be same!")));
                  }
                },
                shape: GFButtonShape.standard,
                color: Colors.amber,
                text: "Book Slot",
                textColor: Colors.black,
                size: 50,
                fullWidthButton: true,
                borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.5),
                    side: const BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.5)),
                textStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ))
        ],
      ),
    );
  }
}
