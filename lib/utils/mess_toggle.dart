/*import 'package:flutter/material.dart';

class MealAttendanceToggle extends StatefulWidget {
  final String mealId; // ID of the meal
  final MealProvider mealProvider; // Instance of MealProvider

  const MealAttendanceToggle({Key? key, required this.mealId, required this.mealProvider}) : super(key: key);

  @override
  State<MealAttendanceToggle> createState() => _MealAttendanceToggleState();
}

class _MealAttendanceToggleState extends State<MealAttendanceToggle> {
  bool _isAttending = true; // Default value (true)

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
         Icon(Icons.check, color: Colors.green),
         Icon(Icons.close, color: Colors.red),
      ],
      isSelected: [_isAttending],
      onPressed: (selectedIndex) {
        setState(() {
          _isAttending = !_isAttending;
          if (!_isAttending) {
            widget.mealProvider.updateTotalStudentsForMeal(widget.mealId, false);
          }
        });
      },
    );
  }
}*/
