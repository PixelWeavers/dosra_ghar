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
 /* void updateTotalStudentsForMeal(MealProvider mealProvider, String mealId, bool attending) async {
  // Fetch the meal by ID (assuming you have a method in MealProvider)
  final meal = await mealProvider.getMeal(mealId);

  if (meal != null) {
    // Update totalStudents based on attending flag
    meal.totalStudents = attending ? meal.totalStudents + 1 : meal.totalStudents - 1;

    // Ensure the total is not negative (handle edge case)
    meal.totalStudents = meal.totalStudents.clamp(0, int.max); // Clamps to 0 (min) and int.max (max)

    // Update the meal in the data source (assuming you have an updateMeal method in MealProvider)
    await mealProvider.updateMeal(meal);
  } else {
    print("Error: Meal not found with ID: $mealId");
  }
}*/
 bool _hasMarkedAttendance = false;
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var userType = currentUser?.accountType;
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
               actions: [
                ToggleButtons(
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    Icon(Icons.close, color: Colors.red),
                  ],
                  isSelected: [true , false], // Default selection: attending (true)
                 onPressed: (selectedIndex) {
  if (!_hasMarkedAttendance) {
    setState(() {
      _hasMarkedAttendance = true; // Mark attendance
      if (selectedIndex == 1) {
        menuProvider.updateStudents(false);
      }
    });

    
  } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User has already marked attendance.'),
          ),
        );
  }
},
                ),
              ],
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
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Planning your day? Let us know if you'll be joining us for a meal.", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 28),),
                    ),
                  MessMenuCard(title: 'Lunch', items: lunch),
                  if (userType != "Admin") const RatingScreen(),
                ],
              ),
            ),
          )
        : StatisticsScreen();
  }
}
