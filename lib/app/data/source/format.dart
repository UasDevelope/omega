import 'dart:ui';

import 'package:intl/intl.dart';

import '../../utils/constants/color.dart';

String getDayName(int day) {
  const days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  return days[day % 7];
}

Color statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'taken':
      return AppColors.successColor;
    case 'missed':
      return AppColors.errorColor;
    case 'pending':
    default:
      return AppColors.appColor;
  }
}

String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return 'N/A';
  try {
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM dd, yyyy – HH:mm').format(date);
  } catch (e) {
    return 'Invalid date';
  }
}
