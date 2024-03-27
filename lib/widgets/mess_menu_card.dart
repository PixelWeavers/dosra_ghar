/*
import 'package:flutter/material.dart';

class MessMenuCard extends StatelessWidget {
  final String lunch;
  final String dinner;
  final String breakfast;
  final String snacks;

  const MessMenuCard({
    super.key,
    required this.lunch,
    required this.dinner,
    required this.breakfast, 
    required this.snacks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Mess Menu 🍜",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Breakfast: $breakfast',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lunch: $lunch',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Snacks: $snacks',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
             Text(
              'Dinner: $dinner',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/import 'package:flutter/material.dart';

class MessMenuCard extends StatelessWidget {
  final String title;
  final List<dynamic>? items; // List to hold items for each category

  const MessMenuCard({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12), // Adjust padding as needed
      child: Container(
        width: double.infinity,
        child: Card(
         
          elevation: 4, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$title 🍜",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
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
