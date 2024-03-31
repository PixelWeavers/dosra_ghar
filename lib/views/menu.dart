import 'package:dosra_ghar/providers/menu_provider.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:dosra_ghar/widgets/mess_menu_card.dart';
import 'package:dosra_ghar/widgets/rating.dart';
import 'package:dosra_ghar/widgets/statistics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    /* final userProvider = Provider.of<UserProvider>(context);
    userProvider.setUser();
    final userType = userProvider.user?.userType ?? 'Unknown';
    if (kDebugMode) {
      print('usertype:$userType');
    }*/
    var userType = "Regular";
    List<dynamic>? lunch;

    final menuProvider = Provider.of<MMenuProvider>(context);
    menuProvider.fetchMenu("veg", "Wednesday", "lunch");
    final data = menuProvider.documentSnapshot?.data() as Map<String, dynamic>?;
    if (data != null) {
      lunch = data['lunch'] as List<dynamic>?;
    } else {
      print("Data not found");
    }

    /* final data = menuProvider.documentSnapshot?.data() as Map<String, dynamic>?;
    final breakfast = data?['breakfast'] as String? ?? "Loading..";
    final lunch = data?['lunch'] as String? ?? "Loading..";
    final dinner = data?['dinner'] as String? ?? "Loading..";
    final snacks = data?['dinner'] as String? ?? "Loading..";*/

    return Padding(
      padding: EdgeInsets.only(top: screenHeight / 50),
      child: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              'Mess Updates',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () {
                          if (userType == "Admin") {
                            //    Navigator.pushNamed(context, RoutesName.mMenu);
                          } else {
                            Utils.flushBarErrorMessage(
                                "You don't have access to add mess menu",
                                context);
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  )
                ],
              ),
              if (userType != "Admin")
                Center(
                  child: Image.asset(
                    'assets/images/aubfoof.gif',
                    width: 300,
                    height: 400,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              MessMenuCard(title: 'lunch', items: lunch),
              if (userType == "Admin")
                SizedBox(
                  height: screenHeight / 2.2,
                  width: screenWidth,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: StatisticsScreen(),
                  ),
                )
              else if (userType == "Regular")
                const RatingScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
