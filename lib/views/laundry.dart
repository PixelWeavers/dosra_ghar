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
              Consumer<LaundryProvider>(
                builder: (context, laundryProvider, _) {
                  return Container(
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
                          if (!laundryProvider.isCheckedIn)
                            Container(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                controller: clothesController,
                                decoration: InputDecoration(
                                  hintText: "Number of Clothes",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          if (!laundryProvider.isCheckedIn)
                            Container(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                controller: tokenController,
                                decoration: InputDecoration(
                                  hintText: "Token Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (laundryProvider.isCheckedIn)
                                FutureBuilder<String>(
                                  future: laundryProvider.getLaundryToken(),
                                  builder: (context, tokenSnapshot) {
                                    if (tokenSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (tokenSnapshot.hasError) {
                                      return Text(
                                          'Error: ${tokenSnapshot.error}');
                                    } else {
                                      return Center(
                                        child: Text(
                                          "Your token number is ${tokenSnapshot.data}",
                                          style: TextStyle(
                                            fontSize: 26,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              if (laundryProvider.isCheckedIn)
                                FutureBuilder<String>(
                                  future: laundryProvider.getLaundryNoClothes(),
                                  builder: (context, clothesSnapshot) {
                                    if (clothesSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (clothesSnapshot.hasError) {
                                      return Text(
                                          'Error: ${clothesSnapshot.error}');
                                    } else {
                                      return Text(
                                        "Number of Clothes: ${clothesSnapshot.data}",
                                        style: TextStyle(
                                          fontSize: 26,
                                        ),
                                      );
                                    }
                                  },
                                ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: GFButton(
                              onPressed: () async {
                                if (laundryProvider.isCheckedIn) {
                                  // Check-out logic
                                  await laundryProvider.addLaundryCheckIn(
                                    LaundryModel(
                                      noClothes: clothesController.text,
                                      token: tokenController.text,
                                      isCheckIn: false,
                                      date: DateTime.now(),
                                      uid: currentUser?.uid ?? '',
                                    ),
                                  );
                                } else {
                                  // Check-in logic
                                  await laundryProvider.addLaundryCheckIn(
                                    LaundryModel(
                                      noClothes: clothesController.text,
                                      token: tokenController.text,
                                      isCheckIn: true,
                                      date: DateTime.now(),
                                      uid: currentUser?.uid ?? '',
                                    ),
                                  );
                                }
                              },
                              color: Colors.black,
                              child: Text(laundryProvider.isCheckedIn
                                  ? "Check-Out"
                                  : "Check-In"),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
