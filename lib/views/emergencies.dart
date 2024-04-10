import 'package:dosra_ghar/widgets/utiltiesGridItem.dart';
import 'package:flutter/material.dart';
import 'package:dosra_ghar/widgets/utiltiesGridItem.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergencies extends StatefulWidget {
  const Emergencies({super.key});

  @override
  State<Emergencies> createState() => _EmergenciesState();
}

class _EmergenciesState extends State<Emergencies> {
  @override
  Widget build(BuildContext context) {
    final servicesList = [
      UtilitiesGridItem(
          utilityName: "Contact Warden",
          svgUrl: "https://www.svgrepo.com/show/528452/phone-calling.svg"),
      UtilitiesGridItem(
          utilityName: "Contact Healthcentre",
          svgUrl: "https://www.svgrepo.com/show/503369/health.svg"),
      UtilitiesGridItem(
          utilityName: "Call Police",
          svgUrl: "https://www.svgrepo.com/show/407225/police-car-light.svg")
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Emergency Services",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Center(child: Text("Hello"));
                    },
                  );
                },
                icon: Icon(
                  Icons.emergency,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.black,
        body: ListView.separated(
          itemCount: servicesList.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  _launchCaller() async {
                    const url = "tel:1234567";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
                child: utilitiesGridItem(servicesList[index]));
          },
        ));
  }
}
