import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/menu_provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/views/caters_performance.dart';
import 'package:dosra_ghar/widgets/mess_menu_card.dart';
import 'package:dosra_ghar/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var userType = "Regular";
    List<dynamic>? lunch;

    final menuProvider = Provider.of<MMenuProvider>(context);
    menuProvider.fetchMenu("veg", "Monday", "lunch");
    final data = menuProvider.documentSnapshot?.data() as Map<String, dynamic>?;
    if (data != null) {
      lunch = data['lunch'] as List<dynamic>?;
    } else {
      print("Data not found");
    }
    return user.user?.accountType == "student"
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                'Mess Updates',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                    color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
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
                  MessMenuCard(title: 'Lunch', items: lunch),
                  if (userType == "Regular") const RatingScreen(),
                ],
              ),
            ),
          )
        : StatisticsScreen();
  }
}
