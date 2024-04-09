import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/views/chatScreen.dart';
import 'package:dosra_ghar/views/laundry.dart';
import 'package:dosra_ghar/widgets/utiltiesGridItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key});

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
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
        // Navigate to Issues page
        break;
      case "Lost/Found":
        // Navigate to Lost/Found page
        break;
      case "Counselling":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                ChatPage(email: currentUser!.accountType.toString())));
        break;
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
          children: List.generate(4, (index) {
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
