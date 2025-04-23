import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/app/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/constants/color.dart';

class CustomCalender extends StatelessWidget {
  final calendarController = Get.find<HomeController>();

  CustomCalender({super.key});

  final Map<DateTime, List<String>> _events = {
    DateTime.now(): ['orange'],
    DateTime.now().subtract(Duration(days: 1)): ['orange', 'orange', 'orange'],
    DateTime.now().subtract(Duration(days: 5)): ['orange'],
    // ... (rest unchanged)
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedDay = calendarController.selectedDate.value;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                calendarController
                    .updateSelectedDate(selectedDay); // 👈 GetX update
              },
              eventLoader: (day) {
                return _events[DateTime(day.year, day.month, day.day)] ?? [];
              },
              // 📅 styling (same as yours)
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                leftChevronIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: AppColors.dimGreyColor),
                  ),
                  child: Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                rightChevronIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: AppColors.dimGreyColor),
                  ),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.grey, fontSize: 16),
                weekendStyle: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                outsideTextStyle: TextStyle(color: Colors.grey),
                defaultTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                weekendTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                selectedDecoration: BoxDecoration(
                  color: AppColors.appColor,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Colors.black, fontSize: 16),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: events.map((event) {
                        Color dotColor;
                        switch (event) {
                          case 'orange':
                            dotColor = Colors.orange;
                            break;
                          case 'green':
                            dotColor = Colors.green;
                            break;
                          case 'blue':
                            dotColor = Colors.blue;
                            break;
                          default:
                            dotColor = Colors.transparent;
                        }
                        return _buildDot(dotColor);
                      }).toList(),
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDot(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
