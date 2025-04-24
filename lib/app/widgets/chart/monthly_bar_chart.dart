import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/home_controller.dart';

import '../../data/models/daily_suppliment.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';

class WeeklyBarChart extends StatelessWidget {
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
              "Weekly Adherence",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100, // adherenceRate is in percentage
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        getTitlesWidget: (value, _) => Text(
                          '${value.toInt()}%',
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
                            return Text(
                              weeklyData[value.toInt()].day.substring(0, 3),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
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
    return data.asMap().entries.map((entry) {
      log("Key is ${entry.key} ${entry.value.total.toDouble()}");
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.adherenceRate.toDouble(),
            color: AppColors.appColor,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}
