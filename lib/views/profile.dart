import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/views/auth_view.dart';
import 'package:dosra_ghar/views/chatScreen.dart';
import 'package:dosra_ghar/views/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    if (currentUser == null) {
      var screenSize = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Profile Banner (Short)
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 53, 53, 53),
              highlightColor: const Color.fromARGB(255, 114, 114, 114),
              child: Container(
                height: 150, // Adjust height as needed
                width: 400,
                margin: const EdgeInsets.all(20), // Fills entire width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black, // Adjust for desired background
                ),
              ),
            ),
            const SizedBox(height: 40), // Spacing between containers

            // Body (Tall)
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 53, 53, 53),
              highlightColor: const Color.fromARGB(255, 114, 114, 114),
              child: Container(
                height: 460,
                // Adjust height as needed
                width: 370,
                padding: const EdgeInsets.all(15), // Fills entire width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black, // Adjust for desired background
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      List<Widget> mess() {
        if (currentUser.messType == "Veg") {
          return [
            SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.network(
                    "https://www.svgrepo.com/show/235727/vegetables-salad.svg")),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Veg",
              softWrap: true,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 235, 231, 231),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ),
          ];
        } else if (currentUser.messType == "Non-Veg") {
          return [
            SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.network(
                    "https://www.svgrepo.com/show/297219/chicken.svg")),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Non-Veg",
              softWrap: true,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 235, 231, 231),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ),
          ];
        } else if (currentUser.messType == 'Special') {
          return [
            SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.network(
                  "https://www.svgrepo.com/show/484878/cupcake-illustration.svg"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Special",
              softWrap: true,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 235, 231, 231),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ),
          ];
        } else {
          return [const Text("data")];
        }
      }

      List<Widget> type() {
        if (currentUser.accountType == "student") {
          return [
            SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.network(
                    "https://www.svgrepo.com/show/474860/graduation-cap.svg")),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Student",
              softWrap: true,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 235, 231, 231),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ),
          ];
        } else if (currentUser.accountType == 'admin') {
          return [
            SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.network(
                    "https://www.svgrepo.com/show/263063/teacher-professor.svg")),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Faculty",
              softWrap: true,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                color: Color.fromARGB(255, 235, 231, 231),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ),
          ];
        } else {
          return [const Text("data")];
        }
      }

      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onLongPress: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => TestScreen()));
                },
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChatPage(
                              email: currentUser.accountType.toString())));
                    },
                    icon: const Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                    )),
              ),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const AuthView()),
                      (Route route) => route is AuthView);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("User signed out successfully")));
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(5),
                  height: 150,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(currentUser.profileUrl!),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 2,
                            softWrap: true,
                            currentUser.name!,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            softWrap: true,
                            currentUser.email!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          "Details",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.8)),
                    height: 460,
                    width: 370,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -0.5,
                                  color: Color.fromARGB(255, 75, 75, 75))
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Registration #",
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Text(
                                currentUser.regNo!,
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 235, 231, 231),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -0.5,
                                  color: Color.fromARGB(255, 75, 75, 75))
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Hostel",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: SvgPicture.network(
                                      "https://www.svgrepo.com/show/513283/building.svg",
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )
                                ],
                              ),
                              Row(children: [
                                Text(
                                  currentUser.hostelBlock.toString(),
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 235, 231, 231),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                              ])
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -0.5,
                                  color: Color.fromARGB(255, 75, 75, 75))
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Mess",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 50,
                                    child: SvgPicture.network(
                                        'https://www.svgrepo.com/show/486297/soup.svg'),
                                  )
                                ],
                              ),
                              Row(children: mess())
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -0.5,
                                  color: Color.fromARGB(255, 75, 75, 75))
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Account",
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Row(
                                children: type(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
  }
}
