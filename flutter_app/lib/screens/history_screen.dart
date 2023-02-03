import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static String id = "HistoryScreenID";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: const Text("Your History"),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffee9ca7), Color(0xffffdde1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Recovery Precentage",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade700,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "78%",
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.pink.shade700,
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 11,
                      minY: 1,
                      maxY: 10,
                      backgroundColor: Colors.grey[900],
                      titlesData: FlTitlesData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade200,
                              Colors.pink.shade400
                            ],
                          ),
                          barWidth: 5,
                          isCurved: true,
                          spots: const [
                            FlSpot(1, 2),
                            FlSpot(2, 5),
                            FlSpot(3, 5),
                            FlSpot(4, 3),
                            FlSpot(5, 8),
                            FlSpot(6, 4),
                            FlSpot(7, 3),
                            FlSpot(8, 3),
                            FlSpot(9, 5),
                            FlSpot(10, 9),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
