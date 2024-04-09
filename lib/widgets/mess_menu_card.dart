import 'package:flutter/material.dart';

class MessMenuCard extends StatelessWidget {
  final String title;
  final List<dynamic>? items; // List to hold items for each category

  const MessMenuCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18), // Adjust padding as needed
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        child: Card(
          
         color: Colors.white,
          elevation: 4, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "$title 🍜",
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                       color: Color.fromARGB(255, 140, 84, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (items != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items!
                        .map(
                          (item) => Text(
                            "•  ${item.toString()}", // Display each item in the list
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 140, 84, 0),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
