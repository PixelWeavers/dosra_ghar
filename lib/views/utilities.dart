import 'package:flutter/material.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key});

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Utilities",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: List.generate(6, (index) {
          // Generate 6 items for the grid
          return Center(
            child: Text(
              'Item $index',
              style: TextStyle(fontSize: 20),
            ),
          );
        }),
      ),
    );
  }
}
