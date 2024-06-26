import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/views/chatScreen.dart';
import 'package:dosra_ghar/views/emergencies.dart';
import 'package:dosra_ghar/views/found_screen.dart';
import 'package:dosra_ghar/views/help_centre.dart';
import 'package:dosra_ghar/views/issues_view.dart';
import 'package:dosra_ghar/views/laundry.dart';
import 'package:dosra_ghar/views/lost_screeen.dart';
import 'package:dosra_ghar/views/volunteer_screen.dart';
import 'package:dosra_ghar/views/volunteerr_list_display.dart';
import 'package:dosra_ghar/widgets/utiltiesGridItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key});

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  final User? currentUserFirebase = FirebaseAuth.instance.currentUser;
  final List<UtilitiesGridItem> utilitiesGridList = [
    UtilitiesGridItem(
        utilityName: "Laundry",
        svgUrl: "https://www.svgrepo.com/show/287692/laundry-washer.svg"),
    UtilitiesGridItem(
        utilityName: "Issues",
        svgUrl: "https://www.svgrepo.com/show/205764/shipping-warning.svg"),
    UtilitiesGridItem(
        utilityName: "Lost/Found",
        svgUrl: "https://www.svgrepo.com/show/309781/missing-metadata.svg"),
    UtilitiesGridItem(
        utilityName: "Counselling",
        svgUrl: "https://www.svgrepo.com/show/525829/dialog-2.svg"),
    UtilitiesGridItem(
        utilityName: "Donate to NGOs",
        svgUrl: "https://www.svgrepo.com/show/194213/donate-donation.svg"),
    UtilitiesGridItem(
        utilityName: "Contact Services",
        svgUrl: "https://www.svgrepo.com/show/186956/red-cross.svg")
  ];
  void _navigateToUtilityPage(String utilityName) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    UserModel? currentUser = user.user;
    // Navigate to the corresponding utility page based on the utility name
    switch (utilityName) {
      case "Laundry":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LaundryPage()));
        break;
      case "Issues":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => IssueListScreen()));
        break;
      case "Lost/Found":
        if (currentUser!.accountType.toString() != 'admin')
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LostAndFoundScreen()));
        else
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => FoundScreen()));
        break;
      case "Counselling":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                ChatPage(email: currentUser!.accountType.toString())));
        break;
      case "Donate to NGOs":
        if (currentUser!.accountType != 'admin')
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => VolunteerScreen()));
        else
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => VolunteerListScreen()));
      case "Contact Services":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HelpCenterPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Utilities",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2, // Number of columns in the grid
          children: List.generate(6, (index) {
            // Generate 6 items for the grid
            return Center(
                child: GestureDetector(
                    onTap: () {
                      _navigateToUtilityPage(
                          utilitiesGridList[index].utilityName);
                    },
                    child: utilitiesGridItem(utilitiesGridList[index])));
          }),
        ),
      ),
    );
  }
}
