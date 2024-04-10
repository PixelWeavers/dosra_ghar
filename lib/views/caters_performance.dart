import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/rating.dart';
import 'package:dosra_ghar/providers/menu_provider.dart';
import 'package:dosra_ghar/widgets/mess_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late List<Rating> _ratings;
  late List<_DataPoint> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = [];
    _fetchRatings();
  }

  void _fetchRatings() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
   final snapshot = await FirebaseFirestore.instance
    .collection('ratings')
    .get();
print("Fetched Documents: ${snapshot.docs.length}");
    setState(() {
      _ratings = snapshot.docs.map((doc) {
        final data = doc.data();
        return Rating(
          userId: data['userId'],
          rating: data['rating'].toDouble(),
          timestamp: data['timestamp'], feedback: data['feedback'],
        );
      }).toList();
      print(_ratings);

      _chartData = _calculateStatistics(_ratings);
    });
  }

  List<_DataPoint> _calculateStatistics(List<Rating> ratings) {
    final statistics = <String, double>{};

    for (final rating in ratings) {
      final id = rating.userId;

      if (statistics.containsKey(id)) {
        statistics[id] = (statistics[id]! + rating.rating) / 2;
      } else {
        statistics[id] = rating.rating;
      }
    }

    return statistics.entries.map((entry) {
      return _DataPoint(entry.key, entry.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic>? lunch;

    final menuProvider = Provider.of<MMenuProvider>(context);
    menuProvider.fetchMenu("veg", "Monday", "lunch");
    final data = menuProvider.documentSnapshot?.data() as Map<String, dynamic>?;
    if (data != null) {
      lunch = data['lunch'] as List<dynamic>?;
    } else {
      print("Data not found");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title:  const Text(
                    "Today's Mess Rating",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            
          ),
          child: _chartData.isNotEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             MessMenuCard(title: 'Lunch', items: lunch),
                   
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      backgroundColor: Colors.white,
                      series: <CartesianSeries>[
                        ColumnSeries<_DataPoint, String>(
                          dataSource: _chartData,
                          xValueMapper: (_DataPoint data, _) => data.date,
                          yValueMapper: (_DataPoint data, _) => data.rating,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    "No Ratings Till Now😴",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _DataPoint {
  final String date;
  final double rating;

  _DataPoint(this.date, this.rating);
}