import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

class LaundryPage extends StatefulWidget {
  const LaundryPage({Key? key}) : super(key: key);

  @override
  State<LaundryPage> createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  String backupToken = '';
  bool isCheckedIn = false;
  String clothes = '';
  String token = '';

  List<DateTime> availableDates = [
    DateTime(2024, 4, 1),
    DateTime(2024, 4, 5),
    DateTime(2024, 4, 10),
    DateTime(2024, 4, 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Laundry",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your next laundry is",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (!isCheckedIn)
                        Container(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            onChanged: (value) {
                              clothes = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Number of Clothes",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      if (!isCheckedIn)
                        Container(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            onChanged: (value) {
                              token = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Token Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      if (isCheckedIn)
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Your token number is $backupToken",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: GFButton(
                          onPressed: () {
                            if (isCheckedIn) {
                              // Check-out logic
                              setState(() {
                                isCheckedIn = false;
                              });
                            } else {
                              // Check-in logic
                              DateTime today = DateTime.now();
                              if (availableDates.contains(DateTime(
                                  today.year, today.month, today.day))) {
                                setState(() {
                                  isCheckedIn = true;
                                  backupToken = token;
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Not Available'),
                                    content: Text(
                                        'Laundry is only available on specific dates.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          color: Colors.black,
                          child: Text(isCheckedIn ? "Check-Out" : "Check-In"),
                          size: 50,
                          shape: GFButtonShape.square,
                          borderShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          fullWidthButton: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
