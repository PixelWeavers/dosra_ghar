import 'package:dosra_ghar/views/announcement.dart';
import 'package:dosra_ghar/views/menu.dart';
import 'package:dosra_ghar/views/profile.dart';
import 'package:dosra_ghar/views/weride.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  List<Widget> screenList = [
    Announcement(),
    Text("Event Page"),
    MenuScreen(),
    WeRide(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: IndexedStack(children: screenList, index: _selectedIndex),
        bottomNavigationBar: SafeArea(
          child: Theme(
            data: ThemeData(splashFactory: NoSplash.splashFactory),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.announcement_outlined),
                    label: "Announcements",
                    backgroundColor: Colors.black,
                    activeIcon: Icon(Icons.announcement_rounded)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.event_note_outlined),
                    label: "Events",
                    activeIcon: Icon(Icons.event_note_rounded),
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.food_bank_outlined),
                    activeIcon: Icon(Icons.food_bank_rounded),
                    label: "Mess",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_taxi_outlined),
                    activeIcon: Icon(
                      Icons.local_taxi_rounded,
                      color: Colors.amber,
                      applyTextScaling: true,
                    ),
                    label: "WeRide",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_4_outlined),
                    activeIcon: Icon(Icons.person_4_rounded),
                    label: "Profile",
                    backgroundColor: Colors.black),
              ],
              type: BottomNavigationBarType.shifting,
              elevation: 10,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 12,
              unselectedIconTheme: IconThemeData(color: Colors.grey, fill: 0.0),
              unselectedFontSize: 6,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
}
