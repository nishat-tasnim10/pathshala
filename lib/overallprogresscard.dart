import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class OverallProgressCard extends StatelessWidget {
  const OverallProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    double completed = 20;
    double total = 30;
    double percentage = (completed / total) * 100;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Overall Progress",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: -90,
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    sections: [
                      PieChartSectionData(
                        value: percentage,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2A6FD6),
                            Color(0xFF5B9CFF),
                          ],
                        ),
                        radius: 30,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 100 - percentage,
                        color: const Color(0xFFE8EDF5),
                        radius: 30,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${percentage.toInt()}%",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Completed",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "${completed.toInt()} / ${total.toInt()} Lessons Completed",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
