import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/home_controller.dart';
import 'package:omega/app/views/progress/progress_view.dart';

import '../../data/models/daily_suppliment.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';

class WeeklyBarChart extends StatelessWidget {
  final bool isProgress;
  WeeklyBarChart({super.key, this.isProgress = false});
  final HomeController controller =
      Get.find(); // assuming controller is registered

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weeklyData =
          controller.dailySupplements.value?.data.dailyData ?? [];

      return Container(
        height: AppSize.getHeight(30),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Weekly Supplements",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxY(weeklyData), // adherenceRate is in percentage
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (event is FlTapUpEvent &&
                          response != null &&
                          response.spot != null) {
                        if (!isProgress) {
                          Get.to(ProgressView());
                          log('progress clicked');
                        }
                      }
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: _getInterval(weeklyData),
                        getTitlesWidget: (value, _) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, _) {
                          if (value.toInt() < weeklyData.length) {
                            final item = weeklyData[value.toInt()];
                            final date = DateTime.parse(item.date);
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item.day.substring(0, 3), // e.g., Mon
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                                Text(
                                  '${date.day}', // Show the day number
                                  style: const TextStyle(
                                      fontSize: 8.7, color: Colors.grey),
                                ),
                              ],
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _getBarGroups(weeklyData),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<BarChartGroupData> _getBarGroups(List<DailyEntry> data) {
    //
    return data.asMap().entries.map((entry) {
      log("Key is ${entry.key} ${entry.value.total.toDouble()}");
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.total.toDouble(),
            color: AppColors.appColor,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  double _getMaxY(List<DailyEntry> data) {
    if (data.isEmpty) return 1;

    final maxTotal = data.map((e) => e.total).reduce((a, b) => a > b ? a : b);

    // Add some padding (e.g. 20% higher for better scaling)
    return (maxTotal * 1.2).ceilToDouble();
  }

  double _getInterval(List<DailyEntry> data) {
    final max = _getMaxY(data);
    if (max <= 2) return 1;
    if (max <= 5) return 1;
    if (max <= 10) return 2;
    return (max / 5).ceilToDouble(); // for bigger numbers
  }
}
