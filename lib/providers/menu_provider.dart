import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MMenuProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _documentSnapshot;
List _menu =[];
int _totalStudents = 500;
int get totalStudents =>_totalStudents;
Future<void> fetchMenu(String messType, String day, String meal) async {
  try {
   
    _documentSnapshot = await firestore
        .collection('mess')
        .doc(messType)
        .collection('menu')
        .doc(day)
        .get();

    if (_documentSnapshot != null) {
      // Directly assign the retrieved array to _menu
      _menu = _documentSnapshot!.get(meal) as List<dynamic>;

      // Notify listeners after fetching the menu
      notifyListeners();
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  }
}

void updateStudents(bool flag){
    _totalStudents = _totalStudents - 1;
    firestore.collection('attendance').add({
    'totalStudents':_totalStudents
    });
    notifyListeners();
}

  DocumentSnapshot? get documentSnapshot => _documentSnapshot;
}

  // Fetching the menu according to the days
  /*Future<void> fetchMenu() async {
    // Fetching the current date and time
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    String dayName = '';

    switch (currentDayOfWeek) {
      case 1:
        dayName = 'Monday';
        break;
      case 2:
        dayName = 'Tuesday';
        break;
      case 3:
        dayName = 'Wednesday';
        break;
      case 4:
        dayName = 'Thursday';
        break;
      case 5:
        dayName = 'Friday';
        break;
      case 6:
        dayName = 'Saturday';
        break;
      case 7:
        dayName = 'sunday';
        break;
      default:
        dayName = 'Unknown';
        break;
    }

    try {
      _documentSnapshot =
      await firestore.collection('Mess').doc(dayName).get();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }*/

