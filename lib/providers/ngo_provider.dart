import 'package:dosra_ghar/models/ngo.dart';
import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {
  final List<Ngo> _ngoList = [
    const Ngo(
      logoUrl: 'https://www.ngo4you.com/wp-content/uploads/2023/10/Santham-Home-for-Aged-min.jpg',
      name: 'Food for All',
      description: 'Food for All works to fight hunger by rescuing surplus food and distributing it to those in need.',
    ),
    const Ngo(
      logoUrl: 'https://www.ngo4you.com/wp-content/uploads/2024/01/happiness-trust.png',
      name: 'Second Harvest',
      description: 'Second Harvest is committed to ending hunger and reducing food waste in the community.',
    ),
    const Ngo(
      logoUrl: 'https://www.ngo4you.com/wp-content/uploads/2023/10/Abdul-Kalam-Trust.png',
      name: 'Feeding America',
      description: 'Feeding America is a nationwide network of food banks working to end hunger.',
    ),
  ];

  final List<String> _dateSlots = [
    'April 10, 2024',
    'April 11, 2024',
    'April 12, 2024',
    // Add more date slots as needed
  ];

  final List<String> _timeSlots = [
    '9:00 AM - 11:00 AM',
    '11:00 AM - 1:00 PM',
    '1:00 PM - 3:00 PM',
    // Add more time slots as needed
  ];

  Ngo? _selectedNgo;
  String? _selectedDate;
  String? _selectedTimeSlot;

  List<Ngo> get ngoList => _ngoList;
  List<String> get dateSlots => _dateSlots;
  List<String> get timeSlots => _timeSlots;
   String? _ngoname;
  Ngo? get selectedNgo => _selectedNgo;
  String? get selectedDate => _selectedDate;
  String? get selectedTimeSlot => _selectedTimeSlot;
  String? get ngoname => _ngoname;
  void updateSelectedNgo(Ngo ngo, String ngoname) {
    _selectedNgo = ngo;
_ngoname = ngoname;
    notifyListeners();  // Notify listeners of state change
  }

  void updateSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();  // Notify listeners of state change
  }

  void updateSelectedTimeSlot(String timeSlot) {
    _selectedTimeSlot = timeSlot;
    notifyListeners();  // Notify listeners of state change
  }

  // Additional methods for interacting with volunteer data (optional)
}
