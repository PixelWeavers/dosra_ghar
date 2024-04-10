import 'package:dosra_ghar/models/ngo.dart';
import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {
  final List<Ngo> _ngoList = [
    const Ngo(
      logoUrl: 'https://crowdwavetrust.org/blog/wp-content/uploads/2023/08/sri-arunodayam-logo.jpg',
      name: 'Sri Arunodayam',
      description: 'The Akshaya Patra Foundation is an Indian NGO headquartered in Bengaluru, Karnataka, with a mission to combat classroom hunger and support the education rights of children from disadvantaged socio-economic backgrounds '),
    
    const Ngo(
      logoUrl: 'https://crowdwavetrust.org/blog/wp-content/uploads/2023/08/dean-foundation-logo.jpg',
      name: 'Dean Foundation',
      description: 'DEAN Foundation is a compassionate organisation that serves the vulnerable and marginalised populations in Chennai, Tamil Nadu, India. They focus on providing palliative care to those suffering from terminal, incurable diseases like cancer and AIDS, particularly those with limited access to such care.',
    ),
    const Ngo(
      logoUrl: 'https://annamrita.org/wp-content/uploads/2023/01/new-logo-black.png',
      name: 'Annamrita',
      description: 'As an NGO, our values are deeply rooted into Indian traditions. Annamrita is a Sanskrit word that translates to Anna, “Food” and Amrita, “Nectar”; Food as pure as nectar.',
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
