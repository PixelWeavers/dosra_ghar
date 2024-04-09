import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final void Function(BuildContext, DateTime) onDateSelected;
  final void Function(BuildContext, TimeOfDay) onTimeSelected;

  const DateTimePicker({required this.onDateSelected, required this.onTimeSelected});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool _isSunday(DateTime date) {
    return date.weekday == DateTime.sunday; // Check if it's Sunday
  }

  void handleDateSelection(DateTime? date) {
    if (date != null && _isSunday(date)) { // Only if Sunday
      setState(() {
        selectedDate = date;
        print(date);
      });
      widget.onDateSelected(context, date);
    }
  }


  void handleTimeSelection(TimeOfDay? time) {
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
      widget.onTimeSelected(context, time); // Call callback function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            side: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
            fixedSize: const Size(150, 50),
          ),
          onPressed: () => showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime.now(), // From today
            lastDate: DateTime.now().add(Duration(days: 60)), // Next 2 months
          ).then(handleDateSelection),
          child: Text(selectedDate?.toString() ?? 'Select Date'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            side: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
            fixedSize: const Size(150, 50),
          ),
          onPressed: () => showTimePicker(
            context: context,
            initialTime: selectedTime ?? TimeOfDay.now(),
          ).then(handleTimeSelection),
          child: Text(selectedTime?.format(context) ?? 'Select Time'),
        ),
      ],
    );
  }
}
